// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoomsTable extends Rooms with TableInfo<$RoomsTable, RoomRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoomRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoomRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoomRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $RoomsTable createAlias(String alias) {
    return $RoomsTable(attachedDatabase, alias);
  }
}

class RoomRow extends DataClass implements Insertable<RoomRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final int sortOrder;
  const RoomRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RoomsCompanion toCompanion(bool nullToAbsent) {
    return RoomsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      sortOrder: Value(sortOrder),
    );
  }

  factory RoomRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoomRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RoomRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    int? sortOrder,
  }) => RoomRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  RoomRow copyWithCompanion(RoomsCompanion data) {
    return RoomRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoomRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoomRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder);
}

class RoomsCompanion extends UpdateCompanion<RoomRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RoomsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoomsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name);
  static Insertable<RoomRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoomsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return RoomsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnitTypesTable extends UnitTypes
    with TableInfo<$UnitTypesTable, UnitTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'unit_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitTypeRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $UnitTypesTable createAlias(String alias) {
    return $UnitTypesTable(attachedDatabase, alias);
  }
}

class UnitTypeRow extends DataClass implements Insertable<UnitTypeRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String? venueId;
  final String name;
  const UnitTypeRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    this.venueId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || venueId != null) {
      map['venue_id'] = Variable<String>(venueId);
    }
    map['name'] = Variable<String>(name);
    return map;
  }

  UnitTypesCompanion toCompanion(bool nullToAbsent) {
    return UnitTypesCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: venueId == null && nullToAbsent
          ? const Value.absent()
          : Value(venueId),
      name: Value(name),
    );
  }

  factory UnitTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitTypeRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String?>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String?>(venueId),
      'name': serializer.toJson<String>(name),
    };
  }

  UnitTypeRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    Value<String?> venueId = const Value.absent(),
    String? name,
  }) => UnitTypeRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId.present ? venueId.value : this.venueId,
    name: name ?? this.name,
  );
  UnitTypeRow copyWithCompanion(UnitTypesCompanion data) {
    return UnitTypeRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitTypeRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(updatedAt, updatedByStaffId, deletedAt, id, venueId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitTypeRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name);
}

class UnitTypesCompanion extends UpdateCompanion<UnitTypeRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String?> venueId;
  final Value<String> name;
  final Value<int> rowid;
  const UnitTypesCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnitTypesCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    this.venueId = const Value.absent(),
    required String name,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name);
  static Insertable<UnitTypeRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnitTypesCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String?>? venueId,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return UnitTypesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitTypesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceCategoriesTable extends PriceCategories
    with TableInfo<$PriceCategoriesTable, PriceCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricingModeMeta = const VerificationMeta(
    'pricingMode',
  );
  @override
  late final GeneratedColumn<String> pricingMode = GeneratedColumn<String>(
    'pricing_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Hourly'),
  );
  static const VerificationMeta _hourlyPriceMeta = const VerificationMeta(
    'hourlyPrice',
  );
  @override
  late final GeneratedColumn<int> hourlyPrice = GeneratedColumn<int>(
    'hourly_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _multiHourlyPriceMeta = const VerificationMeta(
    'multiHourlyPrice',
  );
  @override
  late final GeneratedColumn<int> multiHourlyPrice = GeneratedColumn<int>(
    'multi_hourly_price',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    pricingMode,
    hourlyPrice,
    multiHourlyPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('pricing_mode')) {
      context.handle(
        _pricingModeMeta,
        pricingMode.isAcceptableOrUnknown(
          data['pricing_mode']!,
          _pricingModeMeta,
        ),
      );
    }
    if (data.containsKey('hourly_price')) {
      context.handle(
        _hourlyPriceMeta,
        hourlyPrice.isAcceptableOrUnknown(
          data['hourly_price']!,
          _hourlyPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hourlyPriceMeta);
    }
    if (data.containsKey('multi_hourly_price')) {
      context.handle(
        _multiHourlyPriceMeta,
        multiHourlyPrice.isAcceptableOrUnknown(
          data['multi_hourly_price']!,
          _multiHourlyPriceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceCategoryRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      pricingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing_mode'],
      )!,
      hourlyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hourly_price'],
      )!,
      multiHourlyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}multi_hourly_price'],
      ),
    );
  }

  @override
  $PriceCategoriesTable createAlias(String alias) {
    return $PriceCategoriesTable(attachedDatabase, alias);
  }
}

class PriceCategoryRow extends DataClass
    implements Insertable<PriceCategoryRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final String pricingMode;
  final int hourlyPrice;
  final int? multiHourlyPrice;
  const PriceCategoryRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    required this.pricingMode,
    required this.hourlyPrice,
    this.multiHourlyPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    map['pricing_mode'] = Variable<String>(pricingMode);
    map['hourly_price'] = Variable<int>(hourlyPrice);
    if (!nullToAbsent || multiHourlyPrice != null) {
      map['multi_hourly_price'] = Variable<int>(multiHourlyPrice);
    }
    return map;
  }

  PriceCategoriesCompanion toCompanion(bool nullToAbsent) {
    return PriceCategoriesCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      pricingMode: Value(pricingMode),
      hourlyPrice: Value(hourlyPrice),
      multiHourlyPrice: multiHourlyPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(multiHourlyPrice),
    );
  }

  factory PriceCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceCategoryRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      pricingMode: serializer.fromJson<String>(json['pricingMode']),
      hourlyPrice: serializer.fromJson<int>(json['hourlyPrice']),
      multiHourlyPrice: serializer.fromJson<int?>(json['multiHourlyPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'pricingMode': serializer.toJson<String>(pricingMode),
      'hourlyPrice': serializer.toJson<int>(hourlyPrice),
      'multiHourlyPrice': serializer.toJson<int?>(multiHourlyPrice),
    };
  }

  PriceCategoryRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    String? pricingMode,
    int? hourlyPrice,
    Value<int?> multiHourlyPrice = const Value.absent(),
  }) => PriceCategoryRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    pricingMode: pricingMode ?? this.pricingMode,
    hourlyPrice: hourlyPrice ?? this.hourlyPrice,
    multiHourlyPrice: multiHourlyPrice.present
        ? multiHourlyPrice.value
        : this.multiHourlyPrice,
  );
  PriceCategoryRow copyWithCompanion(PriceCategoriesCompanion data) {
    return PriceCategoryRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      pricingMode: data.pricingMode.present
          ? data.pricingMode.value
          : this.pricingMode,
      hourlyPrice: data.hourlyPrice.present
          ? data.hourlyPrice.value
          : this.hourlyPrice,
      multiHourlyPrice: data.multiHourlyPrice.present
          ? data.multiHourlyPrice.value
          : this.multiHourlyPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceCategoryRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('pricingMode: $pricingMode, ')
          ..write('hourlyPrice: $hourlyPrice, ')
          ..write('multiHourlyPrice: $multiHourlyPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    pricingMode,
    hourlyPrice,
    multiHourlyPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceCategoryRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.pricingMode == this.pricingMode &&
          other.hourlyPrice == this.hourlyPrice &&
          other.multiHourlyPrice == this.multiHourlyPrice);
}

class PriceCategoriesCompanion extends UpdateCompanion<PriceCategoryRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<String> pricingMode;
  final Value<int> hourlyPrice;
  final Value<int?> multiHourlyPrice;
  final Value<int> rowid;
  const PriceCategoriesCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.pricingMode = const Value.absent(),
    this.hourlyPrice = const Value.absent(),
    this.multiHourlyPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceCategoriesCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    this.pricingMode = const Value.absent(),
    required int hourlyPrice,
    this.multiHourlyPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name),
       hourlyPrice = Value(hourlyPrice);
  static Insertable<PriceCategoryRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<String>? pricingMode,
    Expression<int>? hourlyPrice,
    Expression<int>? multiHourlyPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (pricingMode != null) 'pricing_mode': pricingMode,
      if (hourlyPrice != null) 'hourly_price': hourlyPrice,
      if (multiHourlyPrice != null) 'multi_hourly_price': multiHourlyPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceCategoriesCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<String>? pricingMode,
    Value<int>? hourlyPrice,
    Value<int?>? multiHourlyPrice,
    Value<int>? rowid,
  }) {
    return PriceCategoriesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      pricingMode: pricingMode ?? this.pricingMode,
      hourlyPrice: hourlyPrice ?? this.hourlyPrice,
      multiHourlyPrice: multiHourlyPrice ?? this.multiHourlyPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pricingMode.present) {
      map['pricing_mode'] = Variable<String>(pricingMode.value);
    }
    if (hourlyPrice.present) {
      map['hourly_price'] = Variable<int>(hourlyPrice.value);
    }
    if (multiHourlyPrice.present) {
      map['multi_hourly_price'] = Variable<int>(multiHourlyPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceCategoriesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('pricingMode: $pricingMode, ')
          ..write('hourlyPrice: $hourlyPrice, ')
          ..write('multiHourlyPrice: $multiHourlyPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, UnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<String> roomId = GeneratedColumn<String>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitTypeIdMeta = const VerificationMeta(
    'unitTypeId',
  );
  @override
  late final GeneratedColumn<String> unitTypeId = GeneratedColumn<String>(
    'unit_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceCategoryIdMeta = const VerificationMeta(
    'priceCategoryId',
  );
  @override
  late final GeneratedColumn<String> priceCategoryId = GeneratedColumn<String>(
    'price_category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Active'),
  );
  static const VerificationMeta _maintenanceNoteMeta = const VerificationMeta(
    'maintenanceNote',
  );
  @override
  late final GeneratedColumn<String> maintenanceNote = GeneratedColumn<String>(
    'maintenance_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    roomId,
    unitTypeId,
    priceCategoryId,
    name,
    sortOrder,
    status,
    maintenanceNote,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(
    Insertable<UnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    if (data.containsKey('unit_type_id')) {
      context.handle(
        _unitTypeIdMeta,
        unitTypeId.isAcceptableOrUnknown(
          data['unit_type_id']!,
          _unitTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitTypeIdMeta);
    }
    if (data.containsKey('price_category_id')) {
      context.handle(
        _priceCategoryIdMeta,
        priceCategoryId.isAcceptableOrUnknown(
          data['price_category_id']!,
          _priceCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('maintenance_note')) {
      context.handle(
        _maintenanceNoteMeta,
        maintenanceNote.isAcceptableOrUnknown(
          data['maintenance_note']!,
          _maintenanceNoteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UnitRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room_id'],
      )!,
      unitTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_type_id'],
      )!,
      priceCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_category_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      maintenanceNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maintenance_note'],
      ),
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }
}

class UnitRow extends DataClass implements Insertable<UnitRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String roomId;
  final String unitTypeId;
  final String? priceCategoryId;
  final String name;
  final int sortOrder;
  final String status;
  final String? maintenanceNote;
  const UnitRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.roomId,
    required this.unitTypeId,
    this.priceCategoryId,
    required this.name,
    required this.sortOrder,
    required this.status,
    this.maintenanceNote,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['room_id'] = Variable<String>(roomId);
    map['unit_type_id'] = Variable<String>(unitTypeId);
    if (!nullToAbsent || priceCategoryId != null) {
      map['price_category_id'] = Variable<String>(priceCategoryId);
    }
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || maintenanceNote != null) {
      map['maintenance_note'] = Variable<String>(maintenanceNote);
    }
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      roomId: Value(roomId),
      unitTypeId: Value(unitTypeId),
      priceCategoryId: priceCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(priceCategoryId),
      name: Value(name),
      sortOrder: Value(sortOrder),
      status: Value(status),
      maintenanceNote: maintenanceNote == null && nullToAbsent
          ? const Value.absent()
          : Value(maintenanceNote),
    );
  }

  factory UnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UnitRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      roomId: serializer.fromJson<String>(json['roomId']),
      unitTypeId: serializer.fromJson<String>(json['unitTypeId']),
      priceCategoryId: serializer.fromJson<String?>(json['priceCategoryId']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      status: serializer.fromJson<String>(json['status']),
      maintenanceNote: serializer.fromJson<String?>(json['maintenanceNote']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'roomId': serializer.toJson<String>(roomId),
      'unitTypeId': serializer.toJson<String>(unitTypeId),
      'priceCategoryId': serializer.toJson<String?>(priceCategoryId),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'status': serializer.toJson<String>(status),
      'maintenanceNote': serializer.toJson<String?>(maintenanceNote),
    };
  }

  UnitRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? roomId,
    String? unitTypeId,
    Value<String?> priceCategoryId = const Value.absent(),
    String? name,
    int? sortOrder,
    String? status,
    Value<String?> maintenanceNote = const Value.absent(),
  }) => UnitRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    roomId: roomId ?? this.roomId,
    unitTypeId: unitTypeId ?? this.unitTypeId,
    priceCategoryId: priceCategoryId.present
        ? priceCategoryId.value
        : this.priceCategoryId,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    status: status ?? this.status,
    maintenanceNote: maintenanceNote.present
        ? maintenanceNote.value
        : this.maintenanceNote,
  );
  UnitRow copyWithCompanion(UnitsCompanion data) {
    return UnitRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
      unitTypeId: data.unitTypeId.present
          ? data.unitTypeId.value
          : this.unitTypeId,
      priceCategoryId: data.priceCategoryId.present
          ? data.priceCategoryId.value
          : this.priceCategoryId,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      status: data.status.present ? data.status.value : this.status,
      maintenanceNote: data.maintenanceNote.present
          ? data.maintenanceNote.value
          : this.maintenanceNote,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UnitRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('roomId: $roomId, ')
          ..write('unitTypeId: $unitTypeId, ')
          ..write('priceCategoryId: $priceCategoryId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('maintenanceNote: $maintenanceNote')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    roomId,
    unitTypeId,
    priceCategoryId,
    name,
    sortOrder,
    status,
    maintenanceNote,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnitRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.roomId == this.roomId &&
          other.unitTypeId == this.unitTypeId &&
          other.priceCategoryId == this.priceCategoryId &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.status == this.status &&
          other.maintenanceNote == this.maintenanceNote);
}

