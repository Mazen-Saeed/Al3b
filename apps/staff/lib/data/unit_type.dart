import 'package:flutter/material.dart';

/// What kind of thing is rented by time: PlayStation, ping pong, a padel court... A shop can add its
/// own types (decision #61). The four built-in ones below are the defaults every shop starts with;
/// their ids are the ones in the server's unit_types table (UnitTypeConfiguration.cs). Never change them.
class UnitType {
  const UnitType({required this.id, required this.name, this.iconKey = 'other'});

  final String id;

  /// Shown as typed for the shop's own types. The four built-in ones are shown translated (see unitTypeName).
  final String name;

  /// A key of [unitTypeIcons]. The shop's own types all use the neutral 'other' icon.
  final String iconKey;

  static const playstation = UnitType(id: '01990000-0000-7000-8000-000000000001', name: 'PlayStation', iconKey: 'gamepad');
  static const pingPong = UnitType(id: '01990000-0000-7000-8000-000000000002', name: 'Ping pong', iconKey: 'tableTennis');
  static const billiards = UnitType(id: '01990000-0000-7000-8000-000000000003', name: 'Billiards', iconKey: 'billiards');
  static const pc = UnitType(id: '01990000-0000-7000-8000-000000000004', name: 'PC', iconKey: 'computer');

  /// The types a new shop starts with, in the order the Floor shows them.
  static const defaults = [playstation, pingPong, billiards, pc];

  bool get isDefault => defaults.contains(this);

  /// The id sync sends as unit_type_id.
  String get serverId => id;

  IconData get icon => unitTypeIcons[iconKey] ?? Icons.category;

  @override
  bool operator ==(Object other) => other is UnitType && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// The icon of each key. Only the four built-in types pick their own; the rest use 'other'.
const unitTypeIcons = <String, IconData>{
  'gamepad': Icons.sports_esports,
  'tableTennis': Icons.sports_tennis,
  'billiards': Icons.adjust,
  'computer': Icons.computer,
  'other': Icons.category,
};
