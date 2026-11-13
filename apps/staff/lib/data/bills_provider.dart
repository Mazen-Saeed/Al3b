import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_log.dart';
import 'bill.dart';
import 'cash_box_provider.dart';
import 'catalog_provider.dart';
import 'ids.dart';
import 'product.dart';
import 'orders_provider.dart';
import 'staff_provider.dart';
import 'units_provider.dart';

/// The bills when the app starts: loaded from the database at startup. Tests replace it.
final initialBillsProvider = Provider<List<Bill>>((ref) => const []);

/// Paid bills, oldest first (the cash box and reports read these later).
class BillsNotifier extends Notifier<List<Bill>> {
  @override
  List<Bill> build() => ref.watch(initialBillsProvider);

  /// No payment without an open cash box (#5, #53). The screens ask staff to open one first; this
  /// stops any other code path from taking money into nothing.
  void _requireOpenCashBox() {
    if (ref.read(cashBoxProvider).open == null) throw StateError('No cash box is open');
  }

  /// Ends the session on [unitId] and saves its bill. [endedAt] is the moment the checkout
  /// form opened (the amount staff saw). A discount is clamped between 0 and the subtotal.
  /// The unit's order lines are forgotten and the unit is free again.
  Bill endAndPay(
    String unitId, {
    required DateTime endedAt,
    int discount = 0,
    String? discountReason,
    required PaymentMethod method,
  }) {
    _requireOpenCashBox();
    final unit = ref.read(unitsProvider).byId(unitId);
    final lines = ref.read(ordersProvider).forUnit(unitId);
    final playCost = unit.costAt(endedAt);
    final subtotal = playCost + lines.fold<int>(0, (sum, line) => sum + line.total);

    final bill = Bill(
      id: newId(),
      sessionId: unit.sessionId,
      paidAt: DateTime.now(),
      unitId: unit.id,
      unitName: unit.name,
      startedAt: unit.startedAt!,
      endedAt: endedAt,
      isMulti: unit.isMulti,
      hourlyPrice: unit.isMulti ? unit.multiHourlyPrice! : unit.hourlyPrice,
      playCost: playCost,
      lines: lines,
      discount: math.min(math.max(discount, 0), subtotal),
      discountReason: discountReason,
      method: method,
      cashBoxId: ref.read(cashBoxProvider).open?.id,
      takenById: ref.read(currentStaffIdProvider),
    );
    state = [...state, bill];
    ref.read(ordersProvider.notifier).clear(unitId);
    ref.read(unitsProvider.notifier).free(unitId);
    final log = ref.read(activityLogProvider.notifier);
    if (bill.total == 0) {
      log.record(ActivityKind.sessionZeroCost, suspicious: true, details: {'unit': unit.name, 'discount': bill.discount});
    } else if (bill.discount > 0) {
      log.record(
        ActivityKind.discountGiven,
        suspicious: bill.discount >= largeDiscountLimit,
        details: {'unit': unit.name, 'amount': bill.discount, 'subtotal': subtotal, 'reason': discountReason},
      );
    }
    return bill;
  }

  /// Changes what a paid bill took, in the cash box that is still open (a closed one was counted already).
  /// [newTotal] goes from 0 up to the calculated price (the subtotal): the difference is kept as the discount.
  /// The old and new amounts and the reason are written to the log, and it is flagged when 50 EGP or more
  /// less is taken than before.
  void correct(String billId, {required int newTotal, required String reason}) {
    final open = ref.read(cashBoxProvider).open;
    final bill = state.firstWhere((b) => b.id == billId);
    if (open == null || bill.cashBoxId != open.id) throw StateError('Only a bill of the open cash box can be corrected');
    final total = math.min(math.max(newTotal, 0), bill.subtotal);
    if (total == bill.total) return;
    state = [for (final b in state) if (b.id == billId) bill.withDiscount(bill.subtotal - total) else b];
    ref.read(activityLogProvider.notifier).record(
      ActivityKind.billCorrected,
      suspicious: bill.total - total >= largeDiscountLimit,
      details: {'unit': bill.unitName, 'old': bill.total, 'new': total, 'subtotal': bill.subtotal, 'reason': reason},
    );
  }

  /// Sells products to someone who is not playing. [quantities]: product id -> how many. The
  /// bill is saved paid at once, and products counted in stock come off the shelf. Nothing is
  /// saved for an empty sale.
  Bill? quickSale(Map<String, int> quantities, {required PaymentMethod method}) {
    _requireOpenCashBox();
    final catalog = ref.read(catalogProvider.notifier);
    final products = ref.read(catalogProvider).products;
    final lines = <OrderLine>[];
    quantities.forEach((productId, quantity) {
      if (quantity <= 0) return;
      final product = products.firstWhere((p) => p.id == productId);
      catalog.sellFromStock(productId, quantity);
      lines.add(OrderLine(
        productId: product.id,
        name: product.name,
        unitPrice: product.price,
        quantity: quantity,
        orderedAt: DateTime.now(),
      ));
    });
    if (lines.isEmpty) return null;
    final bill = Bill.quickSale(
      id: newId(),
      at: DateTime.now(),
      lines: lines,
      method: method,
      cashBoxId: ref.read(cashBoxProvider).open?.id,
      takenById: ref.read(currentStaffIdProvider),
    );
    state = [...state, bill];
    return bill;
  }
}

final billsProvider = NotifierProvider<BillsNotifier, List<Bill>>(BillsNotifier.new);