class UnitsCompanion extends UpdateCompanion<UnitRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> roomId;
  final Value<String> unitTypeId;
  final Value<String?> priceCategoryId;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<String> status;
  final Value<String?> maintenanceNote;
  final Value<int> rowid;
  const UnitsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.roomId = const Value.absent(),
    this.unitTypeId = const Value.absent(),
    this.priceCategoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.maintenanceNote = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnitsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String roomId,
    required String unitTypeId,
    this.priceCategoryId = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.maintenanceNote = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       roomId = Value(roomId),
       unitTypeId = Value(unitTypeId),
       name = Value(name);
  static Insertable<UnitRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? roomId,
    Expression<String>? unitTypeId,
    Expression<String>? priceCategoryId,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<String>? status,
    Expression<String>? maintenanceNote,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (roomId != null) 'room_id': roomId,
      if (unitTypeId != null) 'unit_type_id': unitTypeId,
      if (priceCategoryId != null) 'price_category_id': priceCategoryId,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (status != null) 'status': status,
      if (maintenanceNote != null) 'maintenance_note': maintenanceNote,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnitsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? roomId,
    Value<String>? unitTypeId,
    Value<String?>? priceCategoryId,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<String>? status,
    Value<String?>? maintenanceNote,
    Value<int>? rowid,
  }) {
    return UnitsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      roomId: roomId ?? this.roomId,
      unitTypeId: unitTypeId ?? this.unitTypeId,
      priceCategoryId: priceCategoryId ?? this.priceCategoryId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      status: status ?? this.status,
      maintenanceNote: maintenanceNote ?? this.maintenanceNote,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<String>(roomId.value);
    }
    if (unitTypeId.present) {
      map['unit_type_id'] = Variable<String>(unitTypeId.value);
    }
    if (priceCategoryId.present) {
      map['price_category_id'] = Variable<String>(priceCategoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (maintenanceNote.present) {
      map['maintenance_note'] = Variable<String>(maintenanceNote.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('roomId: $roomId, ')
          ..write('unitTypeId: $unitTypeId, ')
          ..write('priceCategoryId: $priceCategoryId, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('status: $status, ')
          ..write('maintenanceNote: $maintenanceNote, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reservationIdMeta = const VerificationMeta(
    'reservationId',
  );
  @override
  late final GeneratedColumn<String> reservationId = GeneratedColumn<String>(
    'reservation_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _walkInCustomerIdMeta = const VerificationMeta(
    'walkInCustomerId',
  );
  @override
  late final GeneratedColumn<String> walkInCustomerId = GeneratedColumn<String>(
    'walk_in_customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    reservationId,
    customerId,
    walkInCustomerId,
    staffId,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('reservation_id')) {
      context.handle(
        _reservationIdMeta,
        reservationId.isAcceptableOrUnknown(
          data['reservation_id']!,
          _reservationIdMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('walk_in_customer_id')) {
      context.handle(
        _walkInCustomerIdMeta,
        walkInCustomerId.isAcceptableOrUnknown(
          data['walk_in_customer_id']!,
          _walkInCustomerIdMeta,
        ),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      reservationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reservation_id'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      walkInCustomerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}walk_in_customer_id'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionRow extends DataClass implements Insertable<SessionRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String? reservationId;
  final String? customerId;
  final String? walkInCustomerId;
  final String staffId;
  final String status;
  final DateTime createdAt;
  const SessionRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    this.reservationId,
    this.customerId,
    this.walkInCustomerId,
    required this.staffId,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    if (!nullToAbsent || reservationId != null) {
      map['reservation_id'] = Variable<String>(reservationId);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    if (!nullToAbsent || walkInCustomerId != null) {
      map['walk_in_customer_id'] = Variable<String>(walkInCustomerId);
    }
    map['staff_id'] = Variable<String>(staffId);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      reservationId: reservationId == null && nullToAbsent
          ? const Value.absent()
          : Value(reservationId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      walkInCustomerId: walkInCustomerId == null && nullToAbsent
          ? const Value.absent()
          : Value(walkInCustomerId),
      staffId: Value(staffId),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory SessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      reservationId: serializer.fromJson<String?>(json['reservationId']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      walkInCustomerId: serializer.fromJson<String?>(json['walkInCustomerId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'reservationId': serializer.toJson<String?>(reservationId),
      'customerId': serializer.toJson<String?>(customerId),
      'walkInCustomerId': serializer.toJson<String?>(walkInCustomerId),
      'staffId': serializer.toJson<String>(staffId),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    Value<String?> reservationId = const Value.absent(),
    Value<String?> customerId = const Value.absent(),
    Value<String?> walkInCustomerId = const Value.absent(),
    String? staffId,
    String? status,
    DateTime? createdAt,
  }) => SessionRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    reservationId: reservationId.present
        ? reservationId.value
        : this.reservationId,
    customerId: customerId.present ? customerId.value : this.customerId,
    walkInCustomerId: walkInCustomerId.present
        ? walkInCustomerId.value
        : this.walkInCustomerId,
    staffId: staffId ?? this.staffId,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  SessionRow copyWithCompanion(SessionsCompanion data) {
    return SessionRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      reservationId: data.reservationId.present
          ? data.reservationId.value
          : this.reservationId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      walkInCustomerId: data.walkInCustomerId.present
          ? data.walkInCustomerId.value
          : this.walkInCustomerId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('reservationId: $reservationId, ')
          ..write('customerId: $customerId, ')
          ..write('walkInCustomerId: $walkInCustomerId, ')
          ..write('staffId: $staffId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    reservationId,
    customerId,
    walkInCustomerId,
    staffId,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.reservationId == this.reservationId &&
          other.customerId == this.customerId &&
          other.walkInCustomerId == this.walkInCustomerId &&
          other.staffId == this.staffId &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class SessionsCompanion extends UpdateCompanion<SessionRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String?> reservationId;
  final Value<String?> customerId;
  final Value<String?> walkInCustomerId;
  final Value<String> staffId;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.reservationId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.walkInCustomerId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    this.reservationId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.walkInCustomerId = const Value.absent(),
    required String staffId,
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       staffId = Value(staffId),
       createdAt = Value(createdAt);
  static Insertable<SessionRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? reservationId,
    Expression<String>? customerId,
    Expression<String>? walkInCustomerId,
    Expression<String>? staffId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (reservationId != null) 'reservation_id': reservationId,
      if (customerId != null) 'customer_id': customerId,
      if (walkInCustomerId != null) 'walk_in_customer_id': walkInCustomerId,
      if (staffId != null) 'staff_id': staffId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String?>? reservationId,
    Value<String?>? customerId,
    Value<String?>? walkInCustomerId,
    Value<String>? staffId,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      reservationId: reservationId ?? this.reservationId,
      customerId: customerId ?? this.customerId,
      walkInCustomerId: walkInCustomerId ?? this.walkInCustomerId,
      staffId: staffId ?? this.staffId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (reservationId.present) {
      map['reservation_id'] = Variable<String>(reservationId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (walkInCustomerId.present) {
      map['walk_in_customer_id'] = Variable<String>(walkInCustomerId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('reservationId: $reservationId, ')
          ..write('customerId: $customerId, ')
          ..write('walkInCustomerId: $walkInCustomerId, ')
          ..write('staffId: $staffId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsUnitsTable extends SessionsUnits
    with TableInfo<$SessionsUnitsTable, SessionUnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hourlyPriceMeta = const VerificationMeta(
    'hourlyPrice',
  );
  @override
  late final GeneratedColumn<int> hourlyPrice = GeneratedColumn<int>(
    'hourly_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    unitId,
    startedAt,
    endedAt,
    mode,
    plannedMinutes,
    hourlyPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionUnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('hourly_price')) {
      context.handle(
        _hourlyPriceMeta,
        hourlyPrice.isAcceptableOrUnknown(
          data['hourly_price']!,
          _hourlyPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hourlyPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionUnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionUnitRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      ),
      hourlyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hourly_price'],
      )!,
    );
  }

  @override
  $SessionsUnitsTable createAlias(String alias) {
    return $SessionsUnitsTable(attachedDatabase, alias);
  }
}

class SessionUnitRow extends DataClass implements Insertable<SessionUnitRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String sessionId;
  final String unitId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String mode;
  final int? plannedMinutes;
  final int hourlyPrice;
  const SessionUnitRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.sessionId,
    required this.unitId,
    required this.startedAt,
    this.endedAt,
    required this.mode,
    this.plannedMinutes,
    required this.hourlyPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['session_id'] = Variable<String>(sessionId);
    map['unit_id'] = Variable<String>(unitId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || plannedMinutes != null) {
      map['planned_minutes'] = Variable<int>(plannedMinutes);
    }
    map['hourly_price'] = Variable<int>(hourlyPrice);
    return map;
  }

  SessionsUnitsCompanion toCompanion(bool nullToAbsent) {
    return SessionsUnitsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      sessionId: Value(sessionId),
      unitId: Value(unitId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      mode: Value(mode),
      plannedMinutes: plannedMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedMinutes),
      hourlyPrice: Value(hourlyPrice),
    );
  }

  factory SessionUnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionUnitRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      mode: serializer.fromJson<String>(json['mode']),
      plannedMinutes: serializer.fromJson<int?>(json['plannedMinutes']),
      hourlyPrice: serializer.fromJson<int>(json['hourlyPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'sessionId': serializer.toJson<String>(sessionId),
      'unitId': serializer.toJson<String>(unitId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'mode': serializer.toJson<String>(mode),
      'plannedMinutes': serializer.toJson<int?>(plannedMinutes),
      'hourlyPrice': serializer.toJson<int>(hourlyPrice),
    };
  }

  SessionUnitRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? sessionId,
    String? unitId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    String? mode,
    Value<int?> plannedMinutes = const Value.absent(),
    int? hourlyPrice,
  }) => SessionUnitRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    sessionId: sessionId ?? this.sessionId,
    unitId: unitId ?? this.unitId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    mode: mode ?? this.mode,
    plannedMinutes: plannedMinutes.present
        ? plannedMinutes.value
        : this.plannedMinutes,
    hourlyPrice: hourlyPrice ?? this.hourlyPrice,
  );
  SessionUnitRow copyWithCompanion(SessionsUnitsCompanion data) {
    return SessionUnitRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      mode: data.mode.present ? data.mode.value : this.mode,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      hourlyPrice: data.hourlyPrice.present
          ? data.hourlyPrice.value
          : this.hourlyPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionUnitRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('mode: $mode, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('hourlyPrice: $hourlyPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    unitId,
    startedAt,
    endedAt,
    mode,
    plannedMinutes,
    hourlyPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionUnitRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.sessionId == this.sessionId &&
          other.unitId == this.unitId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.mode == this.mode &&
          other.plannedMinutes == this.plannedMinutes &&
          other.hourlyPrice == this.hourlyPrice);
}

class SessionsUnitsCompanion extends UpdateCompanion<SessionUnitRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> sessionId;
  final Value<String> unitId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<String> mode;
  final Value<int?> plannedMinutes;
  final Value<int> hourlyPrice;
  final Value<int> rowid;
  const SessionsUnitsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.mode = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.hourlyPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsUnitsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String sessionId,
    required String unitId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required String mode,
    this.plannedMinutes = const Value.absent(),
    required int hourlyPrice,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       sessionId = Value(sessionId),
       unitId = Value(unitId),
       startedAt = Value(startedAt),
       mode = Value(mode),
       hourlyPrice = Value(hourlyPrice);
  static Insertable<SessionUnitRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? sessionId,
    Expression<String>? unitId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? mode,
    Expression<int>? plannedMinutes,
    Expression<int>? hourlyPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (sessionId != null) 'session_id': sessionId,
      if (unitId != null) 'unit_id': unitId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (mode != null) 'mode': mode,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (hourlyPrice != null) 'hourly_price': hourlyPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsUnitsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? sessionId,
    Value<String>? unitId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<String>? mode,
    Value<int?>? plannedMinutes,
    Value<int>? hourlyPrice,
    Value<int>? rowid,
  }) {
    return SessionsUnitsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      sessionId: sessionId ?? this.sessionId,
      unitId: unitId ?? this.unitId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      mode: mode ?? this.mode,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      hourlyPrice: hourlyPrice ?? this.hourlyPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (hourlyPrice.present) {
      map['hourly_price'] = Variable<int>(hourlyPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsUnitsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('unitId: $unitId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('mode: $mode, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('hourlyPrice: $hourlyPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsProductsTable extends SessionsProducts
    with TableInfo<$SessionsProductsTable, SessionProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<int> unitPrice = GeneratedColumn<int>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderedAtMeta = const VerificationMeta(
    'orderedAt',
  );
  @override
  late final GeneratedColumn<DateTime> orderedAt = GeneratedColumn<DateTime>(
    'ordered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    productId,
    quantity,
    unitPrice,
    orderedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('ordered_at')) {
      context.handle(
        _orderedAtMeta,
        orderedAt.isAcceptableOrUnknown(data['ordered_at']!, _orderedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_orderedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionProductRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price'],
      )!,
      orderedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ordered_at'],
      )!,
    );
  }

  @override
  $SessionsProductsTable createAlias(String alias) {
    return $SessionsProductsTable(attachedDatabase, alias);
  }
}

class SessionProductRow extends DataClass
    implements Insertable<SessionProductRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String sessionId;
  final String productId;
  final int quantity;
  final int unitPrice;
  final DateTime orderedAt;
  const SessionProductRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.sessionId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.orderedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['session_id'] = Variable<String>(sessionId);
    map['product_id'] = Variable<String>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<int>(unitPrice);
    map['ordered_at'] = Variable<DateTime>(orderedAt);
    return map;
  }

  SessionsProductsCompanion toCompanion(bool nullToAbsent) {
    return SessionsProductsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      sessionId: Value(sessionId),
      productId: Value(productId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      orderedAt: Value(orderedAt),
    );
  }

  factory SessionProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionProductRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      productId: serializer.fromJson<String>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<int>(json['unitPrice']),
      orderedAt: serializer.fromJson<DateTime>(json['orderedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'sessionId': serializer.toJson<String>(sessionId),
      'productId': serializer.toJson<String>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<int>(unitPrice),
      'orderedAt': serializer.toJson<DateTime>(orderedAt),
    };
  }

  SessionProductRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? sessionId,
    String? productId,
    int? quantity,
    int? unitPrice,
    DateTime? orderedAt,
  }) => SessionProductRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    sessionId: sessionId ?? this.sessionId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    orderedAt: orderedAt ?? this.orderedAt,
  );
  SessionProductRow copyWithCompanion(SessionsProductsCompanion data) {
    return SessionProductRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      orderedAt: data.orderedAt.present ? data.orderedAt.value : this.orderedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionProductRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('orderedAt: $orderedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    productId,
    quantity,
    unitPrice,
    orderedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionProductRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.sessionId == this.sessionId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.orderedAt == this.orderedAt);
}

class SessionsProductsCompanion extends UpdateCompanion<SessionProductRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> sessionId;
  final Value<String> productId;
  final Value<int> quantity;
  final Value<int> unitPrice;
  final Value<DateTime> orderedAt;
  final Value<int> rowid;
  const SessionsProductsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.orderedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsProductsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String sessionId,
    required String productId,
    this.quantity = const Value.absent(),
    required int unitPrice,
    required DateTime orderedAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       sessionId = Value(sessionId),
       productId = Value(productId),
       unitPrice = Value(unitPrice),
       orderedAt = Value(orderedAt);
  static Insertable<SessionProductRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? sessionId,
    Expression<String>? productId,
    Expression<int>? quantity,
    Expression<int>? unitPrice,
    Expression<DateTime>? orderedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (sessionId != null) 'session_id': sessionId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (orderedAt != null) 'ordered_at': orderedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsProductsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? sessionId,
    Value<String>? productId,
    Value<int>? quantity,
    Value<int>? unitPrice,
    Value<DateTime>? orderedAt,
    Value<int>? rowid,
  }) {
    return SessionsProductsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      sessionId: sessionId ?? this.sessionId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      orderedAt: orderedAt ?? this.orderedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<int>(unitPrice.value);
    }
    if (orderedAt.present) {
      map['ordered_at'] = Variable<DateTime>(orderedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsProductsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('orderedAt: $orderedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockItemIdMeta = const VerificationMeta(
    'stockItemId',
  );
  @override
  late final GeneratedColumn<String> stockItemId = GeneratedColumn<String>(
    'stock_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    price,
    stockItemId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('stock_item_id')) {
      context.handle(
        _stockItemIdMeta,
        stockItemId.isAcceptableOrUnknown(
          data['stock_item_id']!,
          _stockItemIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
      stockItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stock_item_id'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductRow extends DataClass implements Insertable<ProductRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final int price;
  final String? stockItemId;
  const ProductRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    required this.price,
    this.stockItemId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<int>(price);
    if (!nullToAbsent || stockItemId != null) {
      map['stock_item_id'] = Variable<String>(stockItemId);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      price: Value(price),
      stockItemId: stockItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(stockItemId),
    );
  }

  factory ProductRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
      stockItemId: serializer.fromJson<String?>(json['stockItemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
      'stockItemId': serializer.toJson<String?>(stockItemId),
    };
  }

  ProductRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    int? price,
    Value<String?> stockItemId = const Value.absent(),
  }) => ProductRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    price: price ?? this.price,
    stockItemId: stockItemId.present ? stockItemId.value : this.stockItemId,
  );
  ProductRow copyWithCompanion(ProductsCompanion data) {
    return ProductRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      stockItemId: data.stockItemId.present
          ? data.stockItemId.value
          : this.stockItemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stockItemId: $stockItemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    price,
    stockItemId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.price == this.price &&
          other.stockItemId == this.stockItemId);
}

class ProductsCompanion extends UpdateCompanion<ProductRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<int> price;
  final Value<String?> stockItemId;
  final Value<int> rowid;
  const ProductsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.stockItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    required int price,
    this.stockItemId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name),
       price = Value(price);
  static Insertable<ProductRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<int>? price,
    Expression<String>? stockItemId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (stockItemId != null) 'stock_item_id': stockItemId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<int>? price,
    Value<String?>? stockItemId,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      price: price ?? this.price,
      stockItemId: stockItemId ?? this.stockItemId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (stockItemId.present) {
      map['stock_item_id'] = Variable<String>(stockItemId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stockItemId: $stockItemId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockItemsTable extends StockItems
    with TableInfo<$StockItemsTable, StockItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deductsOnSaleMeta = const VerificationMeta(
    'deductsOnSale',
  );
  @override
  late final GeneratedColumn<bool> deductsOnSale = GeneratedColumn<bool>(
    'deducts_on_sale',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deducts_on_sale" IN (0, 1))',
    ),
  );
  static const VerificationMeta _onHandMeta = const VerificationMeta('onHand');
  @override
  late final GeneratedColumn<int> onHand = GeneratedColumn<int>(
    'on_hand',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lowStockAtMeta = const VerificationMeta(
    'lowStockAt',
  );
  @override
  late final GeneratedColumn<int> lowStockAt = GeneratedColumn<int>(
    'low_stock_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    deductsOnSale,
    onHand,
    lowStockAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('deducts_on_sale')) {
      context.handle(
        _deductsOnSaleMeta,
        deductsOnSale.isAcceptableOrUnknown(
          data['deducts_on_sale']!,
          _deductsOnSaleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deductsOnSaleMeta);
    }
    if (data.containsKey('on_hand')) {
      context.handle(
        _onHandMeta,
        onHand.isAcceptableOrUnknown(data['on_hand']!, _onHandMeta),
      );
    }
    if (data.containsKey('low_stock_at')) {
      context.handle(
        _lowStockAtMeta,
        lowStockAt.isAcceptableOrUnknown(
          data['low_stock_at']!,
          _lowStockAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockItemRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      deductsOnSale: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deducts_on_sale'],
      )!,
      onHand: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}on_hand'],
      )!,
      lowStockAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}low_stock_at'],
      ),
    );
  }

  @override
  $StockItemsTable createAlias(String alias) {
    return $StockItemsTable(attachedDatabase, alias);
  }
}

class StockItemRow extends DataClass implements Insertable<StockItemRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final bool deductsOnSale;
  final int onHand;
  final int? lowStockAt;
  const StockItemRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    required this.deductsOnSale,
    required this.onHand,
    this.lowStockAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    map['deducts_on_sale'] = Variable<bool>(deductsOnSale);
    map['on_hand'] = Variable<int>(onHand);
    if (!nullToAbsent || lowStockAt != null) {
      map['low_stock_at'] = Variable<int>(lowStockAt);
    }
    return map;
  }

  StockItemsCompanion toCompanion(bool nullToAbsent) {
    return StockItemsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      deductsOnSale: Value(deductsOnSale),
      onHand: Value(onHand),
      lowStockAt: lowStockAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lowStockAt),
    );
  }

  factory StockItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockItemRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      deductsOnSale: serializer.fromJson<bool>(json['deductsOnSale']),
      onHand: serializer.fromJson<int>(json['onHand']),
      lowStockAt: serializer.fromJson<int?>(json['lowStockAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'deductsOnSale': serializer.toJson<bool>(deductsOnSale),
      'onHand': serializer.toJson<int>(onHand),
      'lowStockAt': serializer.toJson<int?>(lowStockAt),
    };
  }

  StockItemRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    bool? deductsOnSale,
    int? onHand,
    Value<int?> lowStockAt = const Value.absent(),
  }) => StockItemRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    deductsOnSale: deductsOnSale ?? this.deductsOnSale,
    onHand: onHand ?? this.onHand,
    lowStockAt: lowStockAt.present ? lowStockAt.value : this.lowStockAt,
  );
  StockItemRow copyWithCompanion(StockItemsCompanion data) {
    return StockItemRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      deductsOnSale: data.deductsOnSale.present
          ? data.deductsOnSale.value
          : this.deductsOnSale,
      onHand: data.onHand.present ? data.onHand.value : this.onHand,
      lowStockAt: data.lowStockAt.present
          ? data.lowStockAt.value
          : this.lowStockAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockItemRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('deductsOnSale: $deductsOnSale, ')
          ..write('onHand: $onHand, ')
          ..write('lowStockAt: $lowStockAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    deductsOnSale,
    onHand,
    lowStockAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockItemRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.deductsOnSale == this.deductsOnSale &&
          other.onHand == this.onHand &&
          other.lowStockAt == this.lowStockAt);
}

