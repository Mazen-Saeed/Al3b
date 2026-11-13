import 'package:uuid/uuid.dart';

import '../unit.dart';
import 'app_database.dart';

// The mapper between the screens' Unit and the SQLite rows (decision #65). It is plain functions: no
// database, no providers. The repository calls it; nothing else should know the rows exist.
//
// One Unit becomes: its device row, and while it has a session, the session row plus one
// sessions_units row per stretch (decision #51). Going back, the last stretch is the one running now.
// If it is closed (it has an end time), the clock was stopped and the unit waits for payment.

// ignore: prefer_const_constructors
final _uuid = Uuid();

/// What one device looks like in the tables.
class UnitRows {
  const UnitRows({required this.unit, this.session, this.stretches = const []});

  final UnitRow unit;
  final SessionRow? session; // null = no session (free or in maintenance)
  final List<SessionUnitRow> stretches; // oldest first; the last is the stretch running now (or stopped)
}

/// The id of a session's n-th stretch. It is made from the session id and the position, so saving
/// the same session twice gives the same ids (a new random id each time would look like a new row to
/// sync). Positions never change: stretches are only ever added at the end.
String stretchRowId(String sessionId, int index) => _uuid.v5(Namespace.url.value, '$sessionId/$index');

/// The id of a session's order line for a product. Made from the session and the product (one line
/// per product on a bill), so saving again gives the same id.
String orderRowId(String sessionId, String productId) => _uuid.v5(Namespace.url.value, '$sessionId/order/$productId');

/// The id of a bill's n-th line (0 is the play time when there is one). Bills are never changed after
/// payment, so the position is stable.
String billItemRowId(String billId, int index) => _uuid.v5(Namespace.url.value, '$billId/item/$index');

String _modeName(bool isMulti) => isMulti ? 'Multi' : 'Single';

/// The database keeps times in whole seconds. Cutting them here makes a saved row equal to the row
/// loaded back, so the repository can tell a real change from a rounding difference.
DateTime wholeSeconds(DateTime t) => DateTime.fromMillisecondsSinceEpoch(t.millisecondsSinceEpoch ~/ 1000 * 1000);

/// The rows to save for [unit]. [staffId] and [now] go into the sync columns (who changed it, and
/// when). The repository decides which rows really changed; this only builds them.
UnitRows unitToRows(
  Unit unit, {
  required String venueId,
  required String staffId,
  required DateTime now,
  int sortOrder = 0,
}) {
  final categoryId = unit.categoryId;
  if (categoryId == null) {
    // The prices come back from the category when the unit is loaded, so without one they would be lost.
    throw StateError('Unit ${unit.id} has no price category; every device needs one to be saved.');
  }
  final row = UnitRow(
    updatedAt: now,
    updatedByStaffId: staffId,
    id: unit.id,
    venueId: venueId,
    roomId: unit.roomId,
    unitTypeId: unit.type.id,
    priceCategoryId: categoryId,
    name: unit.name,
    sortOrder: sortOrder,
    status: unit.status == UnitStatus.maintenance ? 'Maintenance' : 'Active',
    maintenanceNote: unit.note,
  );
  if (!unit.hasSession) return UnitRows(unit: row);

  final sessionId = unit.sessionId;
  if (sessionId == null) throw StateError('Unit ${unit.id} has a session but no sessionId.');
  final started = wholeSeconds(unit.startedAt!);

  SessionUnitRow stretch(
    int index, {
    required String unitId,
    required DateTime from,
    DateTime? to,
    required bool isMulti,
    int? plannedMinutes,
    required int hourlyPrice,
  }) =>
      SessionUnitRow(
        updatedAt: now,
        updatedByStaffId: staffId,
        id: stretchRowId(sessionId, index),
        venueId: venueId,
        sessionId: sessionId,
        unitId: unitId,
        startedAt: wholeSeconds(from),
        endedAt: to == null ? null : wholeSeconds(to),
        mode: _modeName(isMulti),
        plannedMinutes: plannedMinutes,
        hourlyPrice: hourlyPrice,
      );

  return UnitRows(
    unit: row,
    session: SessionRow(
      updatedAt: now,
      updatedByStaffId: staffId,
      id: sessionId,
      venueId: venueId,
      staffId: staffId,
      status: 'Active',
      createdAt: started,
    ),
    stretches: [
      for (var i = 0; i < unit.parts.length; i++)
        stretch(i,
            unitId: unit.parts[i].unitId,
            from: unit.parts[i].from,
            to: unit.parts[i].to,
            isMulti: unit.parts[i].isMulti,
            hourlyPrice: unit.parts[i].hourlyPrice),
      stretch(unit.parts.length,
          unitId: unit.id,
          from: unit.rateFrom ?? started,
          to: unit.stoppedAt, // null while it runs; set when the clock is stopped
          isMulti: unit.isMulti,
          plannedMinutes: unit.plannedMinutes,
          hourlyPrice: unit.isMulti ? unit.multiHourlyPrice! : unit.hourlyPrice),
    ],
  );
}

