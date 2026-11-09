/// Money in or out of the cash box that is not a bill. (A bill paid in cash counts by itself.)
enum CashMovementType { expense, cashIn, ownerWithdrawal }

/// Where the money for an expense came from. Two answers, so it is one tap for staff.
enum PaidFrom {
  cashBox, // out of the drawer: it changes how much should be in the cash box
  pocket, // from someone's own pocket: the drawer is not touched. If that person is not an Admin the
  // shop owes them the money until it is paid back.
}

class CashMovement {
  const CashMovement({
    required this.id,
    this.cashBoxId,
    required this.type,
    required this.amount,
    required this.staffId,
    required this.at,
    this.note,
    this.paidFrom = PaidFrom.cashBox,
    this.owed = false,
    this.reimbursedAt,
    this.purchaseId,
    this.categoryId,
  });

  final String id;
  final String? cashBoxId; // the cash box it was recorded in; null for something paid from a pocket with none open
  final CashMovementType type;
  final int amount; // piasters, always above 0; the type says if it comes in or goes out
  final String staffId; // who recorded it
  final DateTime at;
  final String? note; // the reason
  final PaidFrom paidFrom; // only expenses can be paid from a pocket
  final bool owed; // paid from the pocket of someone the shop must pay back (staff who is not an Admin)
  final DateTime? reimbursedAt; // when the shop paid that person back
  final String? purchaseId; // set when it was made by a stock purchase (#53)
  final String? categoryId; // what an expense was for (an expense category); null for cash in and owner withdrawals

  /// What this does to the cash in the box: plus for cash in, minus for the other two, nothing for
  /// an expense paid from a pocket.
  int get signedAmount {
    if (paidFrom == PaidFrom.pocket) return 0;
    return type == CashMovementType.cashIn ? amount : -amount;
  }

  /// Still waiting to be paid back to [staffId].
  bool get isOwed => owed && reimbursedAt == null;

  CashMovement reimbursed(DateTime at) => CashMovement(
        id: id,
        cashBoxId: cashBoxId,
        type: type,
        amount: amount,
        staffId: staffId,
        at: this.at,
        note: note,
        paidFrom: paidFrom,
        owed: owed,
        reimbursedAt: at,
        purchaseId: purchaseId,
        categoryId: categoryId,
      );
}

/// One cash box (الخزينة): a period of cash in one shared box, from opening (starting cash) to
/// closing (count and difference). The schema calls it a shift. Whoever opened it is the cashier.
class CashBox {
  const CashBox({
    required this.id,
    required this.openedAt,
    required this.openedById,
    required this.openingCash,
    this.closedAt,
    this.closedById,
    this.expectedCash,
    this.countedCash,
    this.note,
  });

  final String id;
  final DateTime openedAt;
  final String openedById; // the cashier
  final int openingCash; // piasters in the box when it was opened

  // Set when it is closed. expectedCash is a snapshot worked out at that moment.
  final DateTime? closedAt;
  final String? closedById;
  final int? expectedCash;
  final int? countedCash;
  final String? note;

  bool get isOpen => closedAt == null;

  /// Counted minus expected: above 0 = extra cash, below 0 = cash is missing. Null while open.
  int? get difference => (countedCash == null || expectedCash == null) ? null : countedCash! - expectedCash!;

  CashBox closed({
    required DateTime at,
    required String byId,
    required int expected,
    required int counted,
    String? note,
  }) =>
      CashBox(
        id: id,
        openedAt: openedAt,
        openedById: openedById,
        openingCash: openingCash,
        closedAt: at,
        closedById: byId,
        expectedCash: expected,
        countedCash: counted,
        note: note,
      );
}
