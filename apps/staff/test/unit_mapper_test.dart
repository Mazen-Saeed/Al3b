import 'package:al3b_staff/data/db/app_database.dart';
import 'package:al3b_staff/data/db/unit_mapper.dart';
import 'package:al3b_staff/data/unit.dart';
import 'package:flutter_test/flutter_test.dart';

// Saving a Unit to rows and loading it back must lose nothing (decision #51, #65).
void main() {
  final t0 = DateTime(2026, 1, 1, 20);
  DateTime at(int minutes) => t0.add(Duration(minutes: minutes));

  final room = RoomRow(updatedAt: t0, id: 'hall-1', venueId: 'v1', name: 'صالة 1', sortOrder: 0);
  final category = PriceCategoryRow(
    updatedAt: t0,
    id: 'cat-ps5',
    venueId: 'v1',
    name: 'PS5 عادي',
    pricingMode: 'Hourly',
    hourlyPrice: 5000,
    multiHourlyPrice: 7000,
  );

  Unit ps5({UnitStatus status = UnitStatus.free, DateTime? startedAt, bool isMulti = false, int? plannedMinutes, String? note}) => Unit(
        id: 'ps5-1',
        name: 'PS5-1',
        type: UnitType.playstation,
        roomId: 'hall-1',
        roomName: 'صالة 1',
        categoryId: 'cat-ps5',
        status: status,
        hourlyPrice: 5000,
        multiHourlyPrice: 7000,
        startedAt: startedAt,
        isMulti: isMulti,
        plannedMinutes: plannedMinutes,
        note: note,
      );

  Unit running({bool isMulti = false, int? plannedMinutes}) =>
      ps5(status: UnitStatus.running, startedAt: t0, isMulti: isMulti, plannedMinutes: plannedMinutes).copyWith(sessionId: 'session-1');

  UnitRows save(Unit u) => unitToRows(u, venueId: 'v1', staffId: 'staff-1', now: t0);
  Unit load(UnitRows rows) => unitFromRows(rows, room: room, category: category, type: UnitType.playstation);
  Unit roundTrip(Unit u) => load(save(u));

  test('a free unit is one device row and nothing else', () {
    final rows = save(ps5());
    expect(rows.unit.status, 'Active');
    expect(rows.unit.priceCategoryId, 'cat-ps5');
    expect(rows.session, isNull);
    expect(rows.stretches, isEmpty);

    final back = load(rows);
    expect(back.status, UnitStatus.free);
    expect(back.name, 'PS5-1');
    expect(back.roomName, 'صالة 1');
    expect(back.hourlyPrice, 5000); // the prices come back from the category
    expect(back.multiHourlyPrice, 7000);
  });

  test('a unit in maintenance keeps its reason', () {
    final rows = save(ps5(status: UnitStatus.maintenance, note: 'الدراع بايظ'));
    expect(rows.unit.status, 'Maintenance');
    expect(rows.session, isNull);

    final back = load(rows);
    expect(back.status, UnitStatus.maintenance);
    expect(back.note, 'الدراع بايظ');
  });

  test('a running session is a session row and one open stretch', () {
    final rows = save(running(isMulti: true, plannedMinutes: 60));
    expect(rows.session!.id, 'session-1');
    expect(rows.session!.status, 'Active');
    expect(rows.session!.staffId, 'staff-1');
    expect(rows.session!.createdAt, t0);
    final stretch = rows.stretches.single;
    expect(stretch.unitId, 'ps5-1');
    expect(stretch.mode, 'Multi');
    expect(stretch.hourlyPrice, 7000); // the price of the mode, at the time
    expect(stretch.plannedMinutes, 60);
    expect(stretch.endedAt, isNull);

    final back = load(rows);
    expect(back.status, UnitStatus.running);
    expect(back.sessionId, 'session-1');
    expect(back.startedAt, t0);
    expect(back.isMulti, isTrue);
    expect(back.plannedMinutes, 60);
    expect(back.parts, isEmpty);
    expect(back.rateFrom, isNull);
    expect(back.costAt(at(90)), running(isMulti: true).costAt(at(90)));
  });

  test('switches become closed stretches, in order, and the bill is the same after loading', () {
    final original = running().withModeSwitched(at(30)).withModeSwitched(at(60)); // single, pair, single
    final rows = save(original);
    expect(rows.stretches.map((s) => (s.mode, s.endedAt == null)), [('Single', false), ('Multi', false), ('Single', true)]);

    final back = roundTrip(original);
    expect(back.parts, original.parts);
    expect(back.rateFrom, at(60));
    expect(back.startedAt, t0);
    expect(back.costAt(at(90)), original.costAt(at(90)));
    expect(back.elapsedAt(at(90)), original.elapsedAt(at(90)));
  });

  test('a stopped clock closes the last stretch, and loading gives back the unit waiting for payment', () {
    final original = running().withModeSwitched(at(20)).asStopped(at(45));
    final rows = save(original);
    expect(rows.stretches.last.endedAt, at(45));

    final back = roundTrip(original);
    expect(back.status, UnitStatus.waitingPayment);
    expect(back.stoppedAt, at(45));
    expect(back.amountDue, original.amountDue);
    expect(back.costAt(at(500)), original.costAt(at(500))); // it does not grow
  });

  test('a resume opens a new stretch: the stopped one stays closed where it stopped', () {
    final original = running().asStopped(at(30)).asResumed(at(50));
    final rows = save(original);
    expect(rows.stretches.length, 2);
    expect(rows.stretches.first.endedAt, at(30));
    expect(rows.stretches.last.startedAt, at(50));
    expect(rows.stretches.last.endedAt, isNull);

    final back = roundTrip(original);
    expect(back.status, UnitStatus.running);
    expect(back.startedAt, t0);
    expect(back.rateFrom, at(50));
    expect(back.costAt(at(80)), original.costAt(at(80))); // 30 + 30 minutes at 50, the 20 stopped not charged
  });

  test('a moved session keeps the old device in its first stretch', () {
    final original = running().copyWith(parts: [running().stretchUntil(at(60))], rateFrom: at(60));
    final back = roundTrip(original);
    expect(back.parts.single.unitId, 'ps5-1');
    expect(back.parts.single.hourlyPrice, 5000);
  });

  test('saving twice gives the same ids, so sync sees the same rows', () {
    final u = running().withModeSwitched(at(30));
    final a = save(u);
    final b = save(u);
    expect(a.stretches.map((s) => s.id), b.stretches.map((s) => s.id));
    expect(a.stretches.map((s) => s.id).toSet().length, 2); // and they differ from each other
  });

  test('a running session keeps the price it started at when the category price changed since', () {
    final rows = save(running()); // started at 50 single, 70 pair
    final dearer = PriceCategoryRow(
      updatedAt: t0,
      id: 'cat-ps5',
      venueId: 'v1',
      name: 'PS5 عادي',
      pricingMode: 'Hourly',
      hourlyPrice: 6000,
      multiHourlyPrice: 8000,
    );

    final back = unitFromRows(rows, room: room, category: dearer, type: UnitType.playstation);

    expect(back.hourlyPrice, 5000); // the running stretch keeps its price
    expect(back.multiHourlyPrice, 8000); // the price it is not using follows the category
  });

  test('a unit that cannot be restored is refused, not saved wrongly', () {
    final noCategory = Unit(
      id: 'u',
      name: 'U',
      type: UnitType.playstation,
      roomId: 'hall-1',
      roomName: 'صالة 1',
      status: UnitStatus.free,
      hourlyPrice: 5000,
    );
    expect(() => save(noCategory), throwsStateError);
    expect(() => save(ps5(status: UnitStatus.running, startedAt: t0)), throwsStateError); // a session without an id
  });
}
