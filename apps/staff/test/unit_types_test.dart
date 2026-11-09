import 'package:al3b_staff/data/unit.dart';
import 'package:al3b_staff/data/unit_types_provider.dart';
import 'package:al3b_staff/floor/floor_sections.dart';
import 'package:al3b_staff/l10n/arb/app_localizations_ar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = AppLocalizationsAr();

  ProviderContainer container() {
    final c = ProviderContainer();
    addTearDown(c.dispose);
    return c;
  }

  group('types of device', () {
    test('a shop starts with the four built-in types', () {
      expect(container().read(unitTypesProvider), UnitType.defaults);
    });

    test('the built-in ids never change (sync and old app versions depend on them)', () {
      expect(UnitType.playstation.serverId, '01990000-0000-7000-8000-000000000001');
      expect(UnitType.pingPong.serverId, '01990000-0000-7000-8000-000000000002');
      expect(UnitType.billiards.serverId, '01990000-0000-7000-8000-000000000003');
      expect(UnitType.pc.serverId, '01990000-0000-7000-8000-000000000004');
    });

    test('the owner adds a type of their own, after the built-in ones', () {
      final c = container();
      final foosball = c.read(unitTypesProvider.notifier).add(name: '  فوتبول ', iconKey: 'soccer', hasPairPrice: true);

      expect(foosball, isNotNull);
      expect(foosball!.name, 'فوتبول');
      expect(foosball.hasPairPrice, isTrue);
      expect(foosball.isDefault, isFalse);
      expect(c.read(unitTypesProvider), [...UnitType.defaults, foosball]);
    });

    test('an empty name or a name already used is refused', () {
      final notifier = container().read(unitTypesProvider.notifier);
      expect(notifier.add(name: '   ', iconKey: 'other', hasPairPrice: false), isNull);
      expect(notifier.add(name: 'VR', iconKey: 'vr', hasPairPrice: false), isNotNull);
      expect(notifier.add(name: 'vr', iconKey: 'vr', hasPairPrice: false), isNull);
      expect(notifier.add(name: 'PC', iconKey: 'computer', hasPairPrice: false), isNull); // a built-in name
    });

    test('built-in types show translated, the shop\'s own show as typed', () {
      expect(unitTypeName(UnitType.billiards, l10n), l10n.typeBilliards);
      const vr = UnitType(id: 'custom-1', name: 'VR', iconKey: 'vr');
      expect(unitTypeName(vr, l10n), 'VR');
    });

    test('the Floor by type shows a custom type after the built-in ones', () {
      const vr = UnitType(id: 'custom-1', name: 'VR', iconKey: 'vr');
      final units = [
        const Unit(id: 'a', name: 'VR-1', type: vr, roomId: 'r1', roomName: 'غرفة 1', categoryId: 'c', status: UnitStatus.free, hourlyPrice: 8000),
        const Unit(id: 'b', name: 'PC-1', type: UnitType.pc, roomId: 'r2', roomName: 'غرفة 2', categoryId: 'c', status: UnitStatus.free, hourlyPrice: 3000),
      ];

      final sections = buildFloorSections(units, l10n, byType: true);

      expect(sections.map((s) => s.title), [l10n.typePc, 'VR']);
    });

    test('a custom type has an icon even if its key is unknown', () {
      const odd = UnitType(id: 'x', name: 'X', iconKey: 'nope');
      expect(odd.icon, isNotNull);
    });
  });
}
