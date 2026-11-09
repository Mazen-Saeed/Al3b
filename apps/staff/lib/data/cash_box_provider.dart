import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bill.dart';
import 'bills_provider.dart';
import 'cash_box.dart';
import 'expense_category.dart';
import 'ids.dart';
import 'staff_provider.dart';

/// Every cash box so far (the last one may be open) and everything recorded in them.
class CashBoxState {
  const CashBoxState({this.boxes = const [], this.movements = const []});

  final List<CashBox> boxes; // oldest first
  final List<CashMovement> movements;

  /// The open cash box, if there is one. There is never more than one.
  CashBox? get open {
    for (final box in boxes) {
      if (box.isOpen) return box;
    }
    return null;
  }

  /// The cash box closed most recently, if any.
  CashBox? get lastClosed {
    for (final box in boxes.reversed) {
      if (!box.isOpen) return box;
    }
    return null;
  }

  List<CashMovement> movementsOf(String cashBoxId) => movements.where((m) => m.cashBoxId == cashBoxId).toList();

  /// What the shop owes each person who paid something from their own pocket: staff id -> piasters.
  Map<String, int> get owed {
    final result = <String, int>{};
    for (final m in movements) {
      if (m.isOwed) result[m.staffId] = (result[m.staffId] ?? 0) + m.amount;
    }
    return result;
  }
}

/// The numbers of one shift (cash box): what should be in the drawer and how it adds up, plus what
/// was paid outside the drawer.
class ShiftSummary {
  const ShiftSummary({
    required this.openingCash,
    required this.cashSales,
    required this.cashIn,
    required this.expenses,
    required this.withdrawals,
    required this.instapay,
    required this.wallet,
  });

  final int openingCash;
  final int cashSales; // bills paid in cash
  final int cashIn;
  final int expenses; // taken out of the drawer (a pocket-paid expense is not here)
  final int withdrawals; // owner withdrawals
  final int instapay; // bills paid by InstaPay: never in the drawer
  final int wallet; // bills paid by wallet: never in the drawer

  /// What should be in the drawer: start + cash sales + cash in - expenses - owner withdrawals.
  int get expected => openingCash + cashSales + cashIn - expenses - withdrawals;
}

/// Where the cash boxes start. Empty in the app; tests start with a box already open.
final initialCashBoxProvider = Provider<CashBoxState>((ref) => const CashBoxState());

class CashBoxNotifier extends Notifier<CashBoxState> {
  @override
  CashBoxState build() => ref.read(initialCashBoxProvider);

  /// Whether the person using the app may record movements and close: the cashier of the open
  /// cash box, or an Admin (#36).
  bool get canHandle {
    final open = state.open;
    final staff = ref.read(currentStaffProvider);
    if (open == null || staff == null) return false;
    return staff.isAdmin || staff.id == open.openedById;
  }

  /// Opens a cash box with [openingCash] piasters in it. The person using the app becomes the cashier.
  CashBox open(int openingCash) {
    final staff = ref.read(currentStaffProvider);
    if (staff == null) throw StateError('Nobody is signed in');
    if (state.open != null) throw StateError('A cash box is already open');
    final box = CashBox(id: newId(), openedAt: DateTime.now(), openedById: staff.id, openingCash: openingCash);
    state = CashBoxState(boxes: [...state.boxes, box], movements: state.movements);
    return box;
  }

