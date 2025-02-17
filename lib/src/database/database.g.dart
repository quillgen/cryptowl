// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Categories extends Table with TableInfo<Categories, CategoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _accessLevelMeta =
      const VerificationMeta('accessLevel');
  late final GeneratedColumn<int> accessLevel = GeneratedColumn<int>(
      'access_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  late final GeneratedColumn<String> createTime = GeneratedColumn<String>(
      'create_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lastUpdateTimeMeta =
      const VerificationMeta('lastUpdateTime');
  late final GeneratedColumn<String> lastUpdateTime = GeneratedColumn<String>(
      'last_update_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, accessLevel, createTime, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('access_level')) {
      context.handle(
          _accessLevelMeta,
          accessLevel.isAcceptableOrUnknown(
              data['access_level']!, _accessLevelMeta));
    } else if (isInserting) {
      context.missing(_accessLevelMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
          _lastUpdateTimeMeta,
          lastUpdateTime.isAcceptableOrUnknown(
              data['last_update_time']!, _lastUpdateTimeMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      accessLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}access_level'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CategoryEntity extends DataClass implements Insertable<CategoryEntity> {
  final int id;
  final String name;
  final int accessLevel;
  final String createTime;
  final String lastUpdateTime;
  const CategoryEntity(
      {required this.id,
      required this.name,
      required this.accessLevel,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['access_level'] = Variable<int>(accessLevel);
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      accessLevel: Value(accessLevel),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      accessLevel: serializer.fromJson<int>(json['access_level']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'access_level': serializer.toJson<int>(accessLevel),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  CategoryEntity copyWith(
          {int? id,
          String? name,
          int? accessLevel,
          String? createTime,
          String? lastUpdateTime}) =>
      CategoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        accessLevel: accessLevel ?? this.accessLevel,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  CategoryEntity copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      accessLevel:
          data.accessLevel.present ? data.accessLevel.value : this.accessLevel,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accessLevel: $accessLevel, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, accessLevel, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.accessLevel == this.accessLevel &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> accessLevel;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.accessLevel = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int accessLevel,
    required String createTime,
    required String lastUpdateTime,
  })  : name = Value(name),
        accessLevel = Value(accessLevel),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<CategoryEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? accessLevel,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (accessLevel != null) 'access_level': accessLevel,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? accessLevel,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      accessLevel: accessLevel ?? this.accessLevel,
      createTime: createTime ?? this.createTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (accessLevel.present) {
      map['access_level'] = Variable<int>(accessLevel.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('accessLevel: $accessLevel, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class Passwords extends Table with TableInfo<Passwords, PasswordEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Passwords(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 1',
      defaultValue: const CustomExpression('1'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _expireTimeMeta =
      const VerificationMeta('expireTime');
  late final GeneratedColumn<String> expireTime = GeneratedColumn<String>(
      'expire_time', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 1',
      defaultValue: const CustomExpression('1'));
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  late final GeneratedColumn<String> createTime = GeneratedColumn<String>(
      'create_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lastUpdateTimeMeta =
      const VerificationMeta('lastUpdateTime');
  late final GeneratedColumn<String> lastUpdateTime = GeneratedColumn<String>(
      'last_update_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  late final GeneratedColumn<int> isDeleted = GeneratedColumn<int>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        title,
        value,
        expireTime,
        remark,
        categoryId,
        createTime,
        lastUpdateTime,
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'passwords';
  @override
  VerificationContext validateIntegrity(Insertable<PasswordEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('expire_time')) {
      context.handle(
          _expireTimeMeta,
          expireTime.isAcceptableOrUnknown(
              data['expire_time']!, _expireTimeMeta));
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
          _lastUpdateTimeMeta,
          lastUpdateTime.isAcceptableOrUnknown(
              data['last_update_time']!, _lastUpdateTimeMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PasswordEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PasswordEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      expireTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expire_time']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_deleted'])!,
    );
  }

  @override
  Passwords createAlias(String alias) {
    return Passwords(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(category_id)REFERENCES categories(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class PasswordEntity extends DataClass implements Insertable<PasswordEntity> {
  final String id;
  final int type;
  final String title;
  final String value;
  final String? expireTime;
  final String? remark;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  final int isDeleted;
  const PasswordEntity(
      {required this.id,
      required this.type,
      required this.title,
      required this.value,
      this.expireTime,
      this.remark,
      required this.categoryId,
      required this.createTime,
      required this.lastUpdateTime,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<int>(type);
    map['title'] = Variable<String>(title);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || expireTime != null) {
      map['expire_time'] = Variable<String>(expireTime);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    map['category_id'] = Variable<int>(categoryId);
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    map['is_deleted'] = Variable<int>(isDeleted);
    return map;
  }

  PasswordsCompanion toCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      value: Value(value),
      expireTime: expireTime == null && nullToAbsent
          ? const Value.absent()
          : Value(expireTime),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      categoryId: Value(categoryId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
      isDeleted: Value(isDeleted),
    );
  }

  factory PasswordEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PasswordEntity(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      value: serializer.fromJson<String>(json['value']),
      expireTime: serializer.fromJson<String?>(json['expire_time']),
      remark: serializer.fromJson<String?>(json['remark']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
      isDeleted: serializer.fromJson<int>(json['is_deleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<int>(type),
      'title': serializer.toJson<String>(title),
      'value': serializer.toJson<String>(value),
      'expire_time': serializer.toJson<String?>(expireTime),
      'remark': serializer.toJson<String?>(remark),
      'category_id': serializer.toJson<int>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
      'is_deleted': serializer.toJson<int>(isDeleted),
    };
  }

  PasswordEntity copyWith(
          {String? id,
          int? type,
          String? title,
          String? value,
          Value<String?> expireTime = const Value.absent(),
          Value<String?> remark = const Value.absent(),
          int? categoryId,
          String? createTime,
          String? lastUpdateTime,
          int? isDeleted}) =>
      PasswordEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        title: title ?? this.title,
        value: value ?? this.value,
        expireTime: expireTime.present ? expireTime.value : this.expireTime,
        remark: remark.present ? remark.value : this.remark,
        categoryId: categoryId ?? this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  PasswordEntity copyWithCompanion(PasswordsCompanion data) {
    return PasswordEntity(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      value: data.value.present ? data.value.value : this.value,
      expireTime:
          data.expireTime.present ? data.expireTime.value : this.expireTime,
      remark: data.remark.present ? data.remark.value : this.remark,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PasswordEntity(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('expireTime: $expireTime, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, title, value, expireTime, remark,
      categoryId, createTime, lastUpdateTime, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordEntity &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.value == this.value &&
          other.expireTime == this.expireTime &&
          other.remark == this.remark &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.isDeleted == this.isDeleted);
}

class PasswordsCompanion extends UpdateCompanion<PasswordEntity> {
  final Value<String> id;
  final Value<int> type;
  final Value<String> title;
  final Value<String> value;
  final Value<String?> expireTime;
  final Value<String?> remark;
  final Value<int> categoryId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  final Value<int> isDeleted;
  final Value<int> rowid;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.value = const Value.absent(),
    this.expireTime = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PasswordsCompanion.insert({
    required String id,
    this.type = const Value.absent(),
    required String title,
    required String value,
    this.expireTime = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        value = Value(value),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<PasswordEntity> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<String>? title,
    Expression<String>? value,
    Expression<String>? expireTime,
    Expression<String>? remark,
    Expression<int>? categoryId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
    Expression<int>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (expireTime != null) 'expire_time': expireTime,
      if (remark != null) 'remark': remark,
      if (categoryId != null) 'category_id': categoryId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PasswordsCompanion copyWith(
      {Value<String>? id,
      Value<int>? type,
      Value<String>? title,
      Value<String>? value,
      Value<String?>? expireTime,
      Value<String?>? remark,
      Value<int>? categoryId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime,
      Value<int>? isDeleted,
      Value<int>? rowid}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      value: value ?? this.value,
      expireTime: expireTime ?? this.expireTime,
      remark: remark ?? this.remark,
      categoryId: categoryId ?? this.categoryId,
      createTime: createTime ?? this.createTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (expireTime.present) {
      map['expire_time'] = Variable<String>(expireTime.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<int>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasswordsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('expireTime: $expireTime, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Attributes extends Table with TableInfo<Attributes, Attribute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Attributes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _resourceIdMeta =
      const VerificationMeta('resourceId');
  late final GeneratedColumn<String> resourceId = GeneratedColumn<String>(
      'resource_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dateTypeMeta =
      const VerificationMeta('dateType');
  late final GeneratedColumn<int> dateType = GeneratedColumn<int>(
      'date_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 1',
      defaultValue: const CustomExpression('1'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  late final GeneratedColumn<String> createTime = GeneratedColumn<String>(
      'create_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lastUpdateTimeMeta =
      const VerificationMeta('lastUpdateTime');
  late final GeneratedColumn<String> lastUpdateTime = GeneratedColumn<String>(
      'last_update_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, resourceId, dateType, name, value, createTime, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attributes';
  @override
  VerificationContext validateIntegrity(Insertable<Attribute> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('resource_id')) {
      context.handle(
          _resourceIdMeta,
          resourceId.isAcceptableOrUnknown(
              data['resource_id']!, _resourceIdMeta));
    } else if (isInserting) {
      context.missing(_resourceIdMeta);
    }
    if (data.containsKey('date_type')) {
      context.handle(_dateTypeMeta,
          dateType.isAcceptableOrUnknown(data['date_type']!, _dateTypeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
          _lastUpdateTimeMeta,
          lastUpdateTime.isAcceptableOrUnknown(
              data['last_update_time']!, _lastUpdateTimeMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attribute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attribute(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      resourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resource_id'])!,
      dateType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  Attributes createAlias(String alias) {
    return Attributes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Attribute extends DataClass implements Insertable<Attribute> {
  final int id;
  final String resourceId;
  final int dateType;
  final String name;
  final String? value;
  final String createTime;
  final String lastUpdateTime;
  const Attribute(
      {required this.id,
      required this.resourceId,
      required this.dateType,
      required this.name,
      this.value,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['resource_id'] = Variable<String>(resourceId);
    map['date_type'] = Variable<int>(dateType);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  AttributesCompanion toCompanion(bool nullToAbsent) {
    return AttributesCompanion(
      id: Value(id),
      resourceId: Value(resourceId),
      dateType: Value(dateType),
      name: Value(name),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory Attribute.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attribute(
      id: serializer.fromJson<int>(json['id']),
      resourceId: serializer.fromJson<String>(json['resource_id']),
      dateType: serializer.fromJson<int>(json['date_type']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String?>(json['value']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'resource_id': serializer.toJson<String>(resourceId),
      'date_type': serializer.toJson<int>(dateType),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String?>(value),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  Attribute copyWith(
          {int? id,
          String? resourceId,
          int? dateType,
          String? name,
          Value<String?> value = const Value.absent(),
          String? createTime,
          String? lastUpdateTime}) =>
      Attribute(
        id: id ?? this.id,
        resourceId: resourceId ?? this.resourceId,
        dateType: dateType ?? this.dateType,
        name: name ?? this.name,
        value: value.present ? value.value : this.value,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  Attribute copyWithCompanion(AttributesCompanion data) {
    return Attribute(
      id: data.id.present ? data.id.value : this.id,
      resourceId:
          data.resourceId.present ? data.resourceId.value : this.resourceId,
      dateType: data.dateType.present ? data.dateType.value : this.dateType,
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attribute(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('dateType: $dateType, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, resourceId, dateType, name, value, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attribute &&
          other.id == this.id &&
          other.resourceId == this.resourceId &&
          other.dateType == this.dateType &&
          other.name == this.name &&
          other.value == this.value &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class AttributesCompanion extends UpdateCompanion<Attribute> {
  final Value<int> id;
  final Value<String> resourceId;
  final Value<int> dateType;
  final Value<String> name;
  final Value<String?> value;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const AttributesCompanion({
    this.id = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.dateType = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  AttributesCompanion.insert({
    this.id = const Value.absent(),
    required String resourceId,
    this.dateType = const Value.absent(),
    required String name,
    this.value = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
  })  : resourceId = Value(resourceId),
        name = Value(name),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<Attribute> custom({
    Expression<int>? id,
    Expression<String>? resourceId,
    Expression<int>? dateType,
    Expression<String>? name,
    Expression<String>? value,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (resourceId != null) 'resource_id': resourceId,
      if (dateType != null) 'date_type': dateType,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  AttributesCompanion copyWith(
      {Value<int>? id,
      Value<String>? resourceId,
      Value<int>? dateType,
      Value<String>? name,
      Value<String?>? value,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return AttributesCompanion(
      id: id ?? this.id,
      resourceId: resourceId ?? this.resourceId,
      dateType: dateType ?? this.dateType,
      name: name ?? this.name,
      value: value ?? this.value,
      createTime: createTime ?? this.createTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<String>(resourceId.value);
    }
    if (dateType.present) {
      map['date_type'] = Variable<int>(dateType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttributesCompanion(')
          ..write('id: $id, ')
          ..write('resourceId: $resourceId, ')
          ..write('dateType: $dateType, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final Categories categories = Categories(this);
  late final Passwords passwords = Passwords(this);
  late final Attributes attributes = Attributes(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, passwords, attributes];
}

typedef $CategoriesCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String name,
  required int accessLevel,
  required String createTime,
  required String lastUpdateTime,
});
typedef $CategoriesUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> accessLevel,
  Value<String> createTime,
  Value<String> lastUpdateTime,
});

class $CategoriesFilterComposer extends Composer<_$AppDb, Categories> {
  $CategoriesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accessLevel => $composableBuilder(
      column: $table.accessLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnFilters(column));
}

class $CategoriesOrderingComposer extends Composer<_$AppDb, Categories> {
  $CategoriesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accessLevel => $composableBuilder(
      column: $table.accessLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnOrderings(column));
}

class $CategoriesAnnotationComposer extends Composer<_$AppDb, Categories> {
  $CategoriesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get accessLevel => $composableBuilder(
      column: $table.accessLevel, builder: (column) => column);

  GeneratedColumn<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime, builder: (column) => column);
}

class $CategoriesTableManager extends RootTableManager<
    _$AppDb,
    Categories,
    CategoryEntity,
    $CategoriesFilterComposer,
    $CategoriesOrderingComposer,
    $CategoriesAnnotationComposer,
    $CategoriesCreateCompanionBuilder,
    $CategoriesUpdateCompanionBuilder,
    (CategoryEntity, BaseReferences<_$AppDb, Categories, CategoryEntity>),
    CategoryEntity,
    PrefetchHooks Function()> {
  $CategoriesTableManager(_$AppDb db, Categories table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CategoriesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CategoriesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CategoriesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> accessLevel = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<String> lastUpdateTime = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            accessLevel: accessLevel,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int accessLevel,
            required String createTime,
            required String lastUpdateTime,
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            accessLevel: accessLevel,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $CategoriesProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    Categories,
    CategoryEntity,
    $CategoriesFilterComposer,
    $CategoriesOrderingComposer,
    $CategoriesAnnotationComposer,
    $CategoriesCreateCompanionBuilder,
    $CategoriesUpdateCompanionBuilder,
    (CategoryEntity, BaseReferences<_$AppDb, Categories, CategoryEntity>),
    CategoryEntity,
    PrefetchHooks Function()>;
typedef $PasswordsCreateCompanionBuilder = PasswordsCompanion Function({
  required String id,
  Value<int> type,
  required String title,
  required String value,
  Value<String?> expireTime,
  Value<String?> remark,
  Value<int> categoryId,
  required String createTime,
  required String lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});
typedef $PasswordsUpdateCompanionBuilder = PasswordsCompanion Function({
  Value<String> id,
  Value<int> type,
  Value<String> title,
  Value<String> value,
  Value<String?> expireTime,
  Value<String?> remark,
  Value<int> categoryId,
  Value<String> createTime,
  Value<String> lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});

class $PasswordsFilterComposer extends Composer<_$AppDb, Passwords> {
  $PasswordsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));
}

class $PasswordsOrderingComposer extends Composer<_$AppDb, Passwords> {
  $PasswordsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));
}

class $PasswordsAnnotationComposer extends Composer<_$AppDb, Passwords> {
  $PasswordsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime, builder: (column) => column);

  GeneratedColumn<int> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $PasswordsTableManager extends RootTableManager<
    _$AppDb,
    Passwords,
    PasswordEntity,
    $PasswordsFilterComposer,
    $PasswordsOrderingComposer,
    $PasswordsAnnotationComposer,
    $PasswordsCreateCompanionBuilder,
    $PasswordsUpdateCompanionBuilder,
    (PasswordEntity, BaseReferences<_$AppDb, Passwords, PasswordEntity>),
    PasswordEntity,
    PrefetchHooks Function()> {
  $PasswordsTableManager(_$AppDb db, Passwords table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $PasswordsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $PasswordsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $PasswordsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String?> expireTime = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<String> lastUpdateTime = const Value.absent(),
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PasswordsCompanion(
            id: id,
            type: type,
            title: title,
            value: value,
            expireTime: expireTime,
            remark: remark,
            categoryId: categoryId,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<int> type = const Value.absent(),
            required String title,
            required String value,
            Value<String?> expireTime = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            required String createTime,
            required String lastUpdateTime,
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PasswordsCompanion.insert(
            id: id,
            type: type,
            title: title,
            value: value,
            expireTime: expireTime,
            remark: remark,
            categoryId: categoryId,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $PasswordsProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    Passwords,
    PasswordEntity,
    $PasswordsFilterComposer,
    $PasswordsOrderingComposer,
    $PasswordsAnnotationComposer,
    $PasswordsCreateCompanionBuilder,
    $PasswordsUpdateCompanionBuilder,
    (PasswordEntity, BaseReferences<_$AppDb, Passwords, PasswordEntity>),
    PasswordEntity,
    PrefetchHooks Function()>;
typedef $AttributesCreateCompanionBuilder = AttributesCompanion Function({
  Value<int> id,
  required String resourceId,
  Value<int> dateType,
  required String name,
  Value<String?> value,
  required String createTime,
  required String lastUpdateTime,
});
typedef $AttributesUpdateCompanionBuilder = AttributesCompanion Function({
  Value<int> id,
  Value<String> resourceId,
  Value<int> dateType,
  Value<String> name,
  Value<String?> value,
  Value<String> createTime,
  Value<String> lastUpdateTime,
});

class $AttributesFilterComposer extends Composer<_$AppDb, Attributes> {
  $AttributesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dateType => $composableBuilder(
      column: $table.dateType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnFilters(column));
}

class $AttributesOrderingComposer extends Composer<_$AppDb, Attributes> {
  $AttributesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dateType => $composableBuilder(
      column: $table.dateType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime,
      builder: (column) => ColumnOrderings(column));
}

class $AttributesAnnotationComposer extends Composer<_$AppDb, Attributes> {
  $AttributesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get resourceId => $composableBuilder(
      column: $table.resourceId, builder: (column) => column);

  GeneratedColumn<int> get dateType =>
      $composableBuilder(column: $table.dateType, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime, builder: (column) => column);
}

class $AttributesTableManager extends RootTableManager<
    _$AppDb,
    Attributes,
    Attribute,
    $AttributesFilterComposer,
    $AttributesOrderingComposer,
    $AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (Attribute, BaseReferences<_$AppDb, Attributes, Attribute>),
    Attribute,
    PrefetchHooks Function()> {
  $AttributesTableManager(_$AppDb db, Attributes table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AttributesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AttributesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AttributesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> resourceId = const Value.absent(),
            Value<int> dateType = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> value = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<String> lastUpdateTime = const Value.absent(),
          }) =>
              AttributesCompanion(
            id: id,
            resourceId: resourceId,
            dateType: dateType,
            name: name,
            value: value,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String resourceId,
            Value<int> dateType = const Value.absent(),
            required String name,
            Value<String?> value = const Value.absent(),
            required String createTime,
            required String lastUpdateTime,
          }) =>
              AttributesCompanion.insert(
            id: id,
            resourceId: resourceId,
            dateType: dateType,
            name: name,
            value: value,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $AttributesProcessedTableManager = ProcessedTableManager<
    _$AppDb,
    Attributes,
    Attribute,
    $AttributesFilterComposer,
    $AttributesOrderingComposer,
    $AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (Attribute, BaseReferences<_$AppDb, Attributes, Attribute>),
    Attribute,
    PrefetchHooks Function()>;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $CategoriesTableManager get categories =>
      $CategoriesTableManager(_db, _db.categories);
  $PasswordsTableManager get passwords =>
      $PasswordsTableManager(_db, _db.passwords);
  $AttributesTableManager get attributes =>
      $AttributesTableManager(_db, _db.attributes);
}
