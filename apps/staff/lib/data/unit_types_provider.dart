import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ids.dart';
import 'unit_type.dart';

/// The device types when the app starts: the built-in ones, then the shop's own (loaded from the
/// database at startup).
final initialUnitTypesProvider = Provider<List<UnitType>>((ref) => UnitType.defaults);

/// The types of device this shop can pick from: the four built-in ones, then the owner's own.
class UnitTypesNotifier extends Notifier<List<UnitType>> {
  @override
  List<UnitType> build() => ref.watch(initialUnitTypesProvider);

  /// Whether a type with this name already exists (ignoring capitals and spaces around it).
  bool exists(String name) {
    final wanted = name.trim().toLowerCase();
    return state.any((t) => t.name.toLowerCase() == wanted);
  }

  /// Adds the owner's own type and returns it. Null when the name is empty or already used.
  UnitType? add(String name) {
    final clean = name.trim();
    if (clean.isEmpty || exists(clean)) return null;
    final type = UnitType(id: newId(), name: clean);
    state = [...state, type];
    return type;
  }
}

final unitTypesProvider = NotifierProvider<UnitTypesNotifier, List<UnitType>>(UnitTypesNotifier.new);
