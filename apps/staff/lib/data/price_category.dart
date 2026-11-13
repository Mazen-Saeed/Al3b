/// A price list the owner makes once ("PS5 عادي", "VIP", "PS4") and gives to many devices.
/// It does not know about device kinds. The pair price is optional: a category with one asks staff
/// "one player or more?", a category without one does not. Prices are piasters.
class PriceCategory {
  const PriceCategory({
    required this.id,
    required this.name,
    required this.hourlyPrice,
    this.multiHourlyPrice,
  });

  final String id;
  final String name;
  final int hourlyPrice; // per hour, single
  final int? multiHourlyPrice; // per hour, two or more players; null = none
}