class StockItemsCompanion extends UpdateCompanion<StockItemRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<bool> deductsOnSale;
  final Value<int> onHand;
  final Value<int?> lowStockAt;
  final Value<int> rowid;
  const StockItemsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.deductsOnSale = const Value.absent(),
    this.onHand = const Value.absent(),
    this.lowStockAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockItemsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    required bool deductsOnSale,
    this.onHand = const Value.absent(),
    this.lowStockAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name),
       deductsOnSale = Value(deductsOnSale);
  static Insertable<StockItemRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<bool>? deductsOnSale,
    Expression<int>? onHand,
    Expression<int>? lowStockAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (deductsOnSale != null) 'deducts_on_sale': deductsOnSale,
      if (onHand != null) 'on_hand': onHand,
      if (lowStockAt != null) 'low_stock_at': lowStockAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockItemsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<bool>? deductsOnSale,
    Value<int>? onHand,
    Value<int?>? lowStockAt,
    Value<int>? rowid,
  }) {
    return StockItemsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      deductsOnSale: deductsOnSale ?? this.deductsOnSale,
      onHand: onHand ?? this.onHand,
      lowStockAt: lowStockAt ?? this.lowStockAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (deductsOnSale.present) {
      map['deducts_on_sale'] = Variable<bool>(deductsOnSale.value);
    }
    if (onHand.present) {
      map['on_hand'] = Variable<int>(onHand.value);
    }
    if (lowStockAt.present) {
      map['low_stock_at'] = Variable<int>(lowStockAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockItemsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('deductsOnSale: $deductsOnSale, ')
          ..write('onHand: $onHand, ')
          ..write('lowStockAt: $lowStockAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockItemIdMeta = const VerificationMeta(
    'stockItemId',
  );
  @override
  late final GeneratedColumn<String> stockItemId = GeneratedColumn<String>(
    'stock_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedQuantityMeta = const VerificationMeta(
    'expectedQuantity',
  );
  @override
  late final GeneratedColumn<int> expectedQuantity = GeneratedColumn<int>(
    'expected_quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<int> cost = GeneratedColumn<int>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    stockItemId,
    kind,
    quantity,
    purchaseId,
    expectedQuantity,
    staffId,
    cost,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('stock_item_id')) {
      context.handle(
        _stockItemIdMeta,
        stockItemId.isAcceptableOrUnknown(
          data['stock_item_id']!,
          _stockItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockItemIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('expected_quantity')) {
      context.handle(
        _expectedQuantityMeta,
        expectedQuantity.isAcceptableOrUnknown(
          data['expected_quantity']!,
          _expectedQuantityMeta,
        ),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovementRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      stockItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stock_item_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      ),
      expectedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_quantity'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovementRow extends DataClass
    implements Insertable<StockMovementRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String stockItemId;
  final String kind;
  final int quantity;
  final String? purchaseId;
  final int? expectedQuantity;
  final String staffId;
  final int? cost;
  final String? note;
  final DateTime createdAt;
  const StockMovementRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.stockItemId,
    required this.kind,
    required this.quantity,
    this.purchaseId,
    this.expectedQuantity,
    required this.staffId,
    this.cost,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['stock_item_id'] = Variable<String>(stockItemId);
    map['kind'] = Variable<String>(kind);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<String>(purchaseId);
    }
    if (!nullToAbsent || expectedQuantity != null) {
      map['expected_quantity'] = Variable<int>(expectedQuantity);
    }
    map['staff_id'] = Variable<String>(staffId);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<int>(cost);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      stockItemId: Value(stockItemId),
      kind: Value(kind),
      quantity: Value(quantity),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      expectedQuantity: expectedQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedQuantity),
      staffId: Value(staffId),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovementRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      stockItemId: serializer.fromJson<String>(json['stockItemId']),
      kind: serializer.fromJson<String>(json['kind']),
      quantity: serializer.fromJson<int>(json['quantity']),
      purchaseId: serializer.fromJson<String?>(json['purchaseId']),
      expectedQuantity: serializer.fromJson<int?>(json['expectedQuantity']),
      staffId: serializer.fromJson<String>(json['staffId']),
      cost: serializer.fromJson<int?>(json['cost']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'stockItemId': serializer.toJson<String>(stockItemId),
      'kind': serializer.toJson<String>(kind),
      'quantity': serializer.toJson<int>(quantity),
      'purchaseId': serializer.toJson<String?>(purchaseId),
      'expectedQuantity': serializer.toJson<int?>(expectedQuantity),
      'staffId': serializer.toJson<String>(staffId),
      'cost': serializer.toJson<int?>(cost),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovementRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? stockItemId,
    String? kind,
    int? quantity,
    Value<String?> purchaseId = const Value.absent(),
    Value<int?> expectedQuantity = const Value.absent(),
    String? staffId,
    Value<int?> cost = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => StockMovementRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    stockItemId: stockItemId ?? this.stockItemId,
    kind: kind ?? this.kind,
    quantity: quantity ?? this.quantity,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    expectedQuantity: expectedQuantity.present
        ? expectedQuantity.value
        : this.expectedQuantity,
    staffId: staffId ?? this.staffId,
    cost: cost.present ? cost.value : this.cost,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovementRow copyWithCompanion(StockMovementsCompanion data) {
    return StockMovementRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      stockItemId: data.stockItemId.present
          ? data.stockItemId.value
          : this.stockItemId,
      kind: data.kind.present ? data.kind.value : this.kind,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      expectedQuantity: data.expectedQuantity.present
          ? data.expectedQuantity.value
          : this.expectedQuantity,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      cost: data.cost.present ? data.cost.value : this.cost,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('stockItemId: $stockItemId, ')
          ..write('kind: $kind, ')
          ..write('quantity: $quantity, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('expectedQuantity: $expectedQuantity, ')
          ..write('staffId: $staffId, ')
          ..write('cost: $cost, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    stockItemId,
    kind,
    quantity,
    purchaseId,
    expectedQuantity,
    staffId,
    cost,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovementRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.stockItemId == this.stockItemId &&
          other.kind == this.kind &&
          other.quantity == this.quantity &&
          other.purchaseId == this.purchaseId &&
          other.expectedQuantity == this.expectedQuantity &&
          other.staffId == this.staffId &&
          other.cost == this.cost &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovementRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> stockItemId;
  final Value<String> kind;
  final Value<int> quantity;
  final Value<String?> purchaseId;
  final Value<int?> expectedQuantity;
  final Value<String> staffId;
  final Value<int?> cost;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StockMovementsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.stockItemId = const Value.absent(),
    this.kind = const Value.absent(),
    this.quantity = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.expectedQuantity = const Value.absent(),
    this.staffId = const Value.absent(),
    this.cost = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String stockItemId,
    required String kind,
    required int quantity,
    this.purchaseId = const Value.absent(),
    this.expectedQuantity = const Value.absent(),
    required String staffId,
    this.cost = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       stockItemId = Value(stockItemId),
       kind = Value(kind),
       quantity = Value(quantity),
       staffId = Value(staffId),
       createdAt = Value(createdAt);
  static Insertable<StockMovementRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? stockItemId,
    Expression<String>? kind,
    Expression<int>? quantity,
    Expression<String>? purchaseId,
    Expression<int>? expectedQuantity,
    Expression<String>? staffId,
    Expression<int>? cost,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (stockItemId != null) 'stock_item_id': stockItemId,
      if (kind != null) 'kind': kind,
      if (quantity != null) 'quantity': quantity,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (expectedQuantity != null) 'expected_quantity': expectedQuantity,
      if (staffId != null) 'staff_id': staffId,
      if (cost != null) 'cost': cost,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovementsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? stockItemId,
    Value<String>? kind,
    Value<int>? quantity,
    Value<String?>? purchaseId,
    Value<int?>? expectedQuantity,
    Value<String>? staffId,
    Value<int?>? cost,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StockMovementsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      stockItemId: stockItemId ?? this.stockItemId,
      kind: kind ?? this.kind,
      quantity: quantity ?? this.quantity,
      purchaseId: purchaseId ?? this.purchaseId,
      expectedQuantity: expectedQuantity ?? this.expectedQuantity,
      staffId: staffId ?? this.staffId,
      cost: cost ?? this.cost,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (stockItemId.present) {
      map['stock_item_id'] = Variable<String>(stockItemId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (expectedQuantity.present) {
      map['expected_quantity'] = Variable<int>(expectedQuantity.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (cost.present) {
      map['cost'] = Variable<int>(cost.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('stockItemId: $stockItemId, ')
          ..write('kind: $kind, ')
          ..write('quantity: $quantity, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('expectedQuantity: $expectedQuantity, ')
          ..write('staffId: $staffId, ')
          ..write('cost: $cost, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, PurchaseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    staffId,
    total,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class PurchaseRow extends DataClass implements Insertable<PurchaseRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String staffId;
  final int total;
  final DateTime createdAt;
  const PurchaseRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.staffId,
    required this.total,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['staff_id'] = Variable<String>(staffId);
    map['total'] = Variable<int>(total);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      staffId: Value(staffId),
      total: Value(total),
      createdAt: Value(createdAt),
    );
  }

  factory PurchaseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      total: serializer.fromJson<int>(json['total']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'staffId': serializer.toJson<String>(staffId),
      'total': serializer.toJson<int>(total),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PurchaseRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? staffId,
    int? total,
    DateTime? createdAt,
  }) => PurchaseRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    staffId: staffId ?? this.staffId,
    total: total ?? this.total,
    createdAt: createdAt ?? this.createdAt,
  );
  PurchaseRow copyWithCompanion(PurchasesCompanion data) {
    return PurchaseRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      total: data.total.present ? data.total.value : this.total,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('staffId: $staffId, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    staffId,
    total,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.staffId == this.staffId &&
          other.total == this.total &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<PurchaseRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> staffId;
  final Value<int> total;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PurchasesCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.total = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchasesCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String staffId,
    required int total,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       staffId = Value(staffId),
       total = Value(total),
       createdAt = Value(createdAt);
  static Insertable<PurchaseRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? staffId,
    Expression<int>? total,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (staffId != null) 'staff_id': staffId,
      if (total != null) 'total': total,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchasesCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? staffId,
    Value<int>? total,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PurchasesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      staffId: staffId ?? this.staffId,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('staffId: $staffId, ')
          ..write('total: $total, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillsTable extends Bills with TableInfo<$BillsTable, BillRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<String> shiftId = GeneratedColumn<String>(
    'shift_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountNoteMeta = const VerificationMeta(
    'discountNote',
  );
  @override
  late final GeneratedColumn<String> discountNote = GeneratedColumn<String>(
    'discount_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    staffId,
    shiftId,
    subtotal,
    discount,
    total,
    discountNote,
    paymentMethod,
    paidAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('discount_note')) {
      context.handle(
        _discountNoteMeta,
        discountNote.isAcceptableOrUnknown(
          data['discount_note']!,
          _discountNoteMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_id'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      discountNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discount_note'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
    );
  }

  @override
  $BillsTable createAlias(String alias) {
    return $BillsTable(attachedDatabase, alias);
  }
}

class BillRow extends DataClass implements Insertable<BillRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String? sessionId;
  final String staffId;
  final String shiftId;
  final int subtotal;
  final int discount;
  final int total;
  final String? discountNote;
  final String paymentMethod;
  final DateTime paidAt;
  const BillRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    this.sessionId,
    required this.staffId,
    required this.shiftId,
    required this.subtotal,
    required this.discount,
    required this.total,
    this.discountNote,
    required this.paymentMethod,
    required this.paidAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    map['staff_id'] = Variable<String>(staffId);
    map['shift_id'] = Variable<String>(shiftId);
    map['subtotal'] = Variable<int>(subtotal);
    map['discount'] = Variable<int>(discount);
    map['total'] = Variable<int>(total);
    if (!nullToAbsent || discountNote != null) {
      map['discount_note'] = Variable<String>(discountNote);
    }
    map['payment_method'] = Variable<String>(paymentMethod);
    map['paid_at'] = Variable<DateTime>(paidAt);
    return map;
  }

  BillsCompanion toCompanion(bool nullToAbsent) {
    return BillsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      staffId: Value(staffId),
      shiftId: Value(shiftId),
      subtotal: Value(subtotal),
      discount: Value(discount),
      total: Value(total),
      discountNote: discountNote == null && nullToAbsent
          ? const Value.absent()
          : Value(discountNote),
      paymentMethod: Value(paymentMethod),
      paidAt: Value(paidAt),
    );
  }

  factory BillRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      shiftId: serializer.fromJson<String>(json['shiftId']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      discount: serializer.fromJson<int>(json['discount']),
      total: serializer.fromJson<int>(json['total']),
      discountNote: serializer.fromJson<String?>(json['discountNote']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'sessionId': serializer.toJson<String?>(sessionId),
      'staffId': serializer.toJson<String>(staffId),
      'shiftId': serializer.toJson<String>(shiftId),
      'subtotal': serializer.toJson<int>(subtotal),
      'discount': serializer.toJson<int>(discount),
      'total': serializer.toJson<int>(total),
      'discountNote': serializer.toJson<String?>(discountNote),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paidAt': serializer.toJson<DateTime>(paidAt),
    };
  }

  BillRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    Value<String?> sessionId = const Value.absent(),
    String? staffId,
    String? shiftId,
    int? subtotal,
    int? discount,
    int? total,
    Value<String?> discountNote = const Value.absent(),
    String? paymentMethod,
    DateTime? paidAt,
  }) => BillRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    staffId: staffId ?? this.staffId,
    shiftId: shiftId ?? this.shiftId,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    total: total ?? this.total,
    discountNote: discountNote.present ? discountNote.value : this.discountNote,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paidAt: paidAt ?? this.paidAt,
  );
  BillRow copyWithCompanion(BillsCompanion data) {
    return BillRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      total: data.total.present ? data.total.value : this.total,
      discountNote: data.discountNote.present
          ? data.discountNote.value
          : this.discountNote,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('staffId: $staffId, ')
          ..write('shiftId: $shiftId, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('discountNote: $discountNote, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    sessionId,
    staffId,
    shiftId,
    subtotal,
    discount,
    total,
    discountNote,
    paymentMethod,
    paidAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.sessionId == this.sessionId &&
          other.staffId == this.staffId &&
          other.shiftId == this.shiftId &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.total == this.total &&
          other.discountNote == this.discountNote &&
          other.paymentMethod == this.paymentMethod &&
          other.paidAt == this.paidAt);
}

class BillsCompanion extends UpdateCompanion<BillRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String?> sessionId;
  final Value<String> staffId;
  final Value<String> shiftId;
  final Value<int> subtotal;
  final Value<int> discount;
  final Value<int> total;
  final Value<String?> discountNote;
  final Value<String> paymentMethod;
  final Value<DateTime> paidAt;
  final Value<int> rowid;
  const BillsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.total = const Value.absent(),
    this.discountNote = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    this.sessionId = const Value.absent(),
    required String staffId,
    required String shiftId,
    required int subtotal,
    required int discount,
    required int total,
    this.discountNote = const Value.absent(),
    required String paymentMethod,
    required DateTime paidAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       staffId = Value(staffId),
       shiftId = Value(shiftId),
       subtotal = Value(subtotal),
       discount = Value(discount),
       total = Value(total),
       paymentMethod = Value(paymentMethod),
       paidAt = Value(paidAt);
  static Insertable<BillRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? sessionId,
    Expression<String>? staffId,
    Expression<String>? shiftId,
    Expression<int>? subtotal,
    Expression<int>? discount,
    Expression<int>? total,
    Expression<String>? discountNote,
    Expression<String>? paymentMethod,
    Expression<DateTime>? paidAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (sessionId != null) 'session_id': sessionId,
      if (staffId != null) 'staff_id': staffId,
      if (shiftId != null) 'shift_id': shiftId,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (total != null) 'total': total,
      if (discountNote != null) 'discount_note': discountNote,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paidAt != null) 'paid_at': paidAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String?>? sessionId,
    Value<String>? staffId,
    Value<String>? shiftId,
    Value<int>? subtotal,
    Value<int>? discount,
    Value<int>? total,
    Value<String?>? discountNote,
    Value<String>? paymentMethod,
    Value<DateTime>? paidAt,
    Value<int>? rowid,
  }) {
    return BillsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      sessionId: sessionId ?? this.sessionId,
      staffId: staffId ?? this.staffId,
      shiftId: shiftId ?? this.shiftId,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      discountNote: discountNote ?? this.discountNote,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paidAt: paidAt ?? this.paidAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<String>(shiftId.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (discountNote.present) {
      map['discount_note'] = Variable<String>(discountNote.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('sessionId: $sessionId, ')
          ..write('staffId: $staffId, ')
          ..write('shiftId: $shiftId, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('total: $total, ')
          ..write('discountNote: $discountNote, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paidAt: $paidAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillItemsTable extends BillItems
    with TableInfo<$BillItemsTable, BillItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<int> unitPrice = GeneratedColumn<int>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    billId,
    productId,
    description,
    quantity,
    unitPrice,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillItemRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $BillItemsTable createAlias(String alias) {
    return $BillItemsTable(attachedDatabase, alias);
  }
}

class BillItemRow extends DataClass implements Insertable<BillItemRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String billId;
  final String? productId;
  final String description;
  final int quantity;
  final int unitPrice;
  final int total;
  const BillItemRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.billId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['bill_id'] = Variable<String>(billId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<String>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<int>(unitPrice);
    map['total'] = Variable<int>(total);
    return map;
  }

  BillItemsCompanion toCompanion(bool nullToAbsent) {
    return BillItemsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      billId: Value(billId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      total: Value(total),
    );
  }

  factory BillItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillItemRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      billId: serializer.fromJson<String>(json['billId']),
      productId: serializer.fromJson<String?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<int>(json['unitPrice']),
      total: serializer.fromJson<int>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'billId': serializer.toJson<String>(billId),
      'productId': serializer.toJson<String?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<int>(unitPrice),
      'total': serializer.toJson<int>(total),
    };
  }

  BillItemRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? billId,
    Value<String?> productId = const Value.absent(),
    String? description,
    int? quantity,
    int? unitPrice,
    int? total,
  }) => BillItemRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    billId: billId ?? this.billId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    total: total ?? this.total,
  );
  BillItemRow copyWithCompanion(BillItemsCompanion data) {
    return BillItemRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      billId: data.billId.present ? data.billId.value : this.billId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillItemRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('billId: $billId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    billId,
    productId,
    description,
    quantity,
    unitPrice,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItemRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.billId == this.billId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total);
}

class BillItemsCompanion extends UpdateCompanion<BillItemRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> billId;
  final Value<String?> productId;
  final Value<String> description;
  final Value<int> quantity;
  final Value<int> unitPrice;
  final Value<int> total;
  final Value<int> rowid;
  const BillItemsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.billId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillItemsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String billId,
    this.productId = const Value.absent(),
    required String description,
    this.quantity = const Value.absent(),
    required int unitPrice,
    required int total,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       billId = Value(billId),
       description = Value(description),
       unitPrice = Value(unitPrice),
       total = Value(total);
  static Insertable<BillItemRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? billId,
    Expression<String>? productId,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<int>? unitPrice,
    Expression<int>? total,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (billId != null) 'bill_id': billId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillItemsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? billId,
    Value<String?>? productId,
    Value<String>? description,
    Value<int>? quantity,
    Value<int>? unitPrice,
    Value<int>? total,
    Value<int>? rowid,
  }) {
    return BillItemsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      billId: billId ?? this.billId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<int>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('billId: $billId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftsTable extends Shifts with TableInfo<$ShiftsTable, ShiftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedByStaffIdMeta = const VerificationMeta(
    'openedByStaffId',
  );
  @override
  late final GeneratedColumn<String> openedByStaffId = GeneratedColumn<String>(
    'opened_by_staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingCashMeta = const VerificationMeta(
    'openingCash',
  );
  @override
  late final GeneratedColumn<int> openingCash = GeneratedColumn<int>(
    'opening_cash',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _closedByStaffIdMeta = const VerificationMeta(
    'closedByStaffId',
  );
  @override
  late final GeneratedColumn<String> closedByStaffId = GeneratedColumn<String>(
    'closed_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta(
    'closedAt',
  );
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedCashMeta = const VerificationMeta(
    'expectedCash',
  );
  @override
  late final GeneratedColumn<int> expectedCash = GeneratedColumn<int>(
    'expected_cash',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countedCashMeta = const VerificationMeta(
    'countedCash',
  );
  @override
  late final GeneratedColumn<int> countedCash = GeneratedColumn<int>(
    'counted_cash',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    openedByStaffId,
    openedAt,
    openingCash,
    closedByStaffId,
    closedAt,
    expectedCash,
    countedCash,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('opened_by_staff_id')) {
      context.handle(
        _openedByStaffIdMeta,
        openedByStaffId.isAcceptableOrUnknown(
          data['opened_by_staff_id']!,
          _openedByStaffIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openedByStaffIdMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_openedAtMeta);
    }
    if (data.containsKey('opening_cash')) {
      context.handle(
        _openingCashMeta,
        openingCash.isAcceptableOrUnknown(
          data['opening_cash']!,
          _openingCashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingCashMeta);
    }
    if (data.containsKey('closed_by_staff_id')) {
      context.handle(
        _closedByStaffIdMeta,
        closedByStaffId.isAcceptableOrUnknown(
          data['closed_by_staff_id']!,
          _closedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('closed_at')) {
      context.handle(
        _closedAtMeta,
        closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta),
      );
    }
    if (data.containsKey('expected_cash')) {
      context.handle(
        _expectedCashMeta,
        expectedCash.isAcceptableOrUnknown(
          data['expected_cash']!,
          _expectedCashMeta,
        ),
      );
    }
    if (data.containsKey('counted_cash')) {
      context.handle(
        _countedCashMeta,
        countedCash.isAcceptableOrUnknown(
          data['counted_cash']!,
          _countedCashMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      openedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opened_by_staff_id'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
      openingCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_cash'],
      )!,
      closedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closed_by_staff_id'],
      ),
      closedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closed_at'],
      ),
      expectedCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_cash'],
      ),
      countedCash: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}counted_cash'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $ShiftsTable createAlias(String alias) {
    return $ShiftsTable(attachedDatabase, alias);
  }
}

class ShiftRow extends DataClass implements Insertable<ShiftRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String openedByStaffId;
  final DateTime openedAt;
  final int openingCash;
  final String? closedByStaffId;
  final DateTime? closedAt;
  final int? expectedCash;
  final int? countedCash;
  final String? note;
  const ShiftRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.openedByStaffId,
    required this.openedAt,
    required this.openingCash,
    this.closedByStaffId,
    this.closedAt,
    this.expectedCash,
    this.countedCash,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['opened_by_staff_id'] = Variable<String>(openedByStaffId);
    map['opened_at'] = Variable<DateTime>(openedAt);
    map['opening_cash'] = Variable<int>(openingCash);
    if (!nullToAbsent || closedByStaffId != null) {
      map['closed_by_staff_id'] = Variable<String>(closedByStaffId);
    }
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || expectedCash != null) {
      map['expected_cash'] = Variable<int>(expectedCash);
    }
    if (!nullToAbsent || countedCash != null) {
      map['counted_cash'] = Variable<int>(countedCash);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  ShiftsCompanion toCompanion(bool nullToAbsent) {
    return ShiftsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      openedByStaffId: Value(openedByStaffId),
      openedAt: Value(openedAt),
      openingCash: Value(openingCash),
      closedByStaffId: closedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(closedByStaffId),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      expectedCash: expectedCash == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedCash),
      countedCash: countedCash == null && nullToAbsent
          ? const Value.absent()
          : Value(countedCash),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory ShiftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      openedByStaffId: serializer.fromJson<String>(json['openedByStaffId']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      openingCash: serializer.fromJson<int>(json['openingCash']),
      closedByStaffId: serializer.fromJson<String?>(json['closedByStaffId']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      expectedCash: serializer.fromJson<int?>(json['expectedCash']),
      countedCash: serializer.fromJson<int?>(json['countedCash']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'openedByStaffId': serializer.toJson<String>(openedByStaffId),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'openingCash': serializer.toJson<int>(openingCash),
      'closedByStaffId': serializer.toJson<String?>(closedByStaffId),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'expectedCash': serializer.toJson<int?>(expectedCash),
      'countedCash': serializer.toJson<int?>(countedCash),
      'note': serializer.toJson<String?>(note),
    };
  }

  ShiftRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? openedByStaffId,
    DateTime? openedAt,
    int? openingCash,
    Value<String?> closedByStaffId = const Value.absent(),
    Value<DateTime?> closedAt = const Value.absent(),
    Value<int?> expectedCash = const Value.absent(),
    Value<int?> countedCash = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => ShiftRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    openedByStaffId: openedByStaffId ?? this.openedByStaffId,
    openedAt: openedAt ?? this.openedAt,
    openingCash: openingCash ?? this.openingCash,
    closedByStaffId: closedByStaffId.present
        ? closedByStaffId.value
        : this.closedByStaffId,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    expectedCash: expectedCash.present ? expectedCash.value : this.expectedCash,
    countedCash: countedCash.present ? countedCash.value : this.countedCash,
    note: note.present ? note.value : this.note,
  );
  ShiftRow copyWithCompanion(ShiftsCompanion data) {
    return ShiftRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      openedByStaffId: data.openedByStaffId.present
          ? data.openedByStaffId.value
          : this.openedByStaffId,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      openingCash: data.openingCash.present
          ? data.openingCash.value
          : this.openingCash,
      closedByStaffId: data.closedByStaffId.present
          ? data.closedByStaffId.value
          : this.closedByStaffId,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      expectedCash: data.expectedCash.present
          ? data.expectedCash.value
          : this.expectedCash,
      countedCash: data.countedCash.present
          ? data.countedCash.value
          : this.countedCash,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('openedByStaffId: $openedByStaffId, ')
          ..write('openedAt: $openedAt, ')
          ..write('openingCash: $openingCash, ')
          ..write('closedByStaffId: $closedByStaffId, ')
          ..write('closedAt: $closedAt, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('countedCash: $countedCash, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    openedByStaffId,
    openedAt,
    openingCash,
    closedByStaffId,
    closedAt,
    expectedCash,
    countedCash,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.openedByStaffId == this.openedByStaffId &&
          other.openedAt == this.openedAt &&
          other.openingCash == this.openingCash &&
          other.closedByStaffId == this.closedByStaffId &&
          other.closedAt == this.closedAt &&
          other.expectedCash == this.expectedCash &&
          other.countedCash == this.countedCash &&
          other.note == this.note);
}

class ShiftsCompanion extends UpdateCompanion<ShiftRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> openedByStaffId;
  final Value<DateTime> openedAt;
  final Value<int> openingCash;
  final Value<String?> closedByStaffId;
  final Value<DateTime?> closedAt;
  final Value<int?> expectedCash;
  final Value<int?> countedCash;
  final Value<String?> note;
  final Value<int> rowid;
  const ShiftsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.openedByStaffId = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.openingCash = const Value.absent(),
    this.closedByStaffId = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.expectedCash = const Value.absent(),
    this.countedCash = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String openedByStaffId,
    required DateTime openedAt,
    required int openingCash,
    this.closedByStaffId = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.expectedCash = const Value.absent(),
    this.countedCash = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       openedByStaffId = Value(openedByStaffId),
       openedAt = Value(openedAt),
       openingCash = Value(openingCash);
  static Insertable<ShiftRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? openedByStaffId,
    Expression<DateTime>? openedAt,
    Expression<int>? openingCash,
    Expression<String>? closedByStaffId,
    Expression<DateTime>? closedAt,
    Expression<int>? expectedCash,
    Expression<int>? countedCash,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (openedByStaffId != null) 'opened_by_staff_id': openedByStaffId,
      if (openedAt != null) 'opened_at': openedAt,
      if (openingCash != null) 'opening_cash': openingCash,
      if (closedByStaffId != null) 'closed_by_staff_id': closedByStaffId,
      if (closedAt != null) 'closed_at': closedAt,
      if (expectedCash != null) 'expected_cash': expectedCash,
      if (countedCash != null) 'counted_cash': countedCash,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? openedByStaffId,
    Value<DateTime>? openedAt,
    Value<int>? openingCash,
    Value<String?>? closedByStaffId,
    Value<DateTime?>? closedAt,
    Value<int?>? expectedCash,
    Value<int?>? countedCash,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return ShiftsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      openedByStaffId: openedByStaffId ?? this.openedByStaffId,
      openedAt: openedAt ?? this.openedAt,
      openingCash: openingCash ?? this.openingCash,
      closedByStaffId: closedByStaffId ?? this.closedByStaffId,
      closedAt: closedAt ?? this.closedAt,
      expectedCash: expectedCash ?? this.expectedCash,
      countedCash: countedCash ?? this.countedCash,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (openedByStaffId.present) {
      map['opened_by_staff_id'] = Variable<String>(openedByStaffId.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (openingCash.present) {
      map['opening_cash'] = Variable<int>(openingCash.value);
    }
    if (closedByStaffId.present) {
      map['closed_by_staff_id'] = Variable<String>(closedByStaffId.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (expectedCash.present) {
      map['expected_cash'] = Variable<int>(expectedCash.value);
    }
    if (countedCash.present) {
      map['counted_cash'] = Variable<int>(countedCash.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('openedByStaffId: $openedByStaffId, ')
          ..write('openedAt: $openedAt, ')
          ..write('openingCash: $openingCash, ')
          ..write('closedByStaffId: $closedByStaffId, ')
          ..write('closedAt: $closedAt, ')
          ..write('expectedCash: $expectedCash, ')
          ..write('countedCash: $countedCash, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CashMovementsTable extends CashMovements
    with TableInfo<$CashMovementsTable, CashMovementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta(
    'shiftId',
  );
  @override
  late final GeneratedColumn<String> shiftId = GeneratedColumn<String>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paidFromMeta = const VerificationMeta(
    'paidFrom',
  );
  @override
  late final GeneratedColumn<String> paidFrom = GeneratedColumn<String>(
    'paid_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('CashBox'),
  );
  static const VerificationMeta _owedMeta = const VerificationMeta('owed');
  @override
  late final GeneratedColumn<bool> owed = GeneratedColumn<bool>(
    'owed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("owed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reimbursedAtMeta = const VerificationMeta(
    'reimbursedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reimbursedAt = GeneratedColumn<DateTime>(
    'reimbursed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    shiftId,
    staffId,
    type,
    amount,
    note,
    paidFrom,
    owed,
    reimbursedAt,
    purchaseId,
    categoryId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashMovementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('shift_id')) {
      context.handle(
        _shiftIdMeta,
        shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('paid_from')) {
      context.handle(
        _paidFromMeta,
        paidFrom.isAcceptableOrUnknown(data['paid_from']!, _paidFromMeta),
      );
    }
    if (data.containsKey('owed')) {
      context.handle(
        _owedMeta,
        owed.isAcceptableOrUnknown(data['owed']!, _owedMeta),
      );
    }
    if (data.containsKey('reimbursed_at')) {
      context.handle(
        _reimbursedAtMeta,
        reimbursedAt.isAcceptableOrUnknown(
          data['reimbursed_at']!,
          _reimbursedAtMeta,
        ),
      );
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashMovementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashMovementRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      shiftId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shift_id'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      paidFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_from'],
      )!,
      owed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}owed'],
      )!,
      reimbursedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reimbursed_at'],
      ),
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CashMovementsTable createAlias(String alias) {
    return $CashMovementsTable(attachedDatabase, alias);
  }
}

class CashMovementRow extends DataClass implements Insertable<CashMovementRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String? shiftId;
  final String staffId;
  final String type;
  final int amount;
  final String? note;
  final String paidFrom;
  final bool owed;
  final DateTime? reimbursedAt;
  final String? purchaseId;
  final String? categoryId;
  final DateTime createdAt;
  const CashMovementRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    this.shiftId,
    required this.staffId,
    required this.type,
    required this.amount,
    this.note,
    required this.paidFrom,
    required this.owed,
    this.reimbursedAt,
    this.purchaseId,
    this.categoryId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<String>(shiftId);
    }
    map['staff_id'] = Variable<String>(staffId);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['paid_from'] = Variable<String>(paidFrom);
    map['owed'] = Variable<bool>(owed);
    if (!nullToAbsent || reimbursedAt != null) {
      map['reimbursed_at'] = Variable<DateTime>(reimbursedAt);
    }
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<String>(purchaseId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashMovementsCompanion toCompanion(bool nullToAbsent) {
    return CashMovementsCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      shiftId: shiftId == null && nullToAbsent
          ? const Value.absent()
          : Value(shiftId),
      staffId: Value(staffId),
      type: Value(type),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      paidFrom: Value(paidFrom),
      owed: Value(owed),
      reimbursedAt: reimbursedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reimbursedAt),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      createdAt: Value(createdAt),
    );
  }

  factory CashMovementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashMovementRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      shiftId: serializer.fromJson<String?>(json['shiftId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<int>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      paidFrom: serializer.fromJson<String>(json['paidFrom']),
      owed: serializer.fromJson<bool>(json['owed']),
      reimbursedAt: serializer.fromJson<DateTime?>(json['reimbursedAt']),
      purchaseId: serializer.fromJson<String?>(json['purchaseId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'shiftId': serializer.toJson<String?>(shiftId),
      'staffId': serializer.toJson<String>(staffId),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<int>(amount),
      'note': serializer.toJson<String?>(note),
      'paidFrom': serializer.toJson<String>(paidFrom),
      'owed': serializer.toJson<bool>(owed),
      'reimbursedAt': serializer.toJson<DateTime?>(reimbursedAt),
      'purchaseId': serializer.toJson<String?>(purchaseId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashMovementRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    Value<String?> shiftId = const Value.absent(),
    String? staffId,
    String? type,
    int? amount,
    Value<String?> note = const Value.absent(),
    String? paidFrom,
    bool? owed,
    Value<DateTime?> reimbursedAt = const Value.absent(),
    Value<String?> purchaseId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    DateTime? createdAt,
  }) => CashMovementRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
    staffId: staffId ?? this.staffId,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
    paidFrom: paidFrom ?? this.paidFrom,
    owed: owed ?? this.owed,
    reimbursedAt: reimbursedAt.present ? reimbursedAt.value : this.reimbursedAt,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    createdAt: createdAt ?? this.createdAt,
  );
  CashMovementRow copyWithCompanion(CashMovementsCompanion data) {
    return CashMovementRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      paidFrom: data.paidFrom.present ? data.paidFrom.value : this.paidFrom,
      owed: data.owed.present ? data.owed.value : this.owed,
      reimbursedAt: data.reimbursedAt.present
          ? data.reimbursedAt.value
          : this.reimbursedAt,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashMovementRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('shiftId: $shiftId, ')
          ..write('staffId: $staffId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('owed: $owed, ')
          ..write('reimbursedAt: $reimbursedAt, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    shiftId,
    staffId,
    type,
    amount,
    note,
    paidFrom,
    owed,
    reimbursedAt,
    purchaseId,
    categoryId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashMovementRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.shiftId == this.shiftId &&
          other.staffId == this.staffId &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.paidFrom == this.paidFrom &&
          other.owed == this.owed &&
          other.reimbursedAt == this.reimbursedAt &&
          other.purchaseId == this.purchaseId &&
          other.categoryId == this.categoryId &&
          other.createdAt == this.createdAt);
}

class CashMovementsCompanion extends UpdateCompanion<CashMovementRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String?> shiftId;
  final Value<String> staffId;
  final Value<String> type;
  final Value<int> amount;
  final Value<String?> note;
  final Value<String> paidFrom;
  final Value<bool> owed;
  final Value<DateTime?> reimbursedAt;
  final Value<String?> purchaseId;
  final Value<String?> categoryId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CashMovementsCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.owed = const Value.absent(),
    this.reimbursedAt = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashMovementsCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    this.shiftId = const Value.absent(),
    required String staffId,
    required String type,
    required int amount,
    this.note = const Value.absent(),
    this.paidFrom = const Value.absent(),
    this.owed = const Value.absent(),
    this.reimbursedAt = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.categoryId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       staffId = Value(staffId),
       type = Value(type),
       amount = Value(amount),
       createdAt = Value(createdAt);
  static Insertable<CashMovementRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? shiftId,
    Expression<String>? staffId,
    Expression<String>? type,
    Expression<int>? amount,
    Expression<String>? note,
    Expression<String>? paidFrom,
    Expression<bool>? owed,
    Expression<DateTime>? reimbursedAt,
    Expression<String>? purchaseId,
    Expression<String>? categoryId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (shiftId != null) 'shift_id': shiftId,
      if (staffId != null) 'staff_id': staffId,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (paidFrom != null) 'paid_from': paidFrom,
      if (owed != null) 'owed': owed,
      if (reimbursedAt != null) 'reimbursed_at': reimbursedAt,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (categoryId != null) 'category_id': categoryId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashMovementsCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String?>? shiftId,
    Value<String>? staffId,
    Value<String>? type,
    Value<int>? amount,
    Value<String?>? note,
    Value<String>? paidFrom,
    Value<bool>? owed,
    Value<DateTime?>? reimbursedAt,
    Value<String?>? purchaseId,
    Value<String?>? categoryId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CashMovementsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      shiftId: shiftId ?? this.shiftId,
      staffId: staffId ?? this.staffId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      paidFrom: paidFrom ?? this.paidFrom,
      owed: owed ?? this.owed,
      reimbursedAt: reimbursedAt ?? this.reimbursedAt,
      purchaseId: purchaseId ?? this.purchaseId,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<String>(shiftId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (paidFrom.present) {
      map['paid_from'] = Variable<String>(paidFrom.value);
    }
    if (owed.present) {
      map['owed'] = Variable<bool>(owed.value);
    }
    if (reimbursedAt.present) {
      map['reimbursed_at'] = Variable<DateTime>(reimbursedAt.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashMovementsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('shiftId: $shiftId, ')
          ..write('staffId: $staffId, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('paidFrom: $paidFrom, ')
          ..write('owed: $owed, ')
          ..write('reimbursedAt: $reimbursedAt, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('categoryId: $categoryId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoriesTable extends ExpenseCategories
    with TableInfo<$ExpenseCategoriesTable, ExpenseCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    kind,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategoryRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ExpenseCategoriesTable createAlias(String alias) {
    return $ExpenseCategoriesTable(attachedDatabase, alias);
  }
}

class ExpenseCategoryRow extends DataClass
    implements Insertable<ExpenseCategoryRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final String kind;
  final bool isActive;
  const ExpenseCategoryRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    required this.kind,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ExpenseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoriesCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      kind: Value(kind),
      isActive: Value(isActive),
    );
  }

  factory ExpenseCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategoryRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ExpenseCategoryRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    String? kind,
    bool? isActive,
  }) => ExpenseCategoryRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    isActive: isActive ?? this.isActive,
  );
  ExpenseCategoryRow copyWithCompanion(ExpenseCategoriesCompanion data) {
    return ExpenseCategoryRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoryRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    kind,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategoryRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.isActive == this.isActive);
}

class ExpenseCategoriesCompanion extends UpdateCompanion<ExpenseCategoryRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<String> kind;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ExpenseCategoriesCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseCategoriesCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    required String kind,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name),
       kind = Value(kind);
  static Insertable<ExpenseCategoryRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseCategoriesCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<String>? kind,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ExpenseCategoriesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StaffTable extends Staff with TableInfo<$StaffTable, StaffRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOwnerMeta = const VerificationMeta(
    'isOwner',
  );
  @override
  late final GeneratedColumn<bool> isOwner = GeneratedColumn<bool>(
    'is_owner',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_owner" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    phone,
    pinHash,
    role,
    isOwner,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('is_owner')) {
      context.handle(
        _isOwnerMeta,
        isOwner.isAcceptableOrUnknown(data['is_owner']!, _isOwnerMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isOwner: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_owner'],
      )!,
    );
  }

  @override
  $StaffTable createAlias(String alias) {
    return $StaffTable(attachedDatabase, alias);
  }
}

class StaffRow extends DataClass implements Insertable<StaffRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String venueId;
  final String name;
  final String? phone;
  final String? pinHash;
  final String role;
  final bool isOwner;
  const StaffRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.venueId,
    required this.name,
    this.phone,
    this.pinHash,
    required this.role,
    required this.isOwner,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || pinHash != null) {
      map['pin_hash'] = Variable<String>(pinHash);
    }
    map['role'] = Variable<String>(role);
    map['is_owner'] = Variable<bool>(isOwner);
    return map;
  }

  StaffCompanion toCompanion(bool nullToAbsent) {
    return StaffCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      venueId: Value(venueId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      pinHash: pinHash == null && nullToAbsent
          ? const Value.absent()
          : Value(pinHash),
      role: Value(role),
      isOwner: Value(isOwner),
    );
  }

  factory StaffRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      pinHash: serializer.fromJson<String?>(json['pinHash']),
      role: serializer.fromJson<String>(json['role']),
      isOwner: serializer.fromJson<bool>(json['isOwner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'pinHash': serializer.toJson<String?>(pinHash),
      'role': serializer.toJson<String>(role),
      'isOwner': serializer.toJson<bool>(isOwner),
    };
  }

  StaffRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? venueId,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> pinHash = const Value.absent(),
    String? role,
    bool? isOwner,
  }) => StaffRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    pinHash: pinHash.present ? pinHash.value : this.pinHash,
    role: role ?? this.role,
    isOwner: isOwner ?? this.isOwner,
  );
  StaffRow copyWithCompanion(StaffCompanion data) {
    return StaffRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      role: data.role.present ? data.role.value : this.role,
      isOwner: data.isOwner.present ? data.isOwner.value : this.isOwner,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('pinHash: $pinHash, ')
          ..write('role: $role, ')
          ..write('isOwner: $isOwner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    venueId,
    name,
    phone,
    pinHash,
    role,
    isOwner,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.pinHash == this.pinHash &&
          other.role == this.role &&
          other.isOwner == this.isOwner);
}

class StaffCompanion extends UpdateCompanion<StaffRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> pinHash;
  final Value<String> role;
  final Value<bool> isOwner;
  final Value<int> rowid;
  const StaffCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.role = const Value.absent(),
    this.isOwner = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StaffCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String venueId,
    required String name,
    this.phone = const Value.absent(),
    this.pinHash = const Value.absent(),
    required String role,
    this.isOwner = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       venueId = Value(venueId),
       name = Value(name),
       role = Value(role);
  static Insertable<StaffRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? pinHash,
    Expression<String>? role,
    Expression<bool>? isOwner,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (pinHash != null) 'pin_hash': pinHash,
      if (role != null) 'role': role,
      if (isOwner != null) 'is_owner': isOwner,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StaffCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? pinHash,
    Value<String>? role,
    Value<bool>? isOwner,
    Value<int>? rowid,
  }) {
    return StaffCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pinHash: pinHash ?? this.pinHash,
      role: role ?? this.role,
      isOwner: isOwner ?? this.isOwner,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isOwner.present) {
      map['is_owner'] = Variable<bool>(isOwner.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('pinHash: $pinHash, ')
          ..write('role: $role, ')
          ..write('isOwner: $isOwner, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StaffPinAttemptsTable extends StaffPinAttempts
    with TableInfo<$StaffPinAttemptsTable, PinAttemptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffPinAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lockedUntilMeta = const VerificationMeta(
    'lockedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> lockedUntil = GeneratedColumn<DateTime>(
    'locked_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [staffId, wrongCount, lockedUntil];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff_pin_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PinAttemptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    } else if (isInserting) {
      context.missing(_wrongCountMeta);
    }
    if (data.containsKey('locked_until')) {
      context.handle(
        _lockedUntilMeta,
        lockedUntil.isAcceptableOrUnknown(
          data['locked_until']!,
          _lockedUntilMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {staffId};
  @override
  PinAttemptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PinAttemptRow(
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      lockedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}locked_until'],
      ),
    );
  }

  @override
  $StaffPinAttemptsTable createAlias(String alias) {
    return $StaffPinAttemptsTable(attachedDatabase, alias);
  }
}

class PinAttemptRow extends DataClass implements Insertable<PinAttemptRow> {
  final String staffId;
  final int wrongCount;
  final DateTime? lockedUntil;
  const PinAttemptRow({
    required this.staffId,
    required this.wrongCount,
    this.lockedUntil,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['staff_id'] = Variable<String>(staffId);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || lockedUntil != null) {
      map['locked_until'] = Variable<DateTime>(lockedUntil);
    }
    return map;
  }

  StaffPinAttemptsCompanion toCompanion(bool nullToAbsent) {
    return StaffPinAttemptsCompanion(
      staffId: Value(staffId),
      wrongCount: Value(wrongCount),
      lockedUntil: lockedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(lockedUntil),
    );
  }

  factory PinAttemptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PinAttemptRow(
      staffId: serializer.fromJson<String>(json['staffId']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      lockedUntil: serializer.fromJson<DateTime?>(json['lockedUntil']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'staffId': serializer.toJson<String>(staffId),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'lockedUntil': serializer.toJson<DateTime?>(lockedUntil),
    };
  }

  PinAttemptRow copyWith({
    String? staffId,
    int? wrongCount,
    Value<DateTime?> lockedUntil = const Value.absent(),
  }) => PinAttemptRow(
    staffId: staffId ?? this.staffId,
    wrongCount: wrongCount ?? this.wrongCount,
    lockedUntil: lockedUntil.present ? lockedUntil.value : this.lockedUntil,
  );
  PinAttemptRow copyWithCompanion(StaffPinAttemptsCompanion data) {
    return PinAttemptRow(
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      lockedUntil: data.lockedUntil.present
          ? data.lockedUntil.value
          : this.lockedUntil,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PinAttemptRow(')
          ..write('staffId: $staffId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lockedUntil: $lockedUntil')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(staffId, wrongCount, lockedUntil);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PinAttemptRow &&
          other.staffId == this.staffId &&
          other.wrongCount == this.wrongCount &&
          other.lockedUntil == this.lockedUntil);
}

class StaffPinAttemptsCompanion extends UpdateCompanion<PinAttemptRow> {
  final Value<String> staffId;
  final Value<int> wrongCount;
  final Value<DateTime?> lockedUntil;
  final Value<int> rowid;
  const StaffPinAttemptsCompanion({
    this.staffId = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lockedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StaffPinAttemptsCompanion.insert({
    required String staffId,
    required int wrongCount,
    this.lockedUntil = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : staffId = Value(staffId),
       wrongCount = Value(wrongCount);
  static Insertable<PinAttemptRow> custom({
    Expression<String>? staffId,
    Expression<int>? wrongCount,
    Expression<DateTime>? lockedUntil,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (staffId != null) 'staff_id': staffId,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (lockedUntil != null) 'locked_until': lockedUntil,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StaffPinAttemptsCompanion copyWith({
    Value<String>? staffId,
    Value<int>? wrongCount,
    Value<DateTime?>? lockedUntil,
    Value<int>? rowid,
  }) {
    return StaffPinAttemptsCompanion(
      staffId: staffId ?? this.staffId,
      wrongCount: wrongCount ?? this.wrongCount,
      lockedUntil: lockedUntil ?? this.lockedUntil,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (lockedUntil.present) {
      map['locked_until'] = Variable<DateTime>(lockedUntil.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffPinAttemptsCompanion(')
          ..write('staffId: $staffId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lockedUntil: $lockedUntil, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VenuesTable extends Venues with TableInfo<$VenuesTable, VenueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VenuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedByStaffIdMeta = const VerificationMeta(
    'updatedByStaffId',
  );
  @override
  late final GeneratedColumn<String> updatedByStaffId = GeneratedColumn<String>(
    'updated_by_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instapayLinkMeta = const VerificationMeta(
    'instapayLink',
  );
  @override
  late final GeneratedColumn<String> instapayLink = GeneratedColumn<String>(
    'instapay_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instapayHandleMeta = const VerificationMeta(
    'instapayHandle',
  );
  @override
  late final GeneratedColumn<String> instapayHandle = GeneratedColumn<String>(
    'instapay_handle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instapayPhoneMeta = const VerificationMeta(
    'instapayPhone',
  );
  @override
  late final GeneratedColumn<String> instapayPhone = GeneratedColumn<String>(
    'instapay_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _walletLinkMeta = const VerificationMeta(
    'walletLink',
  );
  @override
  late final GeneratedColumn<String> walletLink = GeneratedColumn<String>(
    'wallet_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _walletPhoneMeta = const VerificationMeta(
    'walletPhone',
  );
  @override
  late final GeneratedColumn<String> walletPhone = GeneratedColumn<String>(
    'wallet_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    name,
    phone,
    instapayLink,
    instapayHandle,
    instapayPhone,
    walletLink,
    walletPhone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'venues';
  @override
  VerificationContext validateIntegrity(
    Insertable<VenueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('updated_by_staff_id')) {
      context.handle(
        _updatedByStaffIdMeta,
        updatedByStaffId.isAcceptableOrUnknown(
          data['updated_by_staff_id']!,
          _updatedByStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('instapay_link')) {
      context.handle(
        _instapayLinkMeta,
        instapayLink.isAcceptableOrUnknown(
          data['instapay_link']!,
          _instapayLinkMeta,
        ),
      );
    }
    if (data.containsKey('instapay_handle')) {
      context.handle(
        _instapayHandleMeta,
        instapayHandle.isAcceptableOrUnknown(
          data['instapay_handle']!,
          _instapayHandleMeta,
        ),
      );
    }
    if (data.containsKey('instapay_phone')) {
      context.handle(
        _instapayPhoneMeta,
        instapayPhone.isAcceptableOrUnknown(
          data['instapay_phone']!,
          _instapayPhoneMeta,
        ),
      );
    }
    if (data.containsKey('wallet_link')) {
      context.handle(
        _walletLinkMeta,
        walletLink.isAcceptableOrUnknown(data['wallet_link']!, _walletLinkMeta),
      );
    }
    if (data.containsKey('wallet_phone')) {
      context.handle(
        _walletPhoneMeta,
        walletPhone.isAcceptableOrUnknown(
          data['wallet_phone']!,
          _walletPhoneMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VenueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VenueRow(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      updatedByStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by_staff_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      instapayLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instapay_link'],
      ),
      instapayHandle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instapay_handle'],
      ),
      instapayPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instapay_phone'],
      ),
      walletLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_link'],
      ),
      walletPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wallet_phone'],
      ),
    );
  }

  @override
  $VenuesTable createAlias(String alias) {
    return $VenuesTable(attachedDatabase, alias);
  }
}

class VenueRow extends DataClass implements Insertable<VenueRow> {
  /// Set on every create or edit. Sync sends rows newer than the last sync.
  final DateTime updatedAt;

  /// Who made the last change.
  final String? updatedByStaffId;

  /// Soft delete: set this instead of deleting the row, so the delete itself can sync.
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String phone;
  final String? instapayLink;
  final String? instapayHandle;
  final String? instapayPhone;
  final String? walletLink;
  final String? walletPhone;
  const VenueRow({
    required this.updatedAt,
    this.updatedByStaffId,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.phone,
    this.instapayLink,
    this.instapayHandle,
    this.instapayPhone,
    this.walletLink,
    this.walletPhone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || updatedByStaffId != null) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || instapayLink != null) {
      map['instapay_link'] = Variable<String>(instapayLink);
    }
    if (!nullToAbsent || instapayHandle != null) {
      map['instapay_handle'] = Variable<String>(instapayHandle);
    }
    if (!nullToAbsent || instapayPhone != null) {
      map['instapay_phone'] = Variable<String>(instapayPhone);
    }
    if (!nullToAbsent || walletLink != null) {
      map['wallet_link'] = Variable<String>(walletLink);
    }
    if (!nullToAbsent || walletPhone != null) {
      map['wallet_phone'] = Variable<String>(walletPhone);
    }
    return map;
  }

  VenuesCompanion toCompanion(bool nullToAbsent) {
    return VenuesCompanion(
      updatedAt: Value(updatedAt),
      updatedByStaffId: updatedByStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedByStaffId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      instapayLink: instapayLink == null && nullToAbsent
          ? const Value.absent()
          : Value(instapayLink),
      instapayHandle: instapayHandle == null && nullToAbsent
          ? const Value.absent()
          : Value(instapayHandle),
      instapayPhone: instapayPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(instapayPhone),
      walletLink: walletLink == null && nullToAbsent
          ? const Value.absent()
          : Value(walletLink),
      walletPhone: walletPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(walletPhone),
    );
  }

  factory VenueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VenueRow(
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      updatedByStaffId: serializer.fromJson<String?>(json['updatedByStaffId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      instapayLink: serializer.fromJson<String?>(json['instapayLink']),
      instapayHandle: serializer.fromJson<String?>(json['instapayHandle']),
      instapayPhone: serializer.fromJson<String?>(json['instapayPhone']),
      walletLink: serializer.fromJson<String?>(json['walletLink']),
      walletPhone: serializer.fromJson<String?>(json['walletPhone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'updatedByStaffId': serializer.toJson<String?>(updatedByStaffId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'instapayLink': serializer.toJson<String?>(instapayLink),
      'instapayHandle': serializer.toJson<String?>(instapayHandle),
      'instapayPhone': serializer.toJson<String?>(instapayPhone),
      'walletLink': serializer.toJson<String?>(walletLink),
      'walletPhone': serializer.toJson<String?>(walletPhone),
    };
  }

  VenueRow copyWith({
    DateTime? updatedAt,
    Value<String?> updatedByStaffId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? phone,
    Value<String?> instapayLink = const Value.absent(),
    Value<String?> instapayHandle = const Value.absent(),
    Value<String?> instapayPhone = const Value.absent(),
    Value<String?> walletLink = const Value.absent(),
    Value<String?> walletPhone = const Value.absent(),
  }) => VenueRow(
    updatedAt: updatedAt ?? this.updatedAt,
    updatedByStaffId: updatedByStaffId.present
        ? updatedByStaffId.value
        : this.updatedByStaffId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    instapayLink: instapayLink.present ? instapayLink.value : this.instapayLink,
    instapayHandle: instapayHandle.present
        ? instapayHandle.value
        : this.instapayHandle,
    instapayPhone: instapayPhone.present
        ? instapayPhone.value
        : this.instapayPhone,
    walletLink: walletLink.present ? walletLink.value : this.walletLink,
    walletPhone: walletPhone.present ? walletPhone.value : this.walletPhone,
  );
  VenueRow copyWithCompanion(VenuesCompanion data) {
    return VenueRow(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      updatedByStaffId: data.updatedByStaffId.present
          ? data.updatedByStaffId.value
          : this.updatedByStaffId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      instapayLink: data.instapayLink.present
          ? data.instapayLink.value
          : this.instapayLink,
      instapayHandle: data.instapayHandle.present
          ? data.instapayHandle.value
          : this.instapayHandle,
      instapayPhone: data.instapayPhone.present
          ? data.instapayPhone.value
          : this.instapayPhone,
      walletLink: data.walletLink.present
          ? data.walletLink.value
          : this.walletLink,
      walletPhone: data.walletPhone.present
          ? data.walletPhone.value
          : this.walletPhone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VenueRow(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('instapayLink: $instapayLink, ')
          ..write('instapayHandle: $instapayHandle, ')
          ..write('instapayPhone: $instapayPhone, ')
          ..write('walletLink: $walletLink, ')
          ..write('walletPhone: $walletPhone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    updatedByStaffId,
    deletedAt,
    id,
    name,
    phone,
    instapayLink,
    instapayHandle,
    instapayPhone,
    walletLink,
    walletPhone,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VenueRow &&
          other.updatedAt == this.updatedAt &&
          other.updatedByStaffId == this.updatedByStaffId &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.instapayLink == this.instapayLink &&
          other.instapayHandle == this.instapayHandle &&
          other.instapayPhone == this.instapayPhone &&
          other.walletLink == this.walletLink &&
          other.walletPhone == this.walletPhone);
}

class VenuesCompanion extends UpdateCompanion<VenueRow> {
  final Value<DateTime> updatedAt;
  final Value<String?> updatedByStaffId;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> instapayLink;
  final Value<String?> instapayHandle;
  final Value<String?> instapayPhone;
  final Value<String?> walletLink;
  final Value<String?> walletPhone;
  final Value<int> rowid;
  const VenuesCompanion({
    this.updatedAt = const Value.absent(),
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.instapayLink = const Value.absent(),
    this.instapayHandle = const Value.absent(),
    this.instapayPhone = const Value.absent(),
    this.walletLink = const Value.absent(),
    this.walletPhone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VenuesCompanion.insert({
    required DateTime updatedAt,
    this.updatedByStaffId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String phone,
    this.instapayLink = const Value.absent(),
    this.instapayHandle = const Value.absent(),
    this.instapayPhone = const Value.absent(),
    this.walletLink = const Value.absent(),
    this.walletPhone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       phone = Value(phone);
  static Insertable<VenueRow> custom({
    Expression<DateTime>? updatedAt,
    Expression<String>? updatedByStaffId,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? instapayLink,
    Expression<String>? instapayHandle,
    Expression<String>? instapayPhone,
    Expression<String>? walletLink,
    Expression<String>? walletPhone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (updatedByStaffId != null) 'updated_by_staff_id': updatedByStaffId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (instapayLink != null) 'instapay_link': instapayLink,
      if (instapayHandle != null) 'instapay_handle': instapayHandle,
      if (instapayPhone != null) 'instapay_phone': instapayPhone,
      if (walletLink != null) 'wallet_link': walletLink,
      if (walletPhone != null) 'wallet_phone': walletPhone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VenuesCompanion copyWith({
    Value<DateTime>? updatedAt,
    Value<String?>? updatedByStaffId,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? phone,
    Value<String?>? instapayLink,
    Value<String?>? instapayHandle,
    Value<String?>? instapayPhone,
    Value<String?>? walletLink,
    Value<String?>? walletPhone,
    Value<int>? rowid,
  }) {
    return VenuesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      updatedByStaffId: updatedByStaffId ?? this.updatedByStaffId,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      instapayLink: instapayLink ?? this.instapayLink,
      instapayHandle: instapayHandle ?? this.instapayHandle,
      instapayPhone: instapayPhone ?? this.instapayPhone,
      walletLink: walletLink ?? this.walletLink,
      walletPhone: walletPhone ?? this.walletPhone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (updatedByStaffId.present) {
      map['updated_by_staff_id'] = Variable<String>(updatedByStaffId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (instapayLink.present) {
      map['instapay_link'] = Variable<String>(instapayLink.value);
    }
    if (instapayHandle.present) {
      map['instapay_handle'] = Variable<String>(instapayHandle.value);
    }
    if (instapayPhone.present) {
      map['instapay_phone'] = Variable<String>(instapayPhone.value);
    }
    if (walletLink.present) {
      map['wallet_link'] = Variable<String>(walletLink.value);
    }
    if (walletPhone.present) {
      map['wallet_phone'] = Variable<String>(walletPhone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VenuesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('updatedByStaffId: $updatedByStaffId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('instapayLink: $instapayLink, ')
          ..write('instapayHandle: $instapayHandle, ')
          ..write('instapayPhone: $instapayPhone, ')
          ..write('walletLink: $walletLink, ')
          ..write('walletPhone: $walletPhone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityLogTable extends ActivityLog
    with TableInfo<$ActivityLogTable, ActivityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueIdMeta = const VerificationMeta(
    'venueId',
  );
  @override
  late final GeneratedColumn<String> venueId = GeneratedColumn<String>(
    'venue_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suspiciousMeta = const VerificationMeta(
    'suspicious',
  );
  @override
  late final GeneratedColumn<bool> suspicious = GeneratedColumn<bool>(
    'suspicious',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("suspicious" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    venueId,
    staffId,
    deviceId,
    occurredAt,
    kind,
    suspicious,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venue_id')) {
      context.handle(
        _venueIdMeta,
        venueId.isAcceptableOrUnknown(data['venue_id']!, _venueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_venueIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('suspicious')) {
      context.handle(
        _suspiciousMeta,
        suspicious.isAcceptableOrUnknown(data['suspicious']!, _suspiciousMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      venueId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      suspicious: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}suspicious'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
    );
  }

  @override
  $ActivityLogTable createAlias(String alias) {
    return $ActivityLogTable(attachedDatabase, alias);
  }
}

class ActivityRow extends DataClass implements Insertable<ActivityRow> {
  final String id;
  final String venueId;
  final String staffId;
  final String? deviceId;
  final DateTime occurredAt;
  final String kind;
  final bool suspicious;
  final String? details;
  const ActivityRow({
    required this.id,
    required this.venueId,
    required this.staffId,
    this.deviceId,
    required this.occurredAt,
    required this.kind,
    required this.suspicious,
    this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['venue_id'] = Variable<String>(venueId);
    map['staff_id'] = Variable<String>(staffId);
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['kind'] = Variable<String>(kind);
    map['suspicious'] = Variable<bool>(suspicious);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  ActivityLogCompanion toCompanion(bool nullToAbsent) {
    return ActivityLogCompanion(
      id: Value(id),
      venueId: Value(venueId),
      staffId: Value(staffId),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      occurredAt: Value(occurredAt),
      kind: Value(kind),
      suspicious: Value(suspicious),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory ActivityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityRow(
      id: serializer.fromJson<String>(json['id']),
      venueId: serializer.fromJson<String>(json['venueId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      kind: serializer.fromJson<String>(json['kind']),
      suspicious: serializer.fromJson<bool>(json['suspicious']),
      details: serializer.fromJson<String?>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'venueId': serializer.toJson<String>(venueId),
      'staffId': serializer.toJson<String>(staffId),
      'deviceId': serializer.toJson<String?>(deviceId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'kind': serializer.toJson<String>(kind),
      'suspicious': serializer.toJson<bool>(suspicious),
      'details': serializer.toJson<String?>(details),
    };
  }

  ActivityRow copyWith({
    String? id,
    String? venueId,
    String? staffId,
    Value<String?> deviceId = const Value.absent(),
    DateTime? occurredAt,
    String? kind,
    bool? suspicious,
    Value<String?> details = const Value.absent(),
  }) => ActivityRow(
    id: id ?? this.id,
    venueId: venueId ?? this.venueId,
    staffId: staffId ?? this.staffId,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    occurredAt: occurredAt ?? this.occurredAt,
    kind: kind ?? this.kind,
    suspicious: suspicious ?? this.suspicious,
    details: details.present ? details.value : this.details,
  );
  ActivityRow copyWithCompanion(ActivityLogCompanion data) {
    return ActivityRow(
      id: data.id.present ? data.id.value : this.id,
      venueId: data.venueId.present ? data.venueId.value : this.venueId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      suspicious: data.suspicious.present
          ? data.suspicious.value
          : this.suspicious,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityRow(')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('staffId: $staffId, ')
          ..write('deviceId: $deviceId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('kind: $kind, ')
          ..write('suspicious: $suspicious, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    venueId,
    staffId,
    deviceId,
    occurredAt,
    kind,
    suspicious,
    details,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityRow &&
          other.id == this.id &&
          other.venueId == this.venueId &&
          other.staffId == this.staffId &&
          other.deviceId == this.deviceId &&
          other.occurredAt == this.occurredAt &&
          other.kind == this.kind &&
          other.suspicious == this.suspicious &&
          other.details == this.details);
}

class ActivityLogCompanion extends UpdateCompanion<ActivityRow> {
  final Value<String> id;
  final Value<String> venueId;
  final Value<String> staffId;
  final Value<String?> deviceId;
  final Value<DateTime> occurredAt;
  final Value<String> kind;
  final Value<bool> suspicious;
  final Value<String?> details;
  final Value<int> rowid;
  const ActivityLogCompanion({
    this.id = const Value.absent(),
    this.venueId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.suspicious = const Value.absent(),
    this.details = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityLogCompanion.insert({
    required String id,
    required String venueId,
    required String staffId,
    this.deviceId = const Value.absent(),
    required DateTime occurredAt,
    required String kind,
    this.suspicious = const Value.absent(),
    this.details = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       venueId = Value(venueId),
       staffId = Value(staffId),
       occurredAt = Value(occurredAt),
       kind = Value(kind);
  static Insertable<ActivityRow> custom({
    Expression<String>? id,
    Expression<String>? venueId,
    Expression<String>? staffId,
    Expression<String>? deviceId,
    Expression<DateTime>? occurredAt,
    Expression<String>? kind,
    Expression<bool>? suspicious,
    Expression<String>? details,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (venueId != null) 'venue_id': venueId,
      if (staffId != null) 'staff_id': staffId,
      if (deviceId != null) 'device_id': deviceId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (kind != null) 'kind': kind,
      if (suspicious != null) 'suspicious': suspicious,
      if (details != null) 'details': details,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityLogCompanion copyWith({
    Value<String>? id,
    Value<String>? venueId,
    Value<String>? staffId,
    Value<String?>? deviceId,
    Value<DateTime>? occurredAt,
    Value<String>? kind,
    Value<bool>? suspicious,
    Value<String?>? details,
    Value<int>? rowid,
  }) {
    return ActivityLogCompanion(
      id: id ?? this.id,
      venueId: venueId ?? this.venueId,
      staffId: staffId ?? this.staffId,
      deviceId: deviceId ?? this.deviceId,
      occurredAt: occurredAt ?? this.occurredAt,
      kind: kind ?? this.kind,
      suspicious: suspicious ?? this.suspicious,
      details: details ?? this.details,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (venueId.present) {
      map['venue_id'] = Variable<String>(venueId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (suspicious.present) {
      map['suspicious'] = Variable<bool>(suspicious.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityLogCompanion(')
          ..write('id: $id, ')
          ..write('venueId: $venueId, ')
          ..write('staffId: $staffId, ')
          ..write('deviceId: $deviceId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('kind: $kind, ')
          ..write('suspicious: $suspicious, ')
          ..write('details: $details, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoomsTable rooms = $RoomsTable(this);
  late final $UnitTypesTable unitTypes = $UnitTypesTable(this);
  late final $PriceCategoriesTable priceCategories = $PriceCategoriesTable(
    this,
  );
  late final $UnitsTable units = $UnitsTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionsUnitsTable sessionsUnits = $SessionsUnitsTable(this);
  late final $SessionsProductsTable sessionsProducts = $SessionsProductsTable(
    this,
  );
  late final $ProductsTable products = $ProductsTable(this);
  late final $StockItemsTable stockItems = $StockItemsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $BillsTable bills = $BillsTable(this);
  late final $BillItemsTable billItems = $BillItemsTable(this);
  late final $ShiftsTable shifts = $ShiftsTable(this);
  late final $CashMovementsTable cashMovements = $CashMovementsTable(this);
  late final $ExpenseCategoriesTable expenseCategories =
      $ExpenseCategoriesTable(this);
  late final $StaffTable staff = $StaffTable(this);
  late final $StaffPinAttemptsTable staffPinAttempts = $StaffPinAttemptsTable(
    this,
  );
  late final $VenuesTable venues = $VenuesTable(this);
  late final $ActivityLogTable activityLog = $ActivityLogTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rooms,
    unitTypes,
    priceCategories,
    units,
    sessions,
    sessionsUnits,
    sessionsProducts,
    products,
    stockItems,
    stockMovements,
    purchases,
    bills,
    billItems,
    shifts,
    cashMovements,
    expenseCategories,
    staff,
    staffPinAttempts,
    venues,
    activityLog,
  ];
}

typedef $$RoomsTableCreateCompanionBuilder = RoomsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String name,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$RoomsTableUpdateCompanionBuilder = RoomsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> name,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$RoomsTableFilterComposer extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoomsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoomsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoomsTable> {
  $$RoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$RoomsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoomsTable,
          RoomRow,
          $$RoomsTableFilterComposer,
          $$RoomsTableOrderingComposer,
          $$RoomsTableAnnotationComposer,
          $$RoomsTableCreateCompanionBuilder,
          $$RoomsTableUpdateCompanionBuilder,
          (RoomRow, BaseReferences<_$AppDatabase, $RoomsTable, RoomRow>),
          RoomRow,
          PrefetchHooks Function()
        > {
  $$RoomsTableTableManager(_$AppDatabase db, $RoomsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoomsTable, RoomRow>(table),
                  BaseReferences<_$AppDatabase, $RoomsTable, RoomRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoomsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoomsTable,
      RoomRow,
      $$RoomsTableFilterComposer,
      $$RoomsTableOrderingComposer,
      $$RoomsTableAnnotationComposer,
      $$RoomsTableCreateCompanionBuilder,
      $$RoomsTableUpdateCompanionBuilder,
      (RoomRow, BaseReferences<_$AppDatabase, $RoomsTable, RoomRow>),
      RoomRow,
      PrefetchHooks Function()
    >;
typedef $$UnitTypesTableCreateCompanionBuilder = UnitTypesCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  Value<String?> venueId,
  required String name,
  Value<int> rowid,
});
typedef $$UnitTypesTableUpdateCompanionBuilder = UnitTypesCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String?> venueId,
  Value<String> name,
  Value<int> rowid,
});

class $$UnitTypesTableFilterComposer
    extends Composer<_$AppDatabase, $UnitTypesTable> {
  $$UnitTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnitTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitTypesTable> {
  $$UnitTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitTypesTable> {
  $$UnitTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$UnitTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitTypesTable,
          UnitTypeRow,
          $$UnitTypesTableFilterComposer,
          $$UnitTypesTableOrderingComposer,
          $$UnitTypesTableAnnotationComposer,
          $$UnitTypesTableCreateCompanionBuilder,
          $$UnitTypesTableUpdateCompanionBuilder,
          (
            UnitTypeRow,
            BaseReferences<_$AppDatabase, $UnitTypesTable, UnitTypeRow>,
          ),
          UnitTypeRow,
          PrefetchHooks Function()
        > {
  $$UnitTypesTableTableManager(_$AppDatabase db, $UnitTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String?> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitTypesCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                Value<String?> venueId = const Value.absent(),
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => UnitTypesCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UnitTypesTable, UnitTypeRow>(table),
                  BaseReferences<_$AppDatabase, $UnitTypesTable, UnitTypeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnitTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitTypesTable,
      UnitTypeRow,
      $$UnitTypesTableFilterComposer,
      $$UnitTypesTableOrderingComposer,
      $$UnitTypesTableAnnotationComposer,
      $$UnitTypesTableCreateCompanionBuilder,
      $$UnitTypesTableUpdateCompanionBuilder,
      (
        UnitTypeRow,
        BaseReferences<_$AppDatabase, $UnitTypesTable, UnitTypeRow>,
      ),
      UnitTypeRow,
      PrefetchHooks Function()
    >;
typedef $$PriceCategoriesTableCreateCompanionBuilder =
    PriceCategoriesCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      required String name,
      Value<String> pricingMode,
      required int hourlyPrice,
      Value<int?> multiHourlyPrice,
      Value<int> rowid,
    });
typedef $$PriceCategoriesTableUpdateCompanionBuilder =
    PriceCategoriesCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String> name,
      Value<String> pricingMode,
      Value<int> hourlyPrice,
      Value<int?> multiHourlyPrice,
      Value<int> rowid,
    });

class $$PriceCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $PriceCategoriesTable> {
  $$PriceCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricingMode => $composableBuilder(
    column: $table.pricingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get multiHourlyPrice => $composableBuilder(
    column: $table.multiHourlyPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PriceCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceCategoriesTable> {
  $$PriceCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricingMode => $composableBuilder(
    column: $table.pricingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get multiHourlyPrice => $composableBuilder(
    column: $table.multiHourlyPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PriceCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceCategoriesTable> {
  $$PriceCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get pricingMode => $composableBuilder(
    column: $table.pricingMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get multiHourlyPrice => $composableBuilder(
    column: $table.multiHourlyPrice,
    builder: (column) => column,
  );
}

class $$PriceCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceCategoriesTable,
          PriceCategoryRow,
          $$PriceCategoriesTableFilterComposer,
          $$PriceCategoriesTableOrderingComposer,
          $$PriceCategoriesTableAnnotationComposer,
          $$PriceCategoriesTableCreateCompanionBuilder,
          $$PriceCategoriesTableUpdateCompanionBuilder,
          (
            PriceCategoryRow,
            BaseReferences<
              _$AppDatabase,
              $PriceCategoriesTable,
              PriceCategoryRow
            >,
          ),
          PriceCategoryRow,
          PrefetchHooks Function()
        > {
  $$PriceCategoriesTableTableManager(
    _$AppDatabase db,
    $PriceCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> pricingMode = const Value.absent(),
                Value<int> hourlyPrice = const Value.absent(),
                Value<int?> multiHourlyPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceCategoriesCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                pricingMode: pricingMode,
                hourlyPrice: hourlyPrice,
                multiHourlyPrice: multiHourlyPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                Value<String> pricingMode = const Value.absent(),
                required int hourlyPrice,
                Value<int?> multiHourlyPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceCategoriesCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                pricingMode: pricingMode,
                hourlyPrice: hourlyPrice,
                multiHourlyPrice: multiHourlyPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PriceCategoriesTable, PriceCategoryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PriceCategoriesTable,
                    PriceCategoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PriceCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceCategoriesTable,
      PriceCategoryRow,
      $$PriceCategoriesTableFilterComposer,
      $$PriceCategoriesTableOrderingComposer,
      $$PriceCategoriesTableAnnotationComposer,
      $$PriceCategoriesTableCreateCompanionBuilder,
      $$PriceCategoriesTableUpdateCompanionBuilder,
      (
        PriceCategoryRow,
        BaseReferences<_$AppDatabase, $PriceCategoriesTable, PriceCategoryRow>,
      ),
      PriceCategoryRow,
      PrefetchHooks Function()
    >;
typedef $$UnitsTableCreateCompanionBuilder = UnitsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String roomId,
  required String unitTypeId,
  Value<String?> priceCategoryId,
  required String name,
  Value<int> sortOrder,
  Value<String> status,
  Value<String?> maintenanceNote,
  Value<int> rowid,
});
typedef $$UnitsTableUpdateCompanionBuilder = UnitsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> roomId,
  Value<String> unitTypeId,
  Value<String?> priceCategoryId,
  Value<String> name,
  Value<int> sortOrder,
  Value<String> status,
  Value<String?> maintenanceNote,
  Value<int> rowid,
});

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitTypeId => $composableBuilder(
    column: $table.unitTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priceCategoryId => $composableBuilder(
    column: $table.priceCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maintenanceNote => $composableBuilder(
    column: $table.maintenanceNote,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roomId => $composableBuilder(
    column: $table.roomId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitTypeId => $composableBuilder(
    column: $table.unitTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priceCategoryId => $composableBuilder(
    column: $table.priceCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maintenanceNote => $composableBuilder(
    column: $table.maintenanceNote,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get roomId =>
      $composableBuilder(column: $table.roomId, builder: (column) => column);

  GeneratedColumn<String> get unitTypeId => $composableBuilder(
    column: $table.unitTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priceCategoryId => $composableBuilder(
    column: $table.priceCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get maintenanceNote => $composableBuilder(
    column: $table.maintenanceNote,
    builder: (column) => column,
  );
}

class $$UnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitsTable,
          UnitRow,
          $$UnitsTableFilterComposer,
          $$UnitsTableOrderingComposer,
          $$UnitsTableAnnotationComposer,
          $$UnitsTableCreateCompanionBuilder,
          $$UnitsTableUpdateCompanionBuilder,
          (UnitRow, BaseReferences<_$AppDatabase, $UnitsTable, UnitRow>),
          UnitRow,
          PrefetchHooks Function()
        > {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> roomId = const Value.absent(),
                Value<String> unitTypeId = const Value.absent(),
                Value<String?> priceCategoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> maintenanceNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                roomId: roomId,
                unitTypeId: unitTypeId,
                priceCategoryId: priceCategoryId,
                name: name,
                sortOrder: sortOrder,
                status: status,
                maintenanceNote: maintenanceNote,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String roomId,
                required String unitTypeId,
                Value<String?> priceCategoryId = const Value.absent(),
                required String name,
                Value<int> sortOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> maintenanceNote = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                roomId: roomId,
                unitTypeId: unitTypeId,
                priceCategoryId: priceCategoryId,
                name: name,
                sortOrder: sortOrder,
                status: status,
                maintenanceNote: maintenanceNote,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UnitsTable, UnitRow>(table),
                  BaseReferences<_$AppDatabase, $UnitsTable, UnitRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitsTable,
      UnitRow,
      $$UnitsTableFilterComposer,
      $$UnitsTableOrderingComposer,
      $$UnitsTableAnnotationComposer,
      $$UnitsTableCreateCompanionBuilder,
      $$UnitsTableUpdateCompanionBuilder,
      (UnitRow, BaseReferences<_$AppDatabase, $UnitsTable, UnitRow>),
      UnitRow,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  Value<String?> reservationId,
  Value<String?> customerId,
  Value<String?> walkInCustomerId,
  required String staffId,
  Value<String> status,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String?> reservationId,
  Value<String?> customerId,
  Value<String?> walkInCustomerId,
  Value<String> staffId,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reservationId => $composableBuilder(
    column: $table.reservationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walkInCustomerId => $composableBuilder(
    column: $table.walkInCustomerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reservationId => $composableBuilder(
    column: $table.reservationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walkInCustomerId => $composableBuilder(
    column: $table.walkInCustomerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get reservationId => $composableBuilder(
    column: $table.reservationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walkInCustomerId => $composableBuilder(
    column: $table.walkInCustomerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          SessionRow,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (
            SessionRow,
            BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>,
          ),
          SessionRow,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String?> reservationId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<String?> walkInCustomerId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                reservationId: reservationId,
                customerId: customerId,
                walkInCustomerId: walkInCustomerId,
                staffId: staffId,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                Value<String?> reservationId = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<String?> walkInCustomerId = const Value.absent(),
                required String staffId,
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                reservationId: reservationId,
                customerId: customerId,
                walkInCustomerId: walkInCustomerId,
                staffId: staffId,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsTable, SessionRow>(table),
                  BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      SessionRow,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (SessionRow, BaseReferences<_$AppDatabase, $SessionsTable, SessionRow>),
      SessionRow,
      PrefetchHooks Function()
    >;
typedef $$SessionsUnitsTableCreateCompanionBuilder =
    SessionsUnitsCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      required String sessionId,
      required String unitId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required String mode,
      Value<int?> plannedMinutes,
      required int hourlyPrice,
      Value<int> rowid,
    });
typedef $$SessionsUnitsTableUpdateCompanionBuilder =
    SessionsUnitsCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String> sessionId,
      Value<String> unitId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<String> mode,
      Value<int?> plannedMinutes,
      Value<int> hourlyPrice,
      Value<int> rowid,
    });

class $$SessionsUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsUnitsTable> {
  $$SessionsUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsUnitsTable> {
  $$SessionsUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsUnitsTable> {
  $$SessionsUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hourlyPrice => $composableBuilder(
    column: $table.hourlyPrice,
    builder: (column) => column,
  );
}

class $$SessionsUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsUnitsTable,
          SessionUnitRow,
          $$SessionsUnitsTableFilterComposer,
          $$SessionsUnitsTableOrderingComposer,
          $$SessionsUnitsTableAnnotationComposer,
          $$SessionsUnitsTableCreateCompanionBuilder,
          $$SessionsUnitsTableUpdateCompanionBuilder,
          (
            SessionUnitRow,
            BaseReferences<_$AppDatabase, $SessionsUnitsTable, SessionUnitRow>,
          ),
          SessionUnitRow,
          PrefetchHooks Function()
        > {
  $$SessionsUnitsTableTableManager(_$AppDatabase db, $SessionsUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int?> plannedMinutes = const Value.absent(),
                Value<int> hourlyPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsUnitsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                unitId: unitId,
                startedAt: startedAt,
                endedAt: endedAt,
                mode: mode,
                plannedMinutes: plannedMinutes,
                hourlyPrice: hourlyPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String sessionId,
                required String unitId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required String mode,
                Value<int?> plannedMinutes = const Value.absent(),
                required int hourlyPrice,
                Value<int> rowid = const Value.absent(),
              }) => SessionsUnitsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                unitId: unitId,
                startedAt: startedAt,
                endedAt: endedAt,
                mode: mode,
                plannedMinutes: plannedMinutes,
                hourlyPrice: hourlyPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsUnitsTable, SessionUnitRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SessionsUnitsTable,
                    SessionUnitRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsUnitsTable,
      SessionUnitRow,
      $$SessionsUnitsTableFilterComposer,
      $$SessionsUnitsTableOrderingComposer,
      $$SessionsUnitsTableAnnotationComposer,
      $$SessionsUnitsTableCreateCompanionBuilder,
      $$SessionsUnitsTableUpdateCompanionBuilder,
      (
        SessionUnitRow,
        BaseReferences<_$AppDatabase, $SessionsUnitsTable, SessionUnitRow>,
      ),
      SessionUnitRow,
      PrefetchHooks Function()
    >;
typedef $$SessionsProductsTableCreateCompanionBuilder =
    SessionsProductsCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      required String sessionId,
      required String productId,
      Value<int> quantity,
      required int unitPrice,
      required DateTime orderedAt,
      Value<int> rowid,
    });
typedef $$SessionsProductsTableUpdateCompanionBuilder =
    SessionsProductsCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String> sessionId,
      Value<String> productId,
      Value<int> quantity,
      Value<int> unitPrice,
      Value<DateTime> orderedAt,
      Value<int> rowid,
    });

class $$SessionsProductsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsProductsTable> {
  $$SessionsProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsProductsTable> {
  $$SessionsProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get orderedAt => $composableBuilder(
    column: $table.orderedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsProductsTable> {
  $$SessionsProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<DateTime> get orderedAt =>
      $composableBuilder(column: $table.orderedAt, builder: (column) => column);
}

class $$SessionsProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsProductsTable,
          SessionProductRow,
          $$SessionsProductsTableFilterComposer,
          $$SessionsProductsTableOrderingComposer,
          $$SessionsProductsTableAnnotationComposer,
          $$SessionsProductsTableCreateCompanionBuilder,
          $$SessionsProductsTableUpdateCompanionBuilder,
          (
            SessionProductRow,
            BaseReferences<
              _$AppDatabase,
              $SessionsProductsTable,
              SessionProductRow
            >,
          ),
          SessionProductRow,
          PrefetchHooks Function()
        > {
  $$SessionsProductsTableTableManager(
    _$AppDatabase db,
    $SessionsProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> unitPrice = const Value.absent(),
                Value<DateTime> orderedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsProductsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                productId: productId,
                quantity: quantity,
                unitPrice: unitPrice,
                orderedAt: orderedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String sessionId,
                required String productId,
                Value<int> quantity = const Value.absent(),
                required int unitPrice,
                required DateTime orderedAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsProductsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                productId: productId,
                quantity: quantity,
                unitPrice: unitPrice,
                orderedAt: orderedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionsProductsTable, SessionProductRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SessionsProductsTable,
                    SessionProductRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsProductsTable,
      SessionProductRow,
      $$SessionsProductsTableFilterComposer,
      $$SessionsProductsTableOrderingComposer,
      $$SessionsProductsTableAnnotationComposer,
      $$SessionsProductsTableCreateCompanionBuilder,
      $$SessionsProductsTableUpdateCompanionBuilder,
      (
        SessionProductRow,
        BaseReferences<
          _$AppDatabase,
          $SessionsProductsTable,
          SessionProductRow
        >,
      ),
      SessionProductRow,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String name,
  required int price,
  Value<String?> stockItemId,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> name,
  Value<int> price,
  Value<String?> stockItemId,
  Value<int> rowid,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductRow,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (
            ProductRow,
            BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>,
          ),
          ProductRow,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<String?> stockItemId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                price: price,
                stockItemId: stockItemId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                required int price,
                Value<String?> stockItemId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                price: price,
                stockItemId: stockItemId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, ProductRow>(table),
                  BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductRow,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductRow, BaseReferences<_$AppDatabase, $ProductsTable, ProductRow>),
      ProductRow,
      PrefetchHooks Function()
    >;
typedef $$StockItemsTableCreateCompanionBuilder = StockItemsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String name,
  required bool deductsOnSale,
  Value<int> onHand,
  Value<int?> lowStockAt,
  Value<int> rowid,
});
typedef $$StockItemsTableUpdateCompanionBuilder = StockItemsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> name,
  Value<bool> deductsOnSale,
  Value<int> onHand,
  Value<int?> lowStockAt,
  Value<int> rowid,
});

class $$StockItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StockItemsTable> {
  $$StockItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deductsOnSale => $composableBuilder(
    column: $table.deductsOnSale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get onHand => $composableBuilder(
    column: $table.onHand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lowStockAt => $composableBuilder(
    column: $table.lowStockAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockItemsTable> {
  $$StockItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deductsOnSale => $composableBuilder(
    column: $table.deductsOnSale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get onHand => $composableBuilder(
    column: $table.onHand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lowStockAt => $composableBuilder(
    column: $table.lowStockAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockItemsTable> {
  $$StockItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get deductsOnSale => $composableBuilder(
    column: $table.deductsOnSale,
    builder: (column) => column,
  );

  GeneratedColumn<int> get onHand =>
      $composableBuilder(column: $table.onHand, builder: (column) => column);

  GeneratedColumn<int> get lowStockAt => $composableBuilder(
    column: $table.lowStockAt,
    builder: (column) => column,
  );
}

class $$StockItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockItemsTable,
          StockItemRow,
          $$StockItemsTableFilterComposer,
          $$StockItemsTableOrderingComposer,
          $$StockItemsTableAnnotationComposer,
          $$StockItemsTableCreateCompanionBuilder,
          $$StockItemsTableUpdateCompanionBuilder,
          (
            StockItemRow,
            BaseReferences<_$AppDatabase, $StockItemsTable, StockItemRow>,
          ),
          StockItemRow,
          PrefetchHooks Function()
        > {
  $$StockItemsTableTableManager(_$AppDatabase db, $StockItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> deductsOnSale = const Value.absent(),
                Value<int> onHand = const Value.absent(),
                Value<int?> lowStockAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockItemsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                deductsOnSale: deductsOnSale,
                onHand: onHand,
                lowStockAt: lowStockAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                required bool deductsOnSale,
                Value<int> onHand = const Value.absent(),
                Value<int?> lowStockAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockItemsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                deductsOnSale: deductsOnSale,
                onHand: onHand,
                lowStockAt: lowStockAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockItemsTable, StockItemRow>(table),
                  BaseReferences<_$AppDatabase, $StockItemsTable, StockItemRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockItemsTable,
      StockItemRow,
      $$StockItemsTableFilterComposer,
      $$StockItemsTableOrderingComposer,
      $$StockItemsTableAnnotationComposer,
      $$StockItemsTableCreateCompanionBuilder,
      $$StockItemsTableUpdateCompanionBuilder,
      (
        StockItemRow,
        BaseReferences<_$AppDatabase, $StockItemsTable, StockItemRow>,
      ),
      StockItemRow,
      PrefetchHooks Function()
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      required String stockItemId,
      required String kind,
      required int quantity,
      Value<String?> purchaseId,
      Value<int?> expectedQuantity,
      required String staffId,
      Value<int?> cost,
      Value<String?> note,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String> stockItemId,
      Value<String> kind,
      Value<int> quantity,
      Value<String?> purchaseId,
      Value<int?> expectedQuantity,
      Value<String> staffId,
      Value<int?> cost,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get stockItemId => $composableBuilder(
    column: $table.stockItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedQuantity => $composableBuilder(
    column: $table.expectedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<int> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovementRow,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (
            StockMovementRow,
            BaseReferences<
              _$AppDatabase,
              $StockMovementsTable,
              StockMovementRow
            >,
          ),
          StockMovementRow,
          PrefetchHooks Function()
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> stockItemId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                Value<int?> expectedQuantity = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<int?> cost = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                stockItemId: stockItemId,
                kind: kind,
                quantity: quantity,
                purchaseId: purchaseId,
                expectedQuantity: expectedQuantity,
                staffId: staffId,
                cost: cost,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String stockItemId,
                required String kind,
                required int quantity,
                Value<String?> purchaseId = const Value.absent(),
                Value<int?> expectedQuantity = const Value.absent(),
                required String staffId,
                Value<int?> cost = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                stockItemId: stockItemId,
                kind: kind,
                quantity: quantity,
                purchaseId: purchaseId,
                expectedQuantity: expectedQuantity,
                staffId: staffId,
                cost: cost,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockMovementsTable, StockMovementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StockMovementsTable,
                    StockMovementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovementRow,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (
        StockMovementRow,
        BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovementRow>,
      ),
      StockMovementRow,
      PrefetchHooks Function()
    >;
typedef $$PurchasesTableCreateCompanionBuilder = PurchasesCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String staffId,
  required int total,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PurchasesTableUpdateCompanionBuilder = PurchasesCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> staffId,
  Value<int> total,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          PurchaseRow,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (
            PurchaseRow,
            BaseReferences<_$AppDatabase, $PurchasesTable, PurchaseRow>,
          ),
          PurchaseRow,
          PrefetchHooks Function()
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                staffId: staffId,
                total: total,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String staffId,
                required int total,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PurchasesCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                staffId: staffId,
                total: total,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PurchasesTable, PurchaseRow>(table),
                  BaseReferences<_$AppDatabase, $PurchasesTable, PurchaseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      PurchaseRow,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (
        PurchaseRow,
        BaseReferences<_$AppDatabase, $PurchasesTable, PurchaseRow>,
      ),
      PurchaseRow,
      PrefetchHooks Function()
    >;
typedef $$BillsTableCreateCompanionBuilder = BillsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  Value<String?> sessionId,
  required String staffId,
  required String shiftId,
  required int subtotal,
  required int discount,
  required int total,
  Value<String?> discountNote,
  required String paymentMethod,
  required DateTime paidAt,
  Value<int> rowid,
});
typedef $$BillsTableUpdateCompanionBuilder = BillsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String?> sessionId,
  Value<String> staffId,
  Value<String> shiftId,
  Value<int> subtotal,
  Value<int> discount,
  Value<int> total,
  Value<String?> discountNote,
  Value<String> paymentMethod,
  Value<DateTime> paidAt,
  Value<int> rowid,
});

class $$BillsTableFilterComposer extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discountNote => $composableBuilder(
    column: $table.discountNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discountNote => $composableBuilder(
    column: $table.discountNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTable> {
  $$BillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get discountNote => $composableBuilder(
    column: $table.discountNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);
}

class $$BillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsTable,
          BillRow,
          $$BillsTableFilterComposer,
          $$BillsTableOrderingComposer,
          $$BillsTableAnnotationComposer,
          $$BillsTableCreateCompanionBuilder,
          $$BillsTableUpdateCompanionBuilder,
          (BillRow, BaseReferences<_$AppDatabase, $BillsTable, BillRow>),
          BillRow,
          PrefetchHooks Function()
        > {
  $$BillsTableTableManager(_$AppDatabase db, $BillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> shiftId = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> discount = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String?> discountNote = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                staffId: staffId,
                shiftId: shiftId,
                subtotal: subtotal,
                discount: discount,
                total: total,
                discountNote: discountNote,
                paymentMethod: paymentMethod,
                paidAt: paidAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                Value<String?> sessionId = const Value.absent(),
                required String staffId,
                required String shiftId,
                required int subtotal,
                required int discount,
                required int total,
                Value<String?> discountNote = const Value.absent(),
                required String paymentMethod,
                required DateTime paidAt,
                Value<int> rowid = const Value.absent(),
              }) => BillsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                sessionId: sessionId,
                staffId: staffId,
                shiftId: shiftId,
                subtotal: subtotal,
                discount: discount,
                total: total,
                discountNote: discountNote,
                paymentMethod: paymentMethod,
                paidAt: paidAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillsTable, BillRow>(table),
                  BaseReferences<_$AppDatabase, $BillsTable, BillRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsTable,
      BillRow,
      $$BillsTableFilterComposer,
      $$BillsTableOrderingComposer,
      $$BillsTableAnnotationComposer,
      $$BillsTableCreateCompanionBuilder,
      $$BillsTableUpdateCompanionBuilder,
      (BillRow, BaseReferences<_$AppDatabase, $BillsTable, BillRow>),
      BillRow,
      PrefetchHooks Function()
    >;
typedef $$BillItemsTableCreateCompanionBuilder = BillItemsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String billId,
  Value<String?> productId,
  required String description,
  Value<int> quantity,
  required int unitPrice,
  required int total,
  Value<int> rowid,
});
typedef $$BillItemsTableUpdateCompanionBuilder = BillItemsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> billId,
  Value<String?> productId,
  Value<String> description,
  Value<int> quantity,
  Value<int> unitPrice,
  Value<int> total,
  Value<int> rowid,
});

class $$BillItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BillItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billId => $composableBuilder(
    column: $table.billId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BillItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillItemsTable> {
  $$BillItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get billId =>
      $composableBuilder(column: $table.billId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);
}

class $$BillItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillItemsTable,
          BillItemRow,
          $$BillItemsTableFilterComposer,
          $$BillItemsTableOrderingComposer,
          $$BillItemsTableAnnotationComposer,
          $$BillItemsTableCreateCompanionBuilder,
          $$BillItemsTableUpdateCompanionBuilder,
          (
            BillItemRow,
            BaseReferences<_$AppDatabase, $BillItemsTable, BillItemRow>,
          ),
          BillItemRow,
          PrefetchHooks Function()
        > {
  $$BillItemsTableTableManager(_$AppDatabase db, $BillItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> billId = const Value.absent(),
                Value<String?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> unitPrice = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillItemsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                billId: billId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String billId,
                Value<String?> productId = const Value.absent(),
                required String description,
                Value<int> quantity = const Value.absent(),
                required int unitPrice,
                required int total,
                Value<int> rowid = const Value.absent(),
              }) => BillItemsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                billId: billId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillItemsTable, BillItemRow>(table),
                  BaseReferences<_$AppDatabase, $BillItemsTable, BillItemRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BillItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillItemsTable,
      BillItemRow,
      $$BillItemsTableFilterComposer,
      $$BillItemsTableOrderingComposer,
      $$BillItemsTableAnnotationComposer,
      $$BillItemsTableCreateCompanionBuilder,
      $$BillItemsTableUpdateCompanionBuilder,
      (
        BillItemRow,
        BaseReferences<_$AppDatabase, $BillItemsTable, BillItemRow>,
      ),
      BillItemRow,
      PrefetchHooks Function()
    >;
typedef $$ShiftsTableCreateCompanionBuilder = ShiftsCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String openedByStaffId,
  required DateTime openedAt,
  required int openingCash,
  Value<String?> closedByStaffId,
  Value<DateTime?> closedAt,
  Value<int?> expectedCash,
  Value<int?> countedCash,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$ShiftsTableUpdateCompanionBuilder = ShiftsCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> openedByStaffId,
  Value<DateTime> openedAt,
  Value<int> openingCash,
  Value<String?> closedByStaffId,
  Value<DateTime?> closedAt,
  Value<int?> expectedCash,
  Value<int?> countedCash,
  Value<String?> note,
  Value<int> rowid,
});

class $$ShiftsTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openedByStaffId => $composableBuilder(
    column: $table.openedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closedByStaffId => $composableBuilder(
    column: $table.closedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openedByStaffId => $composableBuilder(
    column: $table.openedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closedByStaffId => $composableBuilder(
    column: $table.closedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
    column: $table.closedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get openedByStaffId => $composableBuilder(
    column: $table.openedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<int> get openingCash => $composableBuilder(
    column: $table.openingCash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get closedByStaffId => $composableBuilder(
    column: $table.closedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<int> get expectedCash => $composableBuilder(
    column: $table.expectedCash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get countedCash => $composableBuilder(
    column: $table.countedCash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$ShiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftsTable,
          ShiftRow,
          $$ShiftsTableFilterComposer,
          $$ShiftsTableOrderingComposer,
          $$ShiftsTableAnnotationComposer,
          $$ShiftsTableCreateCompanionBuilder,
          $$ShiftsTableUpdateCompanionBuilder,
          (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
          ShiftRow,
          PrefetchHooks Function()
        > {
  $$ShiftsTableTableManager(_$AppDatabase db, $ShiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> openedByStaffId = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<int> openingCash = const Value.absent(),
                Value<String?> closedByStaffId = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int?> expectedCash = const Value.absent(),
                Value<int?> countedCash = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                openedByStaffId: openedByStaffId,
                openedAt: openedAt,
                openingCash: openingCash,
                closedByStaffId: closedByStaffId,
                closedAt: closedAt,
                expectedCash: expectedCash,
                countedCash: countedCash,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String openedByStaffId,
                required DateTime openedAt,
                required int openingCash,
                Value<String?> closedByStaffId = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<int?> expectedCash = const Value.absent(),
                Value<int?> countedCash = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                openedByStaffId: openedByStaffId,
                openedAt: openedAt,
                openingCash: openingCash,
                closedByStaffId: closedByStaffId,
                closedAt: closedAt,
                expectedCash: expectedCash,
                countedCash: countedCash,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftsTable, ShiftRow>(table),
                  BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftsTable,
      ShiftRow,
      $$ShiftsTableFilterComposer,
      $$ShiftsTableOrderingComposer,
      $$ShiftsTableAnnotationComposer,
      $$ShiftsTableCreateCompanionBuilder,
      $$ShiftsTableUpdateCompanionBuilder,
      (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
      ShiftRow,
      PrefetchHooks Function()
    >;
typedef $$CashMovementsTableCreateCompanionBuilder =
    CashMovementsCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      Value<String?> shiftId,
      required String staffId,
      required String type,
      required int amount,
      Value<String?> note,
      Value<String> paidFrom,
      Value<bool> owed,
      Value<DateTime?> reimbursedAt,
      Value<String?> purchaseId,
      Value<String?> categoryId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CashMovementsTableUpdateCompanionBuilder =
    CashMovementsCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String?> shiftId,
      Value<String> staffId,
      Value<String> type,
      Value<int> amount,
      Value<String?> note,
      Value<String> paidFrom,
      Value<bool> owed,
      Value<DateTime?> reimbursedAt,
      Value<String?> purchaseId,
      Value<String?> categoryId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CashMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidFrom => $composableBuilder(
    column: $table.paidFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get owed => $composableBuilder(
    column: $table.owed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reimbursedAt => $composableBuilder(
    column: $table.reimbursedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CashMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shiftId => $composableBuilder(
    column: $table.shiftId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidFrom => $composableBuilder(
    column: $table.paidFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get owed => $composableBuilder(
    column: $table.owed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reimbursedAt => $composableBuilder(
    column: $table.reimbursedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get paidFrom =>
      $composableBuilder(column: $table.paidFrom, builder: (column) => column);

  GeneratedColumn<bool> get owed =>
      $composableBuilder(column: $table.owed, builder: (column) => column);

  GeneratedColumn<DateTime> get reimbursedAt => $composableBuilder(
    column: $table.reimbursedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchaseId => $composableBuilder(
    column: $table.purchaseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CashMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashMovementsTable,
          CashMovementRow,
          $$CashMovementsTableFilterComposer,
          $$CashMovementsTableOrderingComposer,
          $$CashMovementsTableAnnotationComposer,
          $$CashMovementsTableCreateCompanionBuilder,
          $$CashMovementsTableUpdateCompanionBuilder,
          (
            CashMovementRow,
            BaseReferences<_$AppDatabase, $CashMovementsTable, CashMovementRow>,
          ),
          CashMovementRow,
          PrefetchHooks Function()
        > {
  $$CashMovementsTableTableManager(_$AppDatabase db, $CashMovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String?> shiftId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> paidFrom = const Value.absent(),
                Value<bool> owed = const Value.absent(),
                Value<DateTime?> reimbursedAt = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashMovementsCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                shiftId: shiftId,
                staffId: staffId,
                type: type,
                amount: amount,
                note: note,
                paidFrom: paidFrom,
                owed: owed,
                reimbursedAt: reimbursedAt,
                purchaseId: purchaseId,
                categoryId: categoryId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                Value<String?> shiftId = const Value.absent(),
                required String staffId,
                required String type,
                required int amount,
                Value<String?> note = const Value.absent(),
                Value<String> paidFrom = const Value.absent(),
                Value<bool> owed = const Value.absent(),
                Value<DateTime?> reimbursedAt = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CashMovementsCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                shiftId: shiftId,
                staffId: staffId,
                type: type,
                amount: amount,
                note: note,
                paidFrom: paidFrom,
                owed: owed,
                reimbursedAt: reimbursedAt,
                purchaseId: purchaseId,
                categoryId: categoryId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CashMovementsTable, CashMovementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CashMovementsTable,
                    CashMovementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CashMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashMovementsTable,
      CashMovementRow,
      $$CashMovementsTableFilterComposer,
      $$CashMovementsTableOrderingComposer,
      $$CashMovementsTableAnnotationComposer,
      $$CashMovementsTableCreateCompanionBuilder,
      $$CashMovementsTableUpdateCompanionBuilder,
      (
        CashMovementRow,
        BaseReferences<_$AppDatabase, $CashMovementsTable, CashMovementRow>,
      ),
      CashMovementRow,
      PrefetchHooks Function()
    >;
typedef $$ExpenseCategoriesTableCreateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      required DateTime updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      required String id,
      required String venueId,
      required String name,
      required String kind,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ExpenseCategoriesTableUpdateCompanionBuilder =
    ExpenseCategoriesCompanion Function({
      Value<DateTime> updatedAt,
      Value<String?> updatedByStaffId,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> venueId,
      Value<String> name,
      Value<String> kind,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$ExpenseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpenseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpenseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseCategoriesTable> {
  $$ExpenseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$ExpenseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseCategoriesTable,
          ExpenseCategoryRow,
          $$ExpenseCategoriesTableFilterComposer,
          $$ExpenseCategoriesTableOrderingComposer,
          $$ExpenseCategoriesTableAnnotationComposer,
          $$ExpenseCategoriesTableCreateCompanionBuilder,
          $$ExpenseCategoriesTableUpdateCompanionBuilder,
          (
            ExpenseCategoryRow,
            BaseReferences<
              _$AppDatabase,
              $ExpenseCategoriesTable,
              ExpenseCategoryRow
            >,
          ),
          ExpenseCategoryRow,
          PrefetchHooks Function()
        > {
  $$ExpenseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExpenseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                kind: kind,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                required String kind,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpenseCategoriesCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                kind: kind,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExpenseCategoriesTable, ExpenseCategoryRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ExpenseCategoriesTable,
                    ExpenseCategoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpenseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseCategoriesTable,
      ExpenseCategoryRow,
      $$ExpenseCategoriesTableFilterComposer,
      $$ExpenseCategoriesTableOrderingComposer,
      $$ExpenseCategoriesTableAnnotationComposer,
      $$ExpenseCategoriesTableCreateCompanionBuilder,
      $$ExpenseCategoriesTableUpdateCompanionBuilder,
      (
        ExpenseCategoryRow,
        BaseReferences<
          _$AppDatabase,
          $ExpenseCategoriesTable,
          ExpenseCategoryRow
        >,
      ),
      ExpenseCategoryRow,
      PrefetchHooks Function()
    >;
typedef $$StaffTableCreateCompanionBuilder = StaffCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String venueId,
  required String name,
  Value<String?> phone,
  Value<String?> pinHash,
  required String role,
  Value<bool> isOwner,
  Value<int> rowid,
});
typedef $$StaffTableUpdateCompanionBuilder = StaffCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> venueId,
  Value<String> name,
  Value<String?> phone,
  Value<String?> pinHash,
  Value<String> role,
  Value<bool> isOwner,
  Value<int> rowid,
});

class $$StaffTableFilterComposer extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOwner => $composableBuilder(
    column: $table.isOwner,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOwner => $composableBuilder(
    column: $table.isOwner,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffTable> {
  $$StaffTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isOwner =>
      $composableBuilder(column: $table.isOwner, builder: (column) => column);
}

class $$StaffTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffTable,
          StaffRow,
          $$StaffTableFilterComposer,
          $$StaffTableOrderingComposer,
          $$StaffTableAnnotationComposer,
          $$StaffTableCreateCompanionBuilder,
          $$StaffTableUpdateCompanionBuilder,
          (StaffRow, BaseReferences<_$AppDatabase, $StaffTable, StaffRow>),
          StaffRow,
          PrefetchHooks Function()
        > {
  $$StaffTableTableManager(_$AppDatabase db, $StaffTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isOwner = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                phone: phone,
                pinHash: pinHash,
                role: role,
                isOwner: isOwner,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String venueId,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                required String role,
                Value<bool> isOwner = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                venueId: venueId,
                name: name,
                phone: phone,
                pinHash: pinHash,
                role: role,
                isOwner: isOwner,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StaffTable, StaffRow>(table),
                  BaseReferences<_$AppDatabase, $StaffTable, StaffRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffTable,
      StaffRow,
      $$StaffTableFilterComposer,
      $$StaffTableOrderingComposer,
      $$StaffTableAnnotationComposer,
      $$StaffTableCreateCompanionBuilder,
      $$StaffTableUpdateCompanionBuilder,
      (StaffRow, BaseReferences<_$AppDatabase, $StaffTable, StaffRow>),
      StaffRow,
      PrefetchHooks Function()
    >;
typedef $$StaffPinAttemptsTableCreateCompanionBuilder =
    StaffPinAttemptsCompanion Function({
      required String staffId,
      required int wrongCount,
      Value<DateTime?> lockedUntil,
      Value<int> rowid,
    });
typedef $$StaffPinAttemptsTableUpdateCompanionBuilder =
    StaffPinAttemptsCompanion Function({
      Value<String> staffId,
      Value<int> wrongCount,
      Value<DateTime?> lockedUntil,
      Value<int> rowid,
    });

class $$StaffPinAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $StaffPinAttemptsTable> {
  $$StaffPinAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffPinAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffPinAttemptsTable> {
  $$StaffPinAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffPinAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffPinAttemptsTable> {
  $$StaffPinAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lockedUntil => $composableBuilder(
    column: $table.lockedUntil,
    builder: (column) => column,
  );
}

class $$StaffPinAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffPinAttemptsTable,
          PinAttemptRow,
          $$StaffPinAttemptsTableFilterComposer,
          $$StaffPinAttemptsTableOrderingComposer,
          $$StaffPinAttemptsTableAnnotationComposer,
          $$StaffPinAttemptsTableCreateCompanionBuilder,
          $$StaffPinAttemptsTableUpdateCompanionBuilder,
          (
            PinAttemptRow,
            BaseReferences<
              _$AppDatabase,
              $StaffPinAttemptsTable,
              PinAttemptRow
            >,
          ),
          PinAttemptRow,
          PrefetchHooks Function()
        > {
  $$StaffPinAttemptsTableTableManager(
    _$AppDatabase db,
    $StaffPinAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffPinAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffPinAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffPinAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> staffId = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime?> lockedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffPinAttemptsCompanion(
                staffId: staffId,
                wrongCount: wrongCount,
                lockedUntil: lockedUntil,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String staffId,
                required int wrongCount,
                Value<DateTime?> lockedUntil = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffPinAttemptsCompanion.insert(
                staffId: staffId,
                wrongCount: wrongCount,
                lockedUntil: lockedUntil,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StaffPinAttemptsTable, PinAttemptRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StaffPinAttemptsTable,
                    PinAttemptRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffPinAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffPinAttemptsTable,
      PinAttemptRow,
      $$StaffPinAttemptsTableFilterComposer,
      $$StaffPinAttemptsTableOrderingComposer,
      $$StaffPinAttemptsTableAnnotationComposer,
      $$StaffPinAttemptsTableCreateCompanionBuilder,
      $$StaffPinAttemptsTableUpdateCompanionBuilder,
      (
        PinAttemptRow,
        BaseReferences<_$AppDatabase, $StaffPinAttemptsTable, PinAttemptRow>,
      ),
      PinAttemptRow,
      PrefetchHooks Function()
    >;
typedef $$VenuesTableCreateCompanionBuilder = VenuesCompanion Function({
  required DateTime updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  required String id,
  required String name,
  required String phone,
  Value<String?> instapayLink,
  Value<String?> instapayHandle,
  Value<String?> instapayPhone,
  Value<String?> walletLink,
  Value<String?> walletPhone,
  Value<int> rowid,
});
typedef $$VenuesTableUpdateCompanionBuilder = VenuesCompanion Function({
  Value<DateTime> updatedAt,
  Value<String?> updatedByStaffId,
  Value<DateTime?> deletedAt,
  Value<String> id,
  Value<String> name,
  Value<String> phone,
  Value<String?> instapayLink,
  Value<String?> instapayHandle,
  Value<String?> instapayPhone,
  Value<String?> walletLink,
  Value<String?> walletPhone,
  Value<int> rowid,
});

class $$VenuesTableFilterComposer
    extends Composer<_$AppDatabase, $VenuesTable> {
  $$VenuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instapayLink => $composableBuilder(
    column: $table.instapayLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instapayHandle => $composableBuilder(
    column: $table.instapayHandle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instapayPhone => $composableBuilder(
    column: $table.instapayPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletLink => $composableBuilder(
    column: $table.walletLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walletPhone => $composableBuilder(
    column: $table.walletPhone,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VenuesTableOrderingComposer
    extends Composer<_$AppDatabase, $VenuesTable> {
  $$VenuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instapayLink => $composableBuilder(
    column: $table.instapayLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instapayHandle => $composableBuilder(
    column: $table.instapayHandle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instapayPhone => $composableBuilder(
    column: $table.instapayPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletLink => $composableBuilder(
    column: $table.walletLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walletPhone => $composableBuilder(
    column: $table.walletPhone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VenuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VenuesTable> {
  $$VenuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get updatedByStaffId => $composableBuilder(
    column: $table.updatedByStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get instapayLink => $composableBuilder(
    column: $table.instapayLink,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instapayHandle => $composableBuilder(
    column: $table.instapayHandle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instapayPhone => $composableBuilder(
    column: $table.instapayPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walletLink => $composableBuilder(
    column: $table.walletLink,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walletPhone => $composableBuilder(
    column: $table.walletPhone,
    builder: (column) => column,
  );
}

class $$VenuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VenuesTable,
          VenueRow,
          $$VenuesTableFilterComposer,
          $$VenuesTableOrderingComposer,
          $$VenuesTableAnnotationComposer,
          $$VenuesTableCreateCompanionBuilder,
          $$VenuesTableUpdateCompanionBuilder,
          (VenueRow, BaseReferences<_$AppDatabase, $VenuesTable, VenueRow>),
          VenueRow,
          PrefetchHooks Function()
        > {
  $$VenuesTableTableManager(_$AppDatabase db, $VenuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VenuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VenuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VenuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> instapayLink = const Value.absent(),
                Value<String?> instapayHandle = const Value.absent(),
                Value<String?> instapayPhone = const Value.absent(),
                Value<String?> walletLink = const Value.absent(),
                Value<String?> walletPhone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VenuesCompanion(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                name: name,
                phone: phone,
                instapayLink: instapayLink,
                instapayHandle: instapayHandle,
                instapayPhone: instapayPhone,
                walletLink: walletLink,
                walletPhone: walletPhone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime updatedAt,
                Value<String?> updatedByStaffId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String phone,
                Value<String?> instapayLink = const Value.absent(),
                Value<String?> instapayHandle = const Value.absent(),
                Value<String?> instapayPhone = const Value.absent(),
                Value<String?> walletLink = const Value.absent(),
                Value<String?> walletPhone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VenuesCompanion.insert(
                updatedAt: updatedAt,
                updatedByStaffId: updatedByStaffId,
                deletedAt: deletedAt,
                id: id,
                name: name,
                phone: phone,
                instapayLink: instapayLink,
                instapayHandle: instapayHandle,
                instapayPhone: instapayPhone,
                walletLink: walletLink,
                walletPhone: walletPhone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VenuesTable, VenueRow>(table),
                  BaseReferences<_$AppDatabase, $VenuesTable, VenueRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VenuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VenuesTable,
      VenueRow,
      $$VenuesTableFilterComposer,
      $$VenuesTableOrderingComposer,
      $$VenuesTableAnnotationComposer,
      $$VenuesTableCreateCompanionBuilder,
      $$VenuesTableUpdateCompanionBuilder,
      (VenueRow, BaseReferences<_$AppDatabase, $VenuesTable, VenueRow>),
      VenueRow,
      PrefetchHooks Function()
    >;
typedef $$ActivityLogTableCreateCompanionBuilder =
    ActivityLogCompanion Function({
      required String id,
      required String venueId,
      required String staffId,
      Value<String?> deviceId,
      required DateTime occurredAt,
      required String kind,
      Value<bool> suspicious,
      Value<String?> details,
      Value<int> rowid,
    });
typedef $$ActivityLogTableUpdateCompanionBuilder =
    ActivityLogCompanion Function({
      Value<String> id,
      Value<String> venueId,
      Value<String> staffId,
      Value<String?> deviceId,
      Value<DateTime> occurredAt,
      Value<String> kind,
      Value<bool> suspicious,
      Value<String?> details,
      Value<int> rowid,
    });

class $$ActivityLogTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityLogTable> {
  $$ActivityLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get suspicious => $composableBuilder(
    column: $table.suspicious,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityLogTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityLogTable> {
  $$ActivityLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venueId => $composableBuilder(
    column: $table.venueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get suspicious => $composableBuilder(
    column: $table.suspicious,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityLogTable> {
  $$ActivityLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get venueId =>
      $composableBuilder(column: $table.venueId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get suspicious => $composableBuilder(
    column: $table.suspicious,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$ActivityLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityLogTable,
          ActivityRow,
          $$ActivityLogTableFilterComposer,
          $$ActivityLogTableOrderingComposer,
          $$ActivityLogTableAnnotationComposer,
          $$ActivityLogTableCreateCompanionBuilder,
          $$ActivityLogTableUpdateCompanionBuilder,
          (
            ActivityRow,
            BaseReferences<_$AppDatabase, $ActivityLogTable, ActivityRow>,
          ),
          ActivityRow,
          PrefetchHooks Function()
        > {
  $$ActivityLogTableTableManager(_$AppDatabase db, $ActivityLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> venueId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<bool> suspicious = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityLogCompanion(
                id: id,
                venueId: venueId,
                staffId: staffId,
                deviceId: deviceId,
                occurredAt: occurredAt,
                kind: kind,
                suspicious: suspicious,
                details: details,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String venueId,
                required String staffId,
                Value<String?> deviceId = const Value.absent(),
                required DateTime occurredAt,
                required String kind,
                Value<bool> suspicious = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityLogCompanion.insert(
                id: id,
                venueId: venueId,
                staffId: staffId,
                deviceId: deviceId,
                occurredAt: occurredAt,
                kind: kind,
                suspicious: suspicious,
                details: details,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivityLogTable, ActivityRow>(table),
                  BaseReferences<_$AppDatabase, $ActivityLogTable, ActivityRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityLogTable,
      ActivityRow,
      $$ActivityLogTableFilterComposer,
      $$ActivityLogTableOrderingComposer,
      $$ActivityLogTableAnnotationComposer,
      $$ActivityLogTableCreateCompanionBuilder,
      $$ActivityLogTableUpdateCompanionBuilder,
      (
        ActivityRow,
        BaseReferences<_$AppDatabase, $ActivityLogTable, ActivityRow>,
      ),
      ActivityRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoomsTableTableManager get rooms =>
      $$RoomsTableTableManager(_db, _db.rooms);
  $$UnitTypesTableTableManager get unitTypes =>
      $$UnitTypesTableTableManager(_db, _db.unitTypes);
  $$PriceCategoriesTableTableManager get priceCategories =>
      $$PriceCategoriesTableTableManager(_db, _db.priceCategories);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SessionsUnitsTableTableManager get sessionsUnits =>
      $$SessionsUnitsTableTableManager(_db, _db.sessionsUnits);
  $$SessionsProductsTableTableManager get sessionsProducts =>
      $$SessionsProductsTableTableManager(_db, _db.sessionsProducts);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StockItemsTableTableManager get stockItems =>
      $$StockItemsTableTableManager(_db, _db.stockItems);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db, _db.bills);
  $$BillItemsTableTableManager get billItems =>
      $$BillItemsTableTableManager(_db, _db.billItems);
  $$ShiftsTableTableManager get shifts =>
      $$ShiftsTableTableManager(_db, _db.shifts);
  $$CashMovementsTableTableManager get cashMovements =>
      $$CashMovementsTableTableManager(_db, _db.cashMovements);
  $$ExpenseCategoriesTableTableManager get expenseCategories =>
      $$ExpenseCategoriesTableTableManager(_db, _db.expenseCategories);
  $$StaffTableTableManager get staff =>
      $$StaffTableTableManager(_db, _db.staff);
  $$StaffPinAttemptsTableTableManager get staffPinAttempts =>
      $$StaffPinAttemptsTableTableManager(_db, _db.staffPinAttempts);
  $$VenuesTableTableManager get venues =>
      $$VenuesTableTableManager(_db, _db.venues);
  $$ActivityLogTableTableManager get activityLog =>
      $$ActivityLogTableTableManager(_db, _db.activityLog);
}
