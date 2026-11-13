import 'package:uuid/uuid.dart';

// ignore: prefer_const_constructors
final _uuid = Uuid();

/// A new id for a row created on this device (a product, a stock item, a purchase...).
/// UUID v7, like the database ids (decision #1): safe to make offline, and ordered by time.
String newId() => _uuid.v7();

/// The same id every time for the same [name] (UUID v5). For rows that must get the same id on any
/// computer, such as a shop's built-in expense types.
String stableId(String name) => _uuid.v5(Namespace.url.value, name);
