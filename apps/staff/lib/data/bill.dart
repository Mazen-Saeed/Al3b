import 'product.dart';

enum PaymentMethod { cash, instapay, wallet }

/// A paid session, saved as a receipt. It copies everything it needs (unit name, prices,
/// order lines), so later changes to units or products never rewrite old bills.
class Bill {
  const Bill({
    required this.id,
    this.sessionId,
    required this.paidAt,
    this.unitId,
    this.unitName,
    required this.startedAt,
    required this.endedAt,
    required this.isMulti,
    required this.hourlyPrice,
    required this.playCost,
    required this.lines,
    required this.discount,
    this.discountReason,
    required this.method,
    this.cashBoxId,
    this.takenById,
  });

  final String id;
  final String? sessionId; // the session this bill closed; null for a quick sale
  final DateTime paidAt; // when the payment was confirmed (the checkout may have stopped the clock earlier)
  final String? unitId; // null = a quick sale (no unit, no session)
  final String? unitName;
  final DateTime startedAt;
  final DateTime endedAt;
  final bool isMulti;
  final int hourlyPrice; // the price per hour that applied (single or multi)
  final int playCost;
  final List<OrderLine> lines;
  final int discount; // piasters taken off, never more than the subtotal
  final String? discountReason;
  final PaymentMethod method;
  final String? cashBoxId; // the cash box that was open when it was paid
  final String? takenById; // who took the payment

  /// Drinks or snacks sold to someone who is not playing: a bill with order lines and no unit.
  Bill.quickSale({
    required this.id,
    required DateTime at,
    required this.lines,
    required this.method,
    this.cashBoxId,
    this.takenById,
  })
      : sessionId = null,
        paidAt = at,
        unitId = null,
        unitName = null,
        startedAt = at,
        endedAt = at,
        isMulti = false,
        hourlyPrice = 0,
        playCost = 0,
        discount = 0,
        discountReason = null;

  /// The same bill with another discount (a correction after payment). Nothing else changes.
  Bill withDiscount(int newDiscount) => Bill(
        id: id,
        sessionId: sessionId,
        paidAt: paidAt,
        unitId: unitId,
        unitName: unitName,
        startedAt: startedAt,
        endedAt: endedAt,
        isMulti: isMulti,
        hourlyPrice: hourlyPrice,
        playCost: playCost,
        lines: lines,
        discount: newDiscount,
        discountReason: discountReason,
        method: method,
        cashBoxId: cashBoxId,
        takenById: takenById,
      );

  bool get isQuickSale => unitId == null;

  int get ordersTotal => lines.fold(0, (sum, line) => sum + line.total);
  int get subtotal => playCost + ordersTotal;

  /// What the customer paid.
  int get total => subtotal - discount;
}
