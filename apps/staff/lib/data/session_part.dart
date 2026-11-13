import 'money.dart';

/// Play cost in piasters from [priceSeconds]: the sum of (seconds x piasters an hour) over every
/// stretch of a session. Rounded down to whole pounds once, at the end, so a session loses less than
/// one pound however many stretches it has (whole ints only, no double).
int playCostOf(int priceSeconds) => priceSeconds ~/ (3600 * piastersPerPound) * piastersPerPound;

/// One finished stretch of a session: on one device, in one mode, at one price. A session is a list
/// of these plus the stretch that is running now. In the database it is one `sessions_units` row
/// (decision #51): a single/pair switch, a move or a stop closes a stretch.
class SessionPart {
  const SessionPart({
    required this.unitId,
    required this.isMulti,
    required this.hourlyPrice,
    required this.from,
    required this.to,
  });

  final String unitId; // the device it was played on
  final bool isMulti; // pair mode
  final int hourlyPrice; // piasters an hour, the price that applied (single or pair)
  final DateTime from;
  final DateTime to;

  Duration get duration => to.difference(from);

  /// Seconds x price: the exact weight of this stretch in the bill (see [playCostOf]).
  int get priceSeconds => duration.inSeconds * hourlyPrice;

  @override
  bool operator ==(Object other) =>
      other is SessionPart &&
      other.unitId == unitId &&
      other.isMulti == isMulti &&
      other.hourlyPrice == hourlyPrice &&
      other.from == from &&
      other.to == to;

  @override
  int get hashCode => Object.hash(unitId, isMulti, hourlyPrice, from, to);
}
