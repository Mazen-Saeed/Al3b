import '../bill.dart';
import '../product.dart';
import 'app_database.dart';
import 'unit_mapper.dart';

// The mapper between a Bill and its rows (decision #65). Plain functions, like unit_mapper.dart.
//
// A bill is one bills row plus one bill_items row per line: the play time (no product; its description
// is the device's name) and then every drink. Everything else the screens know about a session bill
// (when it started, which device, single or pair, at what price) is in its session's rows.

/// The rows of one bill.
class BillRows {
  const BillRows({required this.bill, required this.items});

  final BillRow bill;
  final List<BillItemRow> items;
}

String _pascal(Enum e) => e.name[0].toUpperCase() + e.name.substring(1);

/// The rows to save for [bill]. A bill is written once and never rewritten.
BillRows billToRows(Bill bill, {required String venueId, required DateTime now}) {
  final staffId = bill.takenById;
  final shiftId = bill.cashBoxId;
  if (staffId == null || shiftId == null) {
    // The backend requires both. The app only takes payment with a cash box open and someone signed in.
    throw StateError('Bill ${bill.id} has no cashier or no cash box.');
  }

  BillItemRow item(int index, {String? productId, required String description, required int quantity, required int unitPrice}) =>
      BillItemRow(
        updatedAt: now,
        updatedByStaffId: staffId,
        id: billItemRowId(bill.id, index),
        venueId: venueId,
        billId: bill.id,
        productId: productId,
        description: description,
        quantity: quantity,
        unitPrice: unitPrice,
        total: quantity * unitPrice,
      );

  final items = <BillItemRow>[
    if (!bill.isQuickSale) item(0, description: bill.unitName ?? '', quantity: 1, unitPrice: bill.playCost),
  ];
  for (final line in bill.lines) {
    items.add(item(items.length, productId: line.productId, description: line.name, quantity: line.quantity, unitPrice: line.unitPrice));
  }

  return BillRows(
    bill: BillRow(
      updatedAt: now,
      updatedByStaffId: staffId,
      id: bill.id,
      venueId: venueId,
      sessionId: bill.sessionId,
      staffId: staffId,
      shiftId: shiftId,
      subtotal: bill.subtotal,
      discount: bill.discount,
      total: bill.total,
      discountNote: bill.discountReason,
      paymentMethod: _pascal(bill.method),
      paidAt: wholeSeconds(bill.paidAt),
    ),
    items: items,
  );
}

/// The Bill the screens use. [session] and its [stretches] are the rows of the session the bill closed
/// (empty for a quick sale): they give the start, the device, the mode and the price.
Bill billFromRows(BillRows rows, {SessionRow? session, List<SessionUnitRow> stretches = const []}) {
  final b = rows.bill;
  final play = rows.items.where((i) => i.productId == null).firstOrNull;
  final last = stretches.isEmpty ? null : (([...stretches]..sort((a, b) => a.startedAt.compareTo(b.startedAt))).last);
  return Bill(
    id: b.id,
    sessionId: b.sessionId,
    paidAt: b.paidAt,
    unitId: last?.unitId,
    unitName: play?.description,
    startedAt: session?.createdAt ?? b.paidAt,
    endedAt: last?.endedAt ?? b.paidAt,
    isMulti: last?.mode == 'Multi',
    hourlyPrice: last?.hourlyPrice ?? 0,
    playCost: play?.total ?? 0,
    lines: [
      for (final i in rows.items)
        if (i.productId != null)
          // The table does not keep when a drink was ordered once it is on a bill: it shows the payment time.
          OrderLine(productId: i.productId!, name: i.description, unitPrice: i.unitPrice, quantity: i.quantity, orderedAt: b.paidAt),
    ],
    discount: b.discount,
    discountReason: b.discountNote,
    method: PaymentMethod.values.firstWhere((m) => _pascal(m) == b.paymentMethod),
    cashBoxId: b.shiftId,
    takenById: b.staffId,
  );
}
