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
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  late final GeneratedColumn<int> classification = GeneratedColumn<int>(
      'classification', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
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
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
      'uri', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
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
        classification,
        title,
        value,
        expireTime,
        username,
        uri,
        remark,
        isFavorite,
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
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
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
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('uri')) {
      context.handle(
          _uriMeta, uri.isAcceptableOrUnknown(data['uri']!, _uriMeta));
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
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
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classification'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      expireTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expire_time']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      uri: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uri']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_favorite'])!,
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
  final int classification;
  final String title;
  final String value;
  final String? expireTime;
  final String? username;
  final String? uri;
  final String? remark;
  final int isFavorite;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  final int isDeleted;
  const PasswordEntity(
      {required this.id,
      required this.type,
      required this.classification,
      required this.title,
      required this.value,
      this.expireTime,
      this.username,
      this.uri,
      this.remark,
      required this.isFavorite,
      required this.categoryId,
      required this.createTime,
      required this.lastUpdateTime,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<int>(type);
    map['classification'] = Variable<int>(classification);
    map['title'] = Variable<String>(title);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || expireTime != null) {
      map['expire_time'] = Variable<String>(expireTime);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || uri != null) {
      map['uri'] = Variable<String>(uri);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    map['is_favorite'] = Variable<int>(isFavorite);
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
      classification: Value(classification),
      title: Value(title),
      value: Value(value),
      expireTime: expireTime == null && nullToAbsent
          ? const Value.absent()
          : Value(expireTime),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      uri: uri == null && nullToAbsent ? const Value.absent() : Value(uri),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      isFavorite: Value(isFavorite),
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
      classification: serializer.fromJson<int>(json['classification']),
      title: serializer.fromJson<String>(json['title']),
      value: serializer.fromJson<String>(json['value']),
      expireTime: serializer.fromJson<String?>(json['expire_time']),
      username: serializer.fromJson<String?>(json['username']),
      uri: serializer.fromJson<String?>(json['uri']),
      remark: serializer.fromJson<String?>(json['remark']),
      isFavorite: serializer.fromJson<int>(json['is_favorite']),
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
      'classification': serializer.toJson<int>(classification),
      'title': serializer.toJson<String>(title),
      'value': serializer.toJson<String>(value),
      'expire_time': serializer.toJson<String?>(expireTime),
      'username': serializer.toJson<String?>(username),
      'uri': serializer.toJson<String?>(uri),
      'remark': serializer.toJson<String?>(remark),
      'is_favorite': serializer.toJson<int>(isFavorite),
      'category_id': serializer.toJson<int>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
      'is_deleted': serializer.toJson<int>(isDeleted),
    };
  }

  PasswordEntity copyWith(
          {String? id,
          int? type,
          int? classification,
          String? title,
          String? value,
          Value<String?> expireTime = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> uri = const Value.absent(),
          Value<String?> remark = const Value.absent(),
          int? isFavorite,
          int? categoryId,
          String? createTime,
          String? lastUpdateTime,
          int? isDeleted}) =>
      PasswordEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        classification: classification ?? this.classification,
        title: title ?? this.title,
        value: value ?? this.value,
        expireTime: expireTime.present ? expireTime.value : this.expireTime,
        username: username.present ? username.value : this.username,
        uri: uri.present ? uri.value : this.uri,
        remark: remark.present ? remark.value : this.remark,
        isFavorite: isFavorite ?? this.isFavorite,
        categoryId: categoryId ?? this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  PasswordEntity copyWithCompanion(PasswordsCompanion data) {
    return PasswordEntity(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      title: data.title.present ? data.title.value : this.title,
      value: data.value.present ? data.value.value : this.value,
      expireTime:
          data.expireTime.present ? data.expireTime.value : this.expireTime,
      username: data.username.present ? data.username.value : this.username,
      uri: data.uri.present ? data.uri.value : this.uri,
      remark: data.remark.present ? data.remark.value : this.remark,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
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
          ..write('classification: $classification, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('expireTime: $expireTime, ')
          ..write('username: $username, ')
          ..write('uri: $uri, ')
          ..write('remark: $remark, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      classification,
      title,
      value,
      expireTime,
      username,
      uri,
      remark,
      isFavorite,
      categoryId,
      createTime,
      lastUpdateTime,
      isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordEntity &&
          other.id == this.id &&
          other.type == this.type &&
          other.classification == this.classification &&
          other.title == this.title &&
          other.value == this.value &&
          other.expireTime == this.expireTime &&
          other.username == this.username &&
          other.uri == this.uri &&
          other.remark == this.remark &&
          other.isFavorite == this.isFavorite &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.isDeleted == this.isDeleted);
}

class PasswordsCompanion extends UpdateCompanion<PasswordEntity> {
  final Value<String> id;
  final Value<int> type;
  final Value<int> classification;
  final Value<String> title;
  final Value<String> value;
  final Value<String?> expireTime;
  final Value<String?> username;
  final Value<String?> uri;
  final Value<String?> remark;
  final Value<int> isFavorite;
  final Value<int> categoryId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  final Value<int> isDeleted;
  final Value<int> rowid;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.classification = const Value.absent(),
    this.title = const Value.absent(),
    this.value = const Value.absent(),
    this.expireTime = const Value.absent(),
    this.username = const Value.absent(),
    this.uri = const Value.absent(),
    this.remark = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PasswordsCompanion.insert({
    required String id,
    this.type = const Value.absent(),
    this.classification = const Value.absent(),
    required String title,
    required String value,
    this.expireTime = const Value.absent(),
    this.username = const Value.absent(),
    this.uri = const Value.absent(),
    this.remark = const Value.absent(),
    this.isFavorite = const Value.absent(),
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
    Expression<int>? classification,
    Expression<String>? title,
    Expression<String>? value,
    Expression<String>? expireTime,
    Expression<String>? username,
    Expression<String>? uri,
    Expression<String>? remark,
    Expression<int>? isFavorite,
    Expression<int>? categoryId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
    Expression<int>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (classification != null) 'classification': classification,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (expireTime != null) 'expire_time': expireTime,
      if (username != null) 'username': username,
      if (uri != null) 'uri': uri,
      if (remark != null) 'remark': remark,
      if (isFavorite != null) 'is_favorite': isFavorite,
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
      Value<int>? classification,
      Value<String>? title,
      Value<String>? value,
      Value<String?>? expireTime,
      Value<String?>? username,
      Value<String?>? uri,
      Value<String?>? remark,
      Value<int>? isFavorite,
      Value<int>? categoryId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime,
      Value<int>? isDeleted,
      Value<int>? rowid}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      classification: classification ?? this.classification,
      title: title ?? this.title,
      value: value ?? this.value,
      expireTime: expireTime ?? this.expireTime,
      username: username ?? this.username,
      uri: uri ?? this.uri,
      remark: remark ?? this.remark,
      isFavorite: isFavorite ?? this.isFavorite,
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
    if (classification.present) {
      map['classification'] = Variable<int>(classification.value);
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
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
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
          ..write('classification: $classification, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('expireTime: $expireTime, ')
          ..write('username: $username, ')
          ..write('uri: $uri, ')
          ..write('remark: $remark, ')
          ..write('isFavorite: $isFavorite, ')
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

class Notes extends Table with TableInfo<Notes, NoteEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Notes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  late final GeneratedColumn<int> classification = GeneratedColumn<int>(
      'classification', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _plainTextMeta =
      const VerificationMeta('plainText');
  late final GeneratedColumn<String> plainText = GeneratedColumn<String>(
      'plain_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  late final GeneratedColumn<int> isFavorite = GeneratedColumn<int>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
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
        classification,
        title,
        content,
        plainText,
        isFavorite,
        categoryId,
        createTime,
        lastUpdateTime,
        isDeleted
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<NoteEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('plain_text')) {
      context.handle(_plainTextMeta,
          plainText.isAcceptableOrUnknown(data['plain_text']!, _plainTextMeta));
    } else if (isInserting) {
      context.missing(_plainTextMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
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
  NoteEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classification'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      plainText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plain_text'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_favorite'])!,
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
  Notes createAlias(String alias) {
    return Notes(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(category_id)REFERENCES categories(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class NoteEntity extends DataClass implements Insertable<NoteEntity> {
  final String id;
  final int classification;
  final String title;
  final String content;
  final String plainText;
  final int isFavorite;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  final int isDeleted;
  const NoteEntity(
      {required this.id,
      required this.classification,
      required this.title,
      required this.content,
      required this.plainText,
      required this.isFavorite,
      required this.categoryId,
      required this.createTime,
      required this.lastUpdateTime,
      required this.isDeleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['classification'] = Variable<int>(classification);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['plain_text'] = Variable<String>(plainText);
    map['is_favorite'] = Variable<int>(isFavorite);
    map['category_id'] = Variable<int>(categoryId);
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    map['is_deleted'] = Variable<int>(isDeleted);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      classification: Value(classification),
      title: Value(title),
      content: Value(content),
      plainText: Value(plainText),
      isFavorite: Value(isFavorite),
      categoryId: Value(categoryId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
      isDeleted: Value(isDeleted),
    );
  }

  factory NoteEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteEntity(
      id: serializer.fromJson<String>(json['id']),
      classification: serializer.fromJson<int>(json['classification']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      plainText: serializer.fromJson<String>(json['plain_text']),
      isFavorite: serializer.fromJson<int>(json['is_favorite']),
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
      'classification': serializer.toJson<int>(classification),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'plain_text': serializer.toJson<String>(plainText),
      'is_favorite': serializer.toJson<int>(isFavorite),
      'category_id': serializer.toJson<int>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
      'is_deleted': serializer.toJson<int>(isDeleted),
    };
  }

  NoteEntity copyWith(
          {String? id,
          int? classification,
          String? title,
          String? content,
          String? plainText,
          int? isFavorite,
          int? categoryId,
          String? createTime,
          String? lastUpdateTime,
          int? isDeleted}) =>
      NoteEntity(
        id: id ?? this.id,
        classification: classification ?? this.classification,
        title: title ?? this.title,
        content: content ?? this.content,
        plainText: plainText ?? this.plainText,
        isFavorite: isFavorite ?? this.isFavorite,
        categoryId: categoryId ?? this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
        isDeleted: isDeleted ?? this.isDeleted,
      );
  NoteEntity copyWithCompanion(NotesCompanion data) {
    return NoteEntity(
      id: data.id.present ? data.id.value : this.id,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      plainText: data.plainText.present ? data.plainText.value : this.plainText,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
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
    return (StringBuffer('NoteEntity(')
          ..write('id: $id, ')
          ..write('classification: $classification, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('plainText: $plainText, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classification, title, content, plainText,
      isFavorite, categoryId, createTime, lastUpdateTime, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteEntity &&
          other.id == this.id &&
          other.classification == this.classification &&
          other.title == this.title &&
          other.content == this.content &&
          other.plainText == this.plainText &&
          other.isFavorite == this.isFavorite &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.isDeleted == this.isDeleted);
}

class NotesCompanion extends UpdateCompanion<NoteEntity> {
  final Value<String> id;
  final Value<int> classification;
  final Value<String> title;
  final Value<String> content;
  final Value<String> plainText;
  final Value<int> isFavorite;
  final Value<int> categoryId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  final Value<int> isDeleted;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.classification = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.plainText = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    this.classification = const Value.absent(),
    required String title,
    required String content,
    required String plainText,
    this.isFavorite = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        plainText = Value(plainText),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<NoteEntity> custom({
    Expression<String>? id,
    Expression<int>? classification,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? plainText,
    Expression<int>? isFavorite,
    Expression<int>? categoryId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
    Expression<int>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classification != null) 'classification': classification,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (plainText != null) 'plain_text': plainText,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (categoryId != null) 'category_id': categoryId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<int>? classification,
      Value<String>? title,
      Value<String>? content,
      Value<String>? plainText,
      Value<int>? isFavorite,
      Value<int>? categoryId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime,
      Value<int>? isDeleted,
      Value<int>? rowid}) {
    return NotesCompanion(
      id: id ?? this.id,
      classification: classification ?? this.classification,
      title: title ?? this.title,
      content: content ?? this.content,
      plainText: plainText ?? this.plainText,
      isFavorite: isFavorite ?? this.isFavorite,
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
    if (classification.present) {
      map['classification'] = Variable<int>(classification.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (plainText.present) {
      map['plain_text'] = Variable<String>(plainText.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<int>(isFavorite.value);
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
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('classification: $classification, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('plainText: $plainText, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class NoteViewData extends DataClass {
  final String id;
  final int classification;
  final String title;
  final String abstract;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  const NoteViewData(
      {required this.id,
      required this.classification,
      required this.title,
      required this.abstract,
      required this.categoryId,
      required this.createTime,
      required this.lastUpdateTime});
  factory NoteViewData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteViewData(
      id: serializer.fromJson<String>(json['id']),
      classification: serializer.fromJson<int>(json['classification']),
      title: serializer.fromJson<String>(json['title']),
      abstract: serializer.fromJson<String>(json['abstract']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'classification': serializer.toJson<int>(classification),
      'title': serializer.toJson<String>(title),
      'abstract': serializer.toJson<String>(abstract),
      'category_id': serializer.toJson<int>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  NoteViewData copyWith(
          {String? id,
          int? classification,
          String? title,
          String? abstract,
          int? categoryId,
          String? createTime,
          String? lastUpdateTime}) =>
      NoteViewData(
        id: id ?? this.id,
        classification: classification ?? this.classification,
        title: title ?? this.title,
        abstract: abstract ?? this.abstract,
        categoryId: categoryId ?? this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('NoteViewData(')
          ..write('id: $id, ')
          ..write('classification: $classification, ')
          ..write('title: $title, ')
          ..write('abstract: $abstract, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, classification, title, abstract,
      categoryId, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteViewData &&
          other.id == this.id &&
          other.classification == this.classification &&
          other.title == this.title &&
          other.abstract == this.abstract &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class NoteView extends ViewInfo<NoteView, NoteViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SqliteDb attachedDatabase;
  NoteView(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        classification,
        title,
        abstract,
        categoryId,
        createTime,
        lastUpdateTime
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'note_view';
  @override
  Map<SqlDialect, String> get createViewStatements => {
        SqlDialect.sqlite:
            'CREATE VIEW note_view AS SELECT id, classification, title, SUBSTR(plain_text, 1, 100) AS abstract, category_id, create_time, last_update_time FROM notes WHERE is_deleted = 0',
      };
  @override
  NoteView get asDslTable => this;
  @override
  NoteViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteViewData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classification'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      abstract: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abstract'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string);
  late final GeneratedColumn<int> classification = GeneratedColumn<int>(
      'classification', aliasedName, false,
      type: DriftSqlType.int);
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string);
  late final GeneratedColumn<String> abstract = GeneratedColumn<String>(
      'abstract', aliasedName, false,
      type: DriftSqlType.string);
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int);
  late final GeneratedColumn<String> createTime = GeneratedColumn<String>(
      'create_time', aliasedName, false,
      type: DriftSqlType.string);
  late final GeneratedColumn<String> lastUpdateTime = GeneratedColumn<String>(
      'last_update_time', aliasedName, false,
      type: DriftSqlType.string);
  @override
  NoteView createAlias(String alias) {
    return NoteView(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {'notes'};
}

class Snapshots extends Table with TableInfo<Snapshots, SnapshotEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Snapshots(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  late final GeneratedColumn<int> classification = GeneratedColumn<int>(
      'classification', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  late final GeneratedColumn<String> createTime = GeneratedColumn<String>(
      'create_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, entityId, classification, content, createTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'snapshots';
  @override
  VerificationContext validateIntegrity(Insertable<SnapshotEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SnapshotEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SnapshotEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}classification'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
    );
  }

  @override
  Snapshots createAlias(String alias) {
    return Snapshots(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SnapshotEntity extends DataClass implements Insertable<SnapshotEntity> {
  final String id;
  final String entityId;
  final int classification;
  final String content;
  final String createTime;
  const SnapshotEntity(
      {required this.id,
      required this.entityId,
      required this.classification,
      required this.content,
      required this.createTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_id'] = Variable<String>(entityId);
    map['classification'] = Variable<int>(classification);
    map['content'] = Variable<String>(content);
    map['create_time'] = Variable<String>(createTime);
    return map;
  }

  SnapshotsCompanion toCompanion(bool nullToAbsent) {
    return SnapshotsCompanion(
      id: Value(id),
      entityId: Value(entityId),
      classification: Value(classification),
      content: Value(content),
      createTime: Value(createTime),
    );
  }

  factory SnapshotEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SnapshotEntity(
      id: serializer.fromJson<String>(json['id']),
      entityId: serializer.fromJson<String>(json['entity_id']),
      classification: serializer.fromJson<int>(json['classification']),
      content: serializer.fromJson<String>(json['content']),
      createTime: serializer.fromJson<String>(json['create_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entity_id': serializer.toJson<String>(entityId),
      'classification': serializer.toJson<int>(classification),
      'content': serializer.toJson<String>(content),
      'create_time': serializer.toJson<String>(createTime),
    };
  }

  SnapshotEntity copyWith(
          {String? id,
          String? entityId,
          int? classification,
          String? content,
          String? createTime}) =>
      SnapshotEntity(
        id: id ?? this.id,
        entityId: entityId ?? this.entityId,
        classification: classification ?? this.classification,
        content: content ?? this.content,
        createTime: createTime ?? this.createTime,
      );
  SnapshotEntity copyWithCompanion(SnapshotsCompanion data) {
    return SnapshotEntity(
      id: data.id.present ? data.id.value : this.id,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      content: data.content.present ? data.content.value : this.content,
      createTime:
          data.createTime.present ? data.createTime.value : this.createTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotEntity(')
          ..write('id: $id, ')
          ..write('entityId: $entityId, ')
          ..write('classification: $classification, ')
          ..write('content: $content, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityId, classification, content, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SnapshotEntity &&
          other.id == this.id &&
          other.entityId == this.entityId &&
          other.classification == this.classification &&
          other.content == this.content &&
          other.createTime == this.createTime);
}

class SnapshotsCompanion extends UpdateCompanion<SnapshotEntity> {
  final Value<String> id;
  final Value<String> entityId;
  final Value<int> classification;
  final Value<String> content;
  final Value<String> createTime;
  final Value<int> rowid;
  const SnapshotsCompanion({
    this.id = const Value.absent(),
    this.entityId = const Value.absent(),
    this.classification = const Value.absent(),
    this.content = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SnapshotsCompanion.insert({
    required String id,
    required String entityId,
    this.classification = const Value.absent(),
    required String content,
    required String createTime,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        entityId = Value(entityId),
        content = Value(content),
        createTime = Value(createTime);
  static Insertable<SnapshotEntity> custom({
    Expression<String>? id,
    Expression<String>? entityId,
    Expression<int>? classification,
    Expression<String>? content,
    Expression<String>? createTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityId != null) 'entity_id': entityId,
      if (classification != null) 'classification': classification,
      if (content != null) 'content': content,
      if (createTime != null) 'create_time': createTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SnapshotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? entityId,
      Value<int>? classification,
      Value<String>? content,
      Value<String>? createTime,
      Value<int>? rowid}) {
    return SnapshotsCompanion(
      id: id ?? this.id,
      entityId: entityId ?? this.entityId,
      classification: classification ?? this.classification,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (classification.present) {
      map['classification'] = Variable<int>(classification.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('entityId: $entityId, ')
          ..write('classification: $classification, ')
          ..write('content: $content, ')
          ..write('createTime: $createTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SqliteDb extends GeneratedDatabase {
  _$SqliteDb(QueryExecutor e) : super(e);
  $SqliteDbManager get managers => $SqliteDbManager(this);
  late final Categories categories = Categories(this);
  late final Passwords passwords = Passwords(this);
  late final Attributes attributes = Attributes(this);
  late final Notes notes = Notes(this);
  late final NoteView noteView = NoteView(this);
  late final Snapshots snapshots = Snapshots(this);
  Selectable<ActivePasswordsResult> activePasswords() {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 0',
        variables: [],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => ActivePasswordsResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<PasswordsByClassificationResult> passwordsByClassification(
      int var1) {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 0 AND classification = ?1',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => PasswordsByClassificationResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<PasswordsByCategoryResult> passwordsByCategory(int var1) {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 0 AND category_id = ?1',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => PasswordsByCategoryResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<PasswordsByTypeResult> passwordsByType(int var1) {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 0 AND type = ?1',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => PasswordsByTypeResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<FavoritePasswordsResult> favoritePasswords() {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 0 AND is_favorite = 1',
        variables: [],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => FavoritePasswordsResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<DeletedPasswordsResult> deletedPasswords() {
    return customSelect(
        'SELECT id, type, classification, title, expire_time, category_id, create_time, last_update_time FROM passwords WHERE is_deleted = 1',
        variables: [],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => DeletedPasswordsResult(
          id: row.read<String>('id'),
          type: row.read<int>('type'),
          classification: row.read<int>('classification'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          categoryId: row.read<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categories, passwords, attributes, notes, noteView, snapshots];
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

class $CategoriesFilterComposer extends Composer<_$SqliteDb, Categories> {
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

class $CategoriesOrderingComposer extends Composer<_$SqliteDb, Categories> {
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

class $CategoriesAnnotationComposer extends Composer<_$SqliteDb, Categories> {
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
    _$SqliteDb,
    Categories,
    CategoryEntity,
    $CategoriesFilterComposer,
    $CategoriesOrderingComposer,
    $CategoriesAnnotationComposer,
    $CategoriesCreateCompanionBuilder,
    $CategoriesUpdateCompanionBuilder,
    (CategoryEntity, BaseReferences<_$SqliteDb, Categories, CategoryEntity>),
    CategoryEntity,
    PrefetchHooks Function()> {
  $CategoriesTableManager(_$SqliteDb db, Categories table)
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
    _$SqliteDb,
    Categories,
    CategoryEntity,
    $CategoriesFilterComposer,
    $CategoriesOrderingComposer,
    $CategoriesAnnotationComposer,
    $CategoriesCreateCompanionBuilder,
    $CategoriesUpdateCompanionBuilder,
    (CategoryEntity, BaseReferences<_$SqliteDb, Categories, CategoryEntity>),
    CategoryEntity,
    PrefetchHooks Function()>;
typedef $PasswordsCreateCompanionBuilder = PasswordsCompanion Function({
  required String id,
  Value<int> type,
  Value<int> classification,
  required String title,
  required String value,
  Value<String?> expireTime,
  Value<String?> username,
  Value<String?> uri,
  Value<String?> remark,
  Value<int> isFavorite,
  Value<int> categoryId,
  required String createTime,
  required String lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});
typedef $PasswordsUpdateCompanionBuilder = PasswordsCompanion Function({
  Value<String> id,
  Value<int> type,
  Value<int> classification,
  Value<String> title,
  Value<String> value,
  Value<String?> expireTime,
  Value<String?> username,
  Value<String?> uri,
  Value<String?> remark,
  Value<int> isFavorite,
  Value<int> categoryId,
  Value<String> createTime,
  Value<String> lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});

class $PasswordsFilterComposer extends Composer<_$SqliteDb, Passwords> {
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

  ColumnFilters<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uri => $composableBuilder(
      column: $table.uri, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

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

class $PasswordsOrderingComposer extends Composer<_$SqliteDb, Passwords> {
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

  ColumnOrderings<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uri => $composableBuilder(
      column: $table.uri, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remark => $composableBuilder(
      column: $table.remark, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

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

class $PasswordsAnnotationComposer extends Composer<_$SqliteDb, Passwords> {
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

  GeneratedColumn<int> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get expireTime => $composableBuilder(
      column: $table.expireTime, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

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
    _$SqliteDb,
    Passwords,
    PasswordEntity,
    $PasswordsFilterComposer,
    $PasswordsOrderingComposer,
    $PasswordsAnnotationComposer,
    $PasswordsCreateCompanionBuilder,
    $PasswordsUpdateCompanionBuilder,
    (PasswordEntity, BaseReferences<_$SqliteDb, Passwords, PasswordEntity>),
    PasswordEntity,
    PrefetchHooks Function()> {
  $PasswordsTableManager(_$SqliteDb db, Passwords table)
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
            Value<int> classification = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String?> expireTime = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> uri = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<int> isFavorite = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<String> lastUpdateTime = const Value.absent(),
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PasswordsCompanion(
            id: id,
            type: type,
            classification: classification,
            title: title,
            value: value,
            expireTime: expireTime,
            username: username,
            uri: uri,
            remark: remark,
            isFavorite: isFavorite,
            categoryId: categoryId,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<int> type = const Value.absent(),
            Value<int> classification = const Value.absent(),
            required String title,
            required String value,
            Value<String?> expireTime = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> uri = const Value.absent(),
            Value<String?> remark = const Value.absent(),
            Value<int> isFavorite = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            required String createTime,
            required String lastUpdateTime,
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PasswordsCompanion.insert(
            id: id,
            type: type,
            classification: classification,
            title: title,
            value: value,
            expireTime: expireTime,
            username: username,
            uri: uri,
            remark: remark,
            isFavorite: isFavorite,
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
    _$SqliteDb,
    Passwords,
    PasswordEntity,
    $PasswordsFilterComposer,
    $PasswordsOrderingComposer,
    $PasswordsAnnotationComposer,
    $PasswordsCreateCompanionBuilder,
    $PasswordsUpdateCompanionBuilder,
    (PasswordEntity, BaseReferences<_$SqliteDb, Passwords, PasswordEntity>),
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

class $AttributesFilterComposer extends Composer<_$SqliteDb, Attributes> {
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

class $AttributesOrderingComposer extends Composer<_$SqliteDb, Attributes> {
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

class $AttributesAnnotationComposer extends Composer<_$SqliteDb, Attributes> {
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
    _$SqliteDb,
    Attributes,
    Attribute,
    $AttributesFilterComposer,
    $AttributesOrderingComposer,
    $AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (Attribute, BaseReferences<_$SqliteDb, Attributes, Attribute>),
    Attribute,
    PrefetchHooks Function()> {
  $AttributesTableManager(_$SqliteDb db, Attributes table)
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
    _$SqliteDb,
    Attributes,
    Attribute,
    $AttributesFilterComposer,
    $AttributesOrderingComposer,
    $AttributesAnnotationComposer,
    $AttributesCreateCompanionBuilder,
    $AttributesUpdateCompanionBuilder,
    (Attribute, BaseReferences<_$SqliteDb, Attributes, Attribute>),
    Attribute,
    PrefetchHooks Function()>;
typedef $NotesCreateCompanionBuilder = NotesCompanion Function({
  required String id,
  Value<int> classification,
  required String title,
  required String content,
  required String plainText,
  Value<int> isFavorite,
  Value<int> categoryId,
  required String createTime,
  required String lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});
typedef $NotesUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> id,
  Value<int> classification,
  Value<String> title,
  Value<String> content,
  Value<String> plainText,
  Value<int> isFavorite,
  Value<int> categoryId,
  Value<String> createTime,
  Value<String> lastUpdateTime,
  Value<int> isDeleted,
  Value<int> rowid,
});

class $NotesFilterComposer extends Composer<_$SqliteDb, Notes> {
  $NotesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plainText => $composableBuilder(
      column: $table.plainText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

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

class $NotesOrderingComposer extends Composer<_$SqliteDb, Notes> {
  $NotesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plainText => $composableBuilder(
      column: $table.plainText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

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

class $NotesAnnotationComposer extends Composer<_$SqliteDb, Notes> {
  $NotesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get plainText =>
      $composableBuilder(column: $table.plainText, builder: (column) => column);

  GeneratedColumn<int> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);

  GeneratedColumn<String> get lastUpdateTime => $composableBuilder(
      column: $table.lastUpdateTime, builder: (column) => column);

  GeneratedColumn<int> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $NotesTableManager extends RootTableManager<
    _$SqliteDb,
    Notes,
    NoteEntity,
    $NotesFilterComposer,
    $NotesOrderingComposer,
    $NotesAnnotationComposer,
    $NotesCreateCompanionBuilder,
    $NotesUpdateCompanionBuilder,
    (NoteEntity, BaseReferences<_$SqliteDb, Notes, NoteEntity>),
    NoteEntity,
    PrefetchHooks Function()> {
  $NotesTableManager(_$SqliteDb db, Notes table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $NotesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $NotesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $NotesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> classification = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> plainText = const Value.absent(),
            Value<int> isFavorite = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<String> lastUpdateTime = const Value.absent(),
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            classification: classification,
            title: title,
            content: content,
            plainText: plainText,
            isFavorite: isFavorite,
            categoryId: categoryId,
            createTime: createTime,
            lastUpdateTime: lastUpdateTime,
            isDeleted: isDeleted,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<int> classification = const Value.absent(),
            required String title,
            required String content,
            required String plainText,
            Value<int> isFavorite = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            required String createTime,
            required String lastUpdateTime,
            Value<int> isDeleted = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            classification: classification,
            title: title,
            content: content,
            plainText: plainText,
            isFavorite: isFavorite,
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

typedef $NotesProcessedTableManager = ProcessedTableManager<
    _$SqliteDb,
    Notes,
    NoteEntity,
    $NotesFilterComposer,
    $NotesOrderingComposer,
    $NotesAnnotationComposer,
    $NotesCreateCompanionBuilder,
    $NotesUpdateCompanionBuilder,
    (NoteEntity, BaseReferences<_$SqliteDb, Notes, NoteEntity>),
    NoteEntity,
    PrefetchHooks Function()>;
typedef $SnapshotsCreateCompanionBuilder = SnapshotsCompanion Function({
  required String id,
  required String entityId,
  Value<int> classification,
  required String content,
  required String createTime,
  Value<int> rowid,
});
typedef $SnapshotsUpdateCompanionBuilder = SnapshotsCompanion Function({
  Value<String> id,
  Value<String> entityId,
  Value<int> classification,
  Value<String> content,
  Value<String> createTime,
  Value<int> rowid,
});

class $SnapshotsFilterComposer extends Composer<_$SqliteDb, Snapshots> {
  $SnapshotsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnFilters(column));
}

class $SnapshotsOrderingComposer extends Composer<_$SqliteDb, Snapshots> {
  $SnapshotsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => ColumnOrderings(column));
}

class $SnapshotsAnnotationComposer extends Composer<_$SqliteDb, Snapshots> {
  $SnapshotsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<int> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get createTime => $composableBuilder(
      column: $table.createTime, builder: (column) => column);
}

class $SnapshotsTableManager extends RootTableManager<
    _$SqliteDb,
    Snapshots,
    SnapshotEntity,
    $SnapshotsFilterComposer,
    $SnapshotsOrderingComposer,
    $SnapshotsAnnotationComposer,
    $SnapshotsCreateCompanionBuilder,
    $SnapshotsUpdateCompanionBuilder,
    (SnapshotEntity, BaseReferences<_$SqliteDb, Snapshots, SnapshotEntity>),
    SnapshotEntity,
    PrefetchHooks Function()> {
  $SnapshotsTableManager(_$SqliteDb db, Snapshots table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SnapshotsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SnapshotsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SnapshotsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<int> classification = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> createTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SnapshotsCompanion(
            id: id,
            entityId: entityId,
            classification: classification,
            content: content,
            createTime: createTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String entityId,
            Value<int> classification = const Value.absent(),
            required String content,
            required String createTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              SnapshotsCompanion.insert(
            id: id,
            entityId: entityId,
            classification: classification,
            content: content,
            createTime: createTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $SnapshotsProcessedTableManager = ProcessedTableManager<
    _$SqliteDb,
    Snapshots,
    SnapshotEntity,
    $SnapshotsFilterComposer,
    $SnapshotsOrderingComposer,
    $SnapshotsAnnotationComposer,
    $SnapshotsCreateCompanionBuilder,
    $SnapshotsUpdateCompanionBuilder,
    (SnapshotEntity, BaseReferences<_$SqliteDb, Snapshots, SnapshotEntity>),
    SnapshotEntity,
    PrefetchHooks Function()>;

class $SqliteDbManager {
  final _$SqliteDb _db;
  $SqliteDbManager(this._db);
  $CategoriesTableManager get categories =>
      $CategoriesTableManager(_db, _db.categories);
  $PasswordsTableManager get passwords =>
      $PasswordsTableManager(_db, _db.passwords);
  $AttributesTableManager get attributes =>
      $AttributesTableManager(_db, _db.attributes);
  $NotesTableManager get notes => $NotesTableManager(_db, _db.notes);
  $SnapshotsTableManager get snapshots =>
      $SnapshotsTableManager(_db, _db.snapshots);
}

class ActivePasswordsResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  ActivePasswordsResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class PasswordsByClassificationResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  PasswordsByClassificationResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class PasswordsByCategoryResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  PasswordsByCategoryResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class PasswordsByTypeResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  PasswordsByTypeResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class FavoritePasswordsResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  FavoritePasswordsResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class DeletedPasswordsResult {
  final String id;
  final int type;
  final int classification;
  final String title;
  final String? expireTime;
  final int categoryId;
  final String createTime;
  final String lastUpdateTime;
  DeletedPasswordsResult({
    required this.id,
    required this.type,
    required this.classification,
    required this.title,
    this.expireTime,
    required this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}
