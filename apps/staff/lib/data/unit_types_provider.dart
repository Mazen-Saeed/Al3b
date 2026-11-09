import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ids.dart';
import 'unit_type.dart';

/// The types of device this shop can pick from: the four built-in ones, then the owner's own.
class UnitTypesNotifier extends Notifier<List<UnitType>> {
  @override
  List<UnitType> build() => UnitType.defaults;

  /// Whether a type with this name already exists (ignoring capitals and spaces around it).
  bool exists(String name) {
    final wanted = name.trim().toLowerCase();
    return state.any((t) => t.name.toLowerCase() == wanted);
  }

  /// Adds the owner's own type and returns it. Null when the name is empty or already used.
  UnitType? add({required String name, required String iconKey, required bool hasPairPrice}) {
    final clean = name.trim();
    if (clean.isEmpty || exists(clean)) return null;
    final type = UnitType(id: newId(), name: clean, iconKey: iconKey, hasPairPrice: hasPairPrice);
    state = [...state, type];
    return type;
  }
}

final unitTypesProvider = NotifierProvider<UnitTypesNotifier, List<UnitType>>(UnitTypesNotifier.new);