/// The Unit the screens use, built from its rows. The caller passes the room and the price category
/// the rows point to, and the unit's [type] (the built-in ones are in the code, the shop's own come
/// from the unit_types table). The prices come from the category.
Unit unitFromRows(
  UnitRows rows, {
  required RoomRow room,
  required PriceCategoryRow category,
  required UnitType type,
}) {
  final row = rows.unit;
  Unit unit({
    required UnitStatus status,
    DateTime? startedAt,
    bool isMulti = false,
    int? plannedMinutes,
    String? sessionId,
    List<SessionPart> parts = const [],
    DateTime? rateFrom,
    int? hourlyPrice,
    int? multiHourlyPrice,
  }) =>
      Unit(
        id: row.id,
        name: row.name,
        type: type,
        roomId: row.roomId,
        roomName: room.name,
        categoryId: category.id,
        status: status,
        hourlyPrice: hourlyPrice ?? category.hourlyPrice,
        multiHourlyPrice: multiHourlyPrice ?? category.multiHourlyPrice,
        startedAt: startedAt,
        isMulti: isMulti,
        plannedMinutes: plannedMinutes,
        sessionId: sessionId,
        parts: parts,
        rateFrom: rateFrom,
      );

  // The app has no "disabled" state yet, so it shows Disabled like Maintenance.
  if (row.status != 'Active') return unit(status: UnitStatus.maintenance).asInMaintenance(row.maintenanceNote);

  final session = rows.session;
  if (session == null || rows.stretches.isEmpty) return unit(status: UnitStatus.free);

  final stretches = [...rows.stretches]..sort((a, b) => a.startedAt.compareTo(b.startedAt));
  final current = stretches.last;
  final earlier = stretches.sublist(0, stretches.length - 1);
  final isMulti = current.mode == 'Multi';
  final running = unit(
    status: UnitStatus.running,
    startedAt: stretches.first.startedAt,
    // The price in use is the one the running stretch was started at, not today's category price:
    // the category may have changed since, and the bill is worked out from the old price.
    hourlyPrice: isMulti ? null : current.hourlyPrice,
    multiHourlyPrice: isMulti ? current.hourlyPrice : null,
    isMulti: isMulti,
    plannedMinutes: current.plannedMinutes,
    sessionId: session.id,
    parts: [
      for (final r in earlier)
        SessionPart(
          unitId: r.unitId,
          isMulti: r.mode == 'Multi',
          hourlyPrice: r.hourlyPrice,
          from: r.startedAt,
          to: r.endedAt!,
        ),
    ],
    rateFrom: earlier.isEmpty ? null : current.startedAt,
  );
  // A closed last stretch means the clock was stopped there: waiting for payment, amount due as then.
  final stoppedAt = current.endedAt;
  return stoppedAt == null ? running : running.asStopped(stoppedAt);
}
