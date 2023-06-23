// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sqlite_database.dart';

// ignore_for_file: type=lint
class $AppShortcutsTable extends AppShortcuts
    with TableInfo<$AppShortcutsTable, AppShortcut> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppShortcutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconPathMeta =
      const VerificationMeta('iconPath');
  @override
  late final GeneratedColumn<String> iconPath = GeneratedColumn<String>(
      'icon_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortcutNameMeta =
      const VerificationMeta('shortcutName');
  @override
  late final GeneratedColumn<String> shortcutName = GeneratedColumn<String>(
      'shortcut_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, iconPath, shortcutName, order];
  @override
  String get aliasedName => _alias ?? 'app_shortcuts';
  @override
  String get actualTableName => 'app_shortcuts';
  @override
  VerificationContext validateIntegrity(Insertable<AppShortcut> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('icon_path')) {
      context.handle(_iconPathMeta,
          iconPath.isAcceptableOrUnknown(data['icon_path']!, _iconPathMeta));
    } else if (isInserting) {
      context.missing(_iconPathMeta);
    }
    if (data.containsKey('shortcut_name')) {
      context.handle(
          _shortcutNameMeta,
          shortcutName.isAcceptableOrUnknown(
              data['shortcut_name']!, _shortcutNameMeta));
    } else if (isInserting) {
      context.missing(_shortcutNameMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppShortcut map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppShortcut(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      iconPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_path'])!,
      shortcutName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shortcut_name'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order']),
    );
  }

  @override
  $AppShortcutsTable createAlias(String alias) {
    return $AppShortcutsTable(attachedDatabase, alias);
  }
}

class AppShortcut extends DataClass implements Insertable<AppShortcut> {
  final int id;
  final String path;
  final String iconPath;
  final String shortcutName;
  final int? order;
  const AppShortcut(
      {required this.id,
      required this.path,
      required this.iconPath,
      required this.shortcutName,
      this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['path'] = Variable<String>(path);
    map['icon_path'] = Variable<String>(iconPath);
    map['shortcut_name'] = Variable<String>(shortcutName);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  AppShortcutsCompanion toCompanion(bool nullToAbsent) {
    return AppShortcutsCompanion(
      id: Value(id),
      path: Value(path),
      iconPath: Value(iconPath),
      shortcutName: Value(shortcutName),
      order:
          order == null && nullToAbsent ? const Value.absent() : Value(order),
    );
  }

  factory AppShortcut.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppShortcut(
      id: serializer.fromJson<int>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      iconPath: serializer.fromJson<String>(json['iconPath']),
      shortcutName: serializer.fromJson<String>(json['shortcutName']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'path': serializer.toJson<String>(path),
      'iconPath': serializer.toJson<String>(iconPath),
      'shortcutName': serializer.toJson<String>(shortcutName),
      'order': serializer.toJson<int?>(order),
    };
  }

  AppShortcut copyWith(
          {int? id,
          String? path,
          String? iconPath,
          String? shortcutName,
          Value<int?> order = const Value.absent()}) =>
      AppShortcut(
        id: id ?? this.id,
        path: path ?? this.path,
        iconPath: iconPath ?? this.iconPath,
        shortcutName: shortcutName ?? this.shortcutName,
        order: order.present ? order.value : this.order,
      );
  @override
  String toString() {
    return (StringBuffer('AppShortcut(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('iconPath: $iconPath, ')
          ..write('shortcutName: $shortcutName, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, path, iconPath, shortcutName, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppShortcut &&
          other.id == this.id &&
          other.path == this.path &&
          other.iconPath == this.iconPath &&
          other.shortcutName == this.shortcutName &&
          other.order == this.order);
}

class AppShortcutsCompanion extends UpdateCompanion<AppShortcut> {
  final Value<int> id;
  final Value<String> path;
  final Value<String> iconPath;
  final Value<String> shortcutName;
  final Value<int?> order;
  const AppShortcutsCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.iconPath = const Value.absent(),
    this.shortcutName = const Value.absent(),
    this.order = const Value.absent(),
  });
  AppShortcutsCompanion.insert({
    this.id = const Value.absent(),
    required String path,
    required String iconPath,
    required String shortcutName,
    this.order = const Value.absent(),
  })  : path = Value(path),
        iconPath = Value(iconPath),
        shortcutName = Value(shortcutName);
  static Insertable<AppShortcut> custom({
    Expression<int>? id,
    Expression<String>? path,
    Expression<String>? iconPath,
    Expression<String>? shortcutName,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (iconPath != null) 'icon_path': iconPath,
      if (shortcutName != null) 'shortcut_name': shortcutName,
      if (order != null) 'order': order,
    });
  }

  AppShortcutsCompanion copyWith(
      {Value<int>? id,
      Value<String>? path,
      Value<String>? iconPath,
      Value<String>? shortcutName,
      Value<int?>? order}) {
    return AppShortcutsCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      iconPath: iconPath ?? this.iconPath,
      shortcutName: shortcutName ?? this.shortcutName,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (iconPath.present) {
      map['icon_path'] = Variable<String>(iconPath.value);
    }
    if (shortcutName.present) {
      map['shortcut_name'] = Variable<String>(shortcutName.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppShortcutsCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('iconPath: $iconPath, ')
          ..write('shortcutName: $shortcutName, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(e);
  late final $AppShortcutsTable appShortcuts = $AppShortcutsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appShortcuts];
}
