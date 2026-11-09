import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cash/ensure_open.dart';
import '../data/cash_box.dart';
import '../data/cash_box_provider.dart';
import '../data/catalog_provider.dart';
import '../data/expense_category.dart';
import 'purchase_form.dart';

/// The whole "اشتريت" flow: the form, then the stock goes up, then the money is written down as an
/// expense linked to the purchase (so there is one place to look, and the cash count still
/// matches). From the cash box: it asks to open one if none is. From a pocket: the drawer is not
/// touched and, if the person is not an Admin, the shop now owes them.
Future<void> buyStock(BuildContext context, WidgetRef ref) async {
  // Read everything that needs the widget before the first await: it may be gone after it.
  final catalog = ref.read(catalogProvider.notifier);
  final cash = ref.read(cashBoxProvider.notifier);
  final result = await showPurchaseForm(context, ref.read(catalogProvider).stockItems);
  if (result == null) return;
  if (result.paidFrom == PaidFrom.cashBox) {
    if (!context.mounted) return;
    if (!await ensureCashBoxOpen(context, ref)) return;
  }
  final purchase = catalog.recordPurchase(result.lines);
  if (purchase == null || purchase.total <= 0) return; // nothing to write down for a gift
  cash.addMovement(
    CashMovementType.expense,
    purchase.total,
    purchaseId: purchase.id,
    categoryId: ExpenseCategoryIds.stock,
    paidFrom: result.paidFrom,
  );
}