  /// Records an expense, cash in or owner withdrawal. An expense can come from the cash box (needs an
  /// open one, and the cashier or an Admin) or from the person's own pocket (anyone; the drawer is
  /// not touched, and if the person is not an Admin the shop now owes them).
  CashMovement addMovement(
    CashMovementType type,
    int amount, {
    String? note,
    String? purchaseId,
    String? categoryId, // what an expense was for; "أخرى" when not given
    PaidFrom paidFrom = PaidFrom.cashBox,
  }) {
    final box = state.open;
    final staff = ref.read(currentStaffProvider);
    if (staff == null) throw StateError('Nobody is signed in');
    if (amount <= 0) throw ArgumentError('The amount must be above 0');
    if (paidFrom == PaidFrom.pocket && type != CashMovementType.expense) {
      throw ArgumentError('Only an expense can be paid from a pocket');
    }
    if (paidFrom == PaidFrom.cashBox) {
      if (box == null) throw StateError('No cash box is open');
      if (!canHandle) throw StateError('Only the cashier or an Admin can do this');
    }
    final movement = CashMovement(
      id: newId(),
      cashBoxId: box?.id,
      type: type,
      amount: amount,
      staffId: staff.id,
      at: DateTime.now(),
      note: note,
      paidFrom: paidFrom,
      owed: paidFrom == PaidFrom.pocket && !staff.isAdmin,
      purchaseId: purchaseId,
      categoryId: type == CashMovementType.expense ? (categoryId ?? ExpenseCategoryIds.other) : null,
    );
    state = CashBoxState(boxes: state.boxes, movements: [...state.movements, movement]);
    return movement;
  }

  /// The shop paid [staffId] back what it owed them. [from] says where that money came from: the
  /// cash box (an expense is recorded in it, so the count still matches) or outside it (nothing
  /// changes in the box). Returns how much was paid back.
  int settleOwed(String staffId, PaidFrom from, {String? note}) {
    final owedItems = state.movements.where((m) => m.isOwed && m.staffId == staffId).toList();
    final total = owedItems.fold<int>(0, (sum, m) => sum + m.amount);
    if (total == 0) return 0;
    if (from == PaidFrom.cashBox) {
      addMovement(CashMovementType.expense, total, note: note, categoryId: ExpenseCategoryIds.repayment); // checks the cash box is open and ours
    }
    final now = DateTime.now();
    state = CashBoxState(
      boxes: state.boxes,
      movements: [for (final m in state.movements) m.isOwed && m.staffId == staffId ? m.reimbursed(now) : m],
    );
    return total;
  }

  /// The numbers of [box]: how its expected cash adds up, and what came in by InstaPay and wallet.
  ShiftSummary summaryOf(CashBox box) {
    final bills = ref.read(billsProvider).where((b) => b.cashBoxId == box.id);
    int billsBy(PaymentMethod m) => bills.where((b) => b.method == m).fold(0, (sum, b) => sum + b.total);
    int moved(CashMovementType type) => state
        .movementsOf(box.id)
        .where((m) => m.type == type && m.paidFrom == PaidFrom.cashBox) // a pocket expense never touched the drawer
        .fold(0, (sum, m) => sum + m.amount);
    return ShiftSummary(
      openingCash: box.openingCash,
      cashSales: billsBy(PaymentMethod.cash),
      cashIn: moved(CashMovementType.cashIn),
      expenses: moved(CashMovementType.expense),
      withdrawals: moved(CashMovementType.ownerWithdrawal),
      instapay: billsBy(PaymentMethod.instapay),
      wallet: billsBy(PaymentMethod.wallet),
    );
  }

  /// What should be in the open cash box now: the starting cash, plus bills paid in cash, plus
  /// cash in, minus expenses and owner withdrawals. InstaPay and wallet bills never count.
  int expectedCash(CashBox box) => summaryOf(box).expected;

  /// Closes the open cash box with what was counted. The expected amount is worked out now and
  /// kept. Returns the closed box (it holds the difference).
  CashBox close(int counted, {String? note}) {
    final box = state.open;
    final staff = ref.read(currentStaffProvider);
    if (box == null) throw StateError('No cash box is open');
    if (!canHandle) throw StateError('Only the cashier or an Admin can do this');
    final closed = box.closed(
      at: DateTime.now(),
      byId: staff!.id,
      expected: expectedCash(box),
      counted: counted,
      note: note,
    );
    state = CashBoxState(
      boxes: [for (final b in state.boxes) b.id == box.id ? closed : b],
      movements: state.movements,
    );
    return closed;
  }
}

final cashBoxProvider = NotifierProvider<CashBoxNotifier, CashBoxState>(CashBoxNotifier.new);
