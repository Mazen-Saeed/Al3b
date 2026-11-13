import 'package:al3b_staff/data/bill.dart';
import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/bill_mapper.dart';
import 'package:al3b_staff/data/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final day = DateTime(2026, 1, 2);
  DateTime at(int hour, [int minute = 0]) => DateTime(day.year, day.month, day.day, hour, minute);

  Bill sessionBill({int discount = 500, String? cashier = 'staff-1'}) => Bill(
        id: 'b1',
        sessionId: 's1',
        paidAt: at(10),
        unitId: 'ps5-1',
        unitName: 'PS5-1',
        startedAt: at(8),
        endedAt: at(9, 30),
        isMulti: true,
        hourlyPrice: 7000,
        playCost: 10500,
        lines: [OrderLine(productId: 'p1', name: 'شاي', unitPrice: 1000, quantity: 2, orderedAt: at(8, 10))],
        discount: discount,
        discountReason: 'عميل دايم',
        method: PaymentMethod.instapay,
        cashBoxId: 'box1',
        takenById: cashier,
      );

  // The rows of the session the bill closed, as the repository reads them.
  final session = SessionRow(updatedAt: at(10), id: 's1', venueId: 'v1', staffId: 'staff-1', status: 'Completed', createdAt: at(8));
  final stretch = SessionUnitRow(
    updatedAt: at(10),
    id: 'x1',
    venueId: 'v1',
    sessionId: 's1',
    unitId: 'ps5-1',
    startedAt: at(8),
    endedAt: at(9, 30),
    mode: 'Multi',
    hourlyPrice: 7000,
  );

  test('a session bill is one bill row, a play-time line and a line per drink', () {
    final rows = billToRows(sessionBill(), venueId: 'v1', now: at(10));

    expect(rows.bill.subtotal, 10500 + 2000);
    expect(rows.bill.discount, 500);
    expect(rows.bill.total, 12000);
    expect(rows.bill.paymentMethod, 'Instapay');
    expect(rows.bill.shiftId, 'box1');
    expect(rows.bill.staffId, 'staff-1');
    expect(rows.bill.sessionId, 's1');
    expect(rows.items.length, 2);
    expect(rows.items.first.productId, isNull); // play time
    expect(rows.items.first.description, 'PS5-1');
    expect(rows.items.first.total, 10500);
    expect(rows.items.last.productId, 'p1');
    expect(rows.items.last.quantity, 2);
    expect(rows.items.last.total, 2000);
  });

  test('a session bill comes back the same, with the start, device and price from its session', () {
    final original = sessionBill();

    final back = billFromRows(billToRows(original, venueId: 'v1', now: at(10)), session: session, stretches: [stretch]);

    expect(back.id, 'b1');
    expect(back.sessionId, 's1');
    expect(back.unitId, 'ps5-1');
    expect(back.unitName, 'PS5-1');
    expect(back.startedAt, at(8));
    expect(back.endedAt, at(9, 30));
    expect(back.paidAt, at(10));
    expect(back.isMulti, isTrue);
    expect(back.hourlyPrice, 7000);
    expect(back.playCost, 10500);
    expect(back.lines.single.name, 'شاي');
    expect(back.lines.single.quantity, 2);
    expect(back.discount, 500);
    expect(back.discountReason, 'عميل دايم');
    expect(back.method, PaymentMethod.instapay);
    expect(back.cashBoxId, 'box1');
    expect(back.takenById, 'staff-1');
    expect(back.total, original.total);
  });

  test('a quick sale has no play line and comes back as a quick sale', () {
    final sale = Bill.quickSale(
      id: 'q1',
      at: at(11),
      lines: [OrderLine(productId: 'p1', name: 'شاي', unitPrice: 1000, quantity: 1, orderedAt: at(11))],
      method: PaymentMethod.cash,
      cashBoxId: 'box1',
      takenById: 'staff-1',
    );

    final rows = billToRows(sale, venueId: 'v1', now: at(11));
    final back = billFromRows(rows);

    expect(rows.bill.sessionId, isNull);
    expect(rows.items.single.productId, 'p1');
    expect(back.isQuickSale, isTrue);
    expect(back.total, 1000);
    expect(back.paidAt, at(11));
  });

  test('item ids are stable, so saving a bill twice gives the same rows', () {
    final a = billToRows(sessionBill(), venueId: 'v1', now: at(10));
    final b = billToRows(sessionBill(), venueId: 'v1', now: at(12));
    expect(a.items.map((i) => i.id), b.items.map((i) => i.id));
    expect(a.items.first.id, isNot(a.items.last.id));
  });

  test('a bill with no cashier is refused', () {
    expect(() => billToRows(sessionBill(cashier: null), venueId: 'v1', now: at(10)), throwsStateError);
  });
}
