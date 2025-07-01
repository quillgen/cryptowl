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

class TNote extends Table with TableInfo<TNote, TNoteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TNote(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentChecksumMeta =
      const VerificationMeta('contentChecksum');
  late final GeneratedColumn<String> contentChecksum = GeneratedColumn<String>(
      'content_checksum', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentPlainMeta =
      const VerificationMeta('contentPlain');
  late final GeneratedColumn<String> contentPlain = GeneratedColumn<String>(
      'content_plain', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _abstractMeta =
      const VerificationMeta('abstract');
  late final GeneratedColumn<String> abstract = GeneratedColumn<String>(
      'abstract', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
      'classification', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints:
          'NOT NULL CHECK (classification IN (\'C\', \'S\', \'T\'))');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression('CURRENT_TIMESTAMP'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression('CURRENT_TIMESTAMP'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'DEFAULT NULL',
      defaultValue: const CustomExpression('NULL'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        contentJson,
        contentChecksum,
        contentPlain,
        abstract,
        classification,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_note';
  @override
  VerificationContext validateIntegrity(Insertable<TNoteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('content_checksum')) {
      context.handle(
          _contentChecksumMeta,
          contentChecksum.isAcceptableOrUnknown(
              data['content_checksum']!, _contentChecksumMeta));
    } else if (isInserting) {
      context.missing(_contentChecksumMeta);
    }
    if (data.containsKey('content_plain')) {
      context.handle(
          _contentPlainMeta,
          contentPlain.isAcceptableOrUnknown(
              data['content_plain']!, _contentPlainMeta));
    } else if (isInserting) {
      context.missing(_contentPlainMeta);
    }
    if (data.containsKey('abstract')) {
      context.handle(_abstractMeta,
          abstract.isAcceptableOrUnknown(data['abstract']!, _abstractMeta));
    }
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
    } else if (isInserting) {
      context.missing(_classificationMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TNoteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TNoteData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      contentChecksum: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}content_checksum'])!,
      contentPlain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_plain'])!,
      abstract: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abstract']),
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classification'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  TNote createAlias(String alias) {
    return TNote(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TNoteData extends DataClass implements Insertable<TNoteData> {
  final String id;
  final String? title;
  final String contentJson;
  final String contentChecksum;
  final String contentPlain;
  final String? abstract;
  final String classification;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TNoteData(
      {required this.id,
      this.title,
      required this.contentJson,
      required this.contentChecksum,
      required this.contentPlain,
      this.abstract,
      required this.classification,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['content_json'] = Variable<String>(contentJson);
    map['content_checksum'] = Variable<String>(contentChecksum);
    map['content_plain'] = Variable<String>(contentPlain);
    if (!nullToAbsent || abstract != null) {
      map['abstract'] = Variable<String>(abstract);
    }
    map['classification'] = Variable<String>(classification);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TNoteCompanion toCompanion(bool nullToAbsent) {
    return TNoteCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      contentJson: Value(contentJson),
      contentChecksum: Value(contentChecksum),
      contentPlain: Value(contentPlain),
      abstract: abstract == null && nullToAbsent
          ? const Value.absent()
          : Value(abstract),
      classification: Value(classification),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TNoteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TNoteData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      contentJson: serializer.fromJson<String>(json['content_json']),
      contentChecksum: serializer.fromJson<String>(json['content_checksum']),
      contentPlain: serializer.fromJson<String>(json['content_plain']),
      abstract: serializer.fromJson<String?>(json['abstract']),
      classification: serializer.fromJson<String>(json['classification']),
      createdAt: serializer.fromJson<DateTime>(json['created_at']),
      updatedAt: serializer.fromJson<DateTime>(json['updated_at']),
      deletedAt: serializer.fromJson<DateTime?>(json['deleted_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'content_json': serializer.toJson<String>(contentJson),
      'content_checksum': serializer.toJson<String>(contentChecksum),
      'content_plain': serializer.toJson<String>(contentPlain),
      'abstract': serializer.toJson<String?>(abstract),
      'classification': serializer.toJson<String>(classification),
      'created_at': serializer.toJson<DateTime>(createdAt),
      'updated_at': serializer.toJson<DateTime>(updatedAt),
      'deleted_at': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TNoteData copyWith(
          {String? id,
          Value<String?> title = const Value.absent(),
          String? contentJson,
          String? contentChecksum,
          String? contentPlain,
          Value<String?> abstract = const Value.absent(),
          String? classification,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TNoteData(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        contentJson: contentJson ?? this.contentJson,
        contentChecksum: contentChecksum ?? this.contentChecksum,
        contentPlain: contentPlain ?? this.contentPlain,
        abstract: abstract.present ? abstract.value : this.abstract,
        classification: classification ?? this.classification,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  TNoteData copyWithCompanion(TNoteCompanion data) {
    return TNoteData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      contentChecksum: data.contentChecksum.present
          ? data.contentChecksum.value
          : this.contentChecksum,
      contentPlain: data.contentPlain.present
          ? data.contentPlain.value
          : this.contentPlain,
      abstract: data.abstract.present ? data.abstract.value : this.abstract,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TNoteData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contentJson: $contentJson, ')
          ..write('contentChecksum: $contentChecksum, ')
          ..write('contentPlain: $contentPlain, ')
          ..write('abstract: $abstract, ')
          ..write('classification: $classification, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, contentJson, contentChecksum,
      contentPlain, abstract, classification, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TNoteData &&
          other.id == this.id &&
          other.title == this.title &&
          other.contentJson == this.contentJson &&
          other.contentChecksum == this.contentChecksum &&
          other.contentPlain == this.contentPlain &&
          other.abstract == this.abstract &&
          other.classification == this.classification &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TNoteCompanion extends UpdateCompanion<TNoteData> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String> contentJson;
  final Value<String> contentChecksum;
  final Value<String> contentPlain;
  final Value<String?> abstract;
  final Value<String> classification;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TNoteCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.contentChecksum = const Value.absent(),
    this.contentPlain = const Value.absent(),
    this.abstract = const Value.absent(),
    this.classification = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TNoteCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    required String contentJson,
    required String contentChecksum,
    required String contentPlain,
    this.abstract = const Value.absent(),
    required String classification,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        contentJson = Value(contentJson),
        contentChecksum = Value(contentChecksum),
        contentPlain = Value(contentPlain),
        classification = Value(classification);
  static Insertable<TNoteData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? contentJson,
    Expression<String>? contentChecksum,
    Expression<String>? contentPlain,
    Expression<String>? abstract,
    Expression<String>? classification,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (contentJson != null) 'content_json': contentJson,
      if (contentChecksum != null) 'content_checksum': contentChecksum,
      if (contentPlain != null) 'content_plain': contentPlain,
      if (abstract != null) 'abstract': abstract,
      if (classification != null) 'classification': classification,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TNoteCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<String>? contentJson,
      Value<String>? contentChecksum,
      Value<String>? contentPlain,
      Value<String?>? abstract,
      Value<String>? classification,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return TNoteCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      contentJson: contentJson ?? this.contentJson,
      contentChecksum: contentChecksum ?? this.contentChecksum,
      contentPlain: contentPlain ?? this.contentPlain,
      abstract: abstract ?? this.abstract,
      classification: classification ?? this.classification,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (contentChecksum.present) {
      map['content_checksum'] = Variable<String>(contentChecksum.value);
    }
    if (contentPlain.present) {
      map['content_plain'] = Variable<String>(contentPlain.value);
    }
    if (abstract.present) {
      map['abstract'] = Variable<String>(abstract.value);
    }
    if (classification.present) {
      map['classification'] = Variable<String>(classification.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TNoteCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contentJson: $contentJson, ')
          ..write('contentChecksum: $contentChecksum, ')
          ..write('contentPlain: $contentPlain, ')
          ..write('abstract: $abstract, ')
          ..write('classification: $classification, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TNoteHistory extends Table
    with TableInfo<TNoteHistory, TNoteHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TNoteHistory(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentChecksumMeta =
      const VerificationMeta('contentChecksum');
  late final GeneratedColumn<String> contentChecksum = GeneratedColumn<String>(
      'content_checksum', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _contentPlainMeta =
      const VerificationMeta('contentPlain');
  late final GeneratedColumn<String> contentPlain = GeneratedColumn<String>(
      'content_plain', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression('CURRENT_TIMESTAMP'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, noteId, contentJson, contentChecksum, contentPlain, changedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_note_history';
  @override
  VerificationContext validateIntegrity(Insertable<TNoteHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('content_checksum')) {
      context.handle(
          _contentChecksumMeta,
          contentChecksum.isAcceptableOrUnknown(
              data['content_checksum']!, _contentChecksumMeta));
    } else if (isInserting) {
      context.missing(_contentChecksumMeta);
    }
    if (data.containsKey('content_plain')) {
      context.handle(
          _contentPlainMeta,
          contentPlain.isAcceptableOrUnknown(
              data['content_plain']!, _contentPlainMeta));
    } else if (isInserting) {
      context.missing(_contentPlainMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TNoteHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TNoteHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      contentChecksum: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}content_checksum'])!,
      contentPlain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_plain'])!,
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
    );
  }

  @override
  TNoteHistory createAlias(String alias) {
    return TNoteHistory(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(note_id)REFERENCES t_note(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class TNoteHistoryData extends DataClass
    implements Insertable<TNoteHistoryData> {
  final int id;
  final String noteId;
  final String contentJson;
  final String contentChecksum;
  final String contentPlain;
  final DateTime changedAt;
  const TNoteHistoryData(
      {required this.id,
      required this.noteId,
      required this.contentJson,
      required this.contentChecksum,
      required this.contentPlain,
      required this.changedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<String>(noteId);
    map['content_json'] = Variable<String>(contentJson);
    map['content_checksum'] = Variable<String>(contentChecksum);
    map['content_plain'] = Variable<String>(contentPlain);
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  TNoteHistoryCompanion toCompanion(bool nullToAbsent) {
    return TNoteHistoryCompanion(
      id: Value(id),
      noteId: Value(noteId),
      contentJson: Value(contentJson),
      contentChecksum: Value(contentChecksum),
      contentPlain: Value(contentPlain),
      changedAt: Value(changedAt),
    );
  }

  factory TNoteHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TNoteHistoryData(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<String>(json['note_id']),
      contentJson: serializer.fromJson<String>(json['content_json']),
      contentChecksum: serializer.fromJson<String>(json['content_checksum']),
      contentPlain: serializer.fromJson<String>(json['content_plain']),
      changedAt: serializer.fromJson<DateTime>(json['changed_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'note_id': serializer.toJson<String>(noteId),
      'content_json': serializer.toJson<String>(contentJson),
      'content_checksum': serializer.toJson<String>(contentChecksum),
      'content_plain': serializer.toJson<String>(contentPlain),
      'changed_at': serializer.toJson<DateTime>(changedAt),
    };
  }

  TNoteHistoryData copyWith(
          {int? id,
          String? noteId,
          String? contentJson,
          String? contentChecksum,
          String? contentPlain,
          DateTime? changedAt}) =>
      TNoteHistoryData(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        contentJson: contentJson ?? this.contentJson,
        contentChecksum: contentChecksum ?? this.contentChecksum,
        contentPlain: contentPlain ?? this.contentPlain,
        changedAt: changedAt ?? this.changedAt,
      );
  TNoteHistoryData copyWithCompanion(TNoteHistoryCompanion data) {
    return TNoteHistoryData(
      id: data.id.present ? data.id.value : this.id,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      contentChecksum: data.contentChecksum.present
          ? data.contentChecksum.value
          : this.contentChecksum,
      contentPlain: data.contentPlain.present
          ? data.contentPlain.value
          : this.contentPlain,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TNoteHistoryData(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('contentJson: $contentJson, ')
          ..write('contentChecksum: $contentChecksum, ')
          ..write('contentPlain: $contentPlain, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, noteId, contentJson, contentChecksum, contentPlain, changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TNoteHistoryData &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.contentJson == this.contentJson &&
          other.contentChecksum == this.contentChecksum &&
          other.contentPlain == this.contentPlain &&
          other.changedAt == this.changedAt);
}

class TNoteHistoryCompanion extends UpdateCompanion<TNoteHistoryData> {
  final Value<int> id;
  final Value<String> noteId;
  final Value<String> contentJson;
  final Value<String> contentChecksum;
  final Value<String> contentPlain;
  final Value<DateTime> changedAt;
  const TNoteHistoryCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.contentChecksum = const Value.absent(),
    this.contentPlain = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  TNoteHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String noteId,
    required String contentJson,
    required String contentChecksum,
    required String contentPlain,
    this.changedAt = const Value.absent(),
  })  : noteId = Value(noteId),
        contentJson = Value(contentJson),
        contentChecksum = Value(contentChecksum),
        contentPlain = Value(contentPlain);
  static Insertable<TNoteHistoryData> custom({
    Expression<int>? id,
    Expression<String>? noteId,
    Expression<String>? contentJson,
    Expression<String>? contentChecksum,
    Expression<String>? contentPlain,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (contentJson != null) 'content_json': contentJson,
      if (contentChecksum != null) 'content_checksum': contentChecksum,
      if (contentPlain != null) 'content_plain': contentPlain,
      if (changedAt != null) 'changed_at': changedAt,
    });
  }

  TNoteHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? noteId,
      Value<String>? contentJson,
      Value<String>? contentChecksum,
      Value<String>? contentPlain,
      Value<DateTime>? changedAt}) {
    return TNoteHistoryCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      contentJson: contentJson ?? this.contentJson,
      contentChecksum: contentChecksum ?? this.contentChecksum,
      contentPlain: contentPlain ?? this.contentPlain,
      changedAt: changedAt ?? this.changedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (contentChecksum.present) {
      map['content_checksum'] = Variable<String>(contentChecksum.value);
    }
    if (contentPlain.present) {
      map['content_plain'] = Variable<String>(contentPlain.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TNoteHistoryCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('contentJson: $contentJson, ')
          ..write('contentChecksum: $contentChecksum, ')
          ..write('contentPlain: $contentPlain, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

class TNoteIdx extends Table
    with
        TableInfo<TNoteIdx, TNoteIdxData>,
        VirtualTableInfo<TNoteIdx, TNoteIdxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TNoteIdx(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  static const VerificationMeta _contentPlainMeta =
      const VerificationMeta('contentPlain');
  late final GeneratedColumn<String> contentPlain = GeneratedColumn<String>(
      'content_plain', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [title, contentPlain];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 't_note_idx';
  @override
  VerificationContext validateIntegrity(Insertable<TNoteIdxData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content_plain')) {
      context.handle(
          _contentPlainMeta,
          contentPlain.isAcceptableOrUnknown(
              data['content_plain']!, _contentPlainMeta));
    } else if (isInserting) {
      context.missing(_contentPlainMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TNoteIdxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TNoteIdxData(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contentPlain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_plain'])!,
    );
  }

  @override
  TNoteIdx createAlias(String alias) {
    return TNoteIdx(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
  @override
  String get moduleAndArgs => 'FTS5(title, content_plain, content="t_note")';
}

class TNoteIdxData extends DataClass implements Insertable<TNoteIdxData> {
  final String title;
  final String contentPlain;
  const TNoteIdxData({required this.title, required this.contentPlain});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['content_plain'] = Variable<String>(contentPlain);
    return map;
  }

  TNoteIdxCompanion toCompanion(bool nullToAbsent) {
    return TNoteIdxCompanion(
      title: Value(title),
      contentPlain: Value(contentPlain),
    );
  }

  factory TNoteIdxData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TNoteIdxData(
      title: serializer.fromJson<String>(json['title']),
      contentPlain: serializer.fromJson<String>(json['content_plain']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'content_plain': serializer.toJson<String>(contentPlain),
    };
  }

  TNoteIdxData copyWith({String? title, String? contentPlain}) => TNoteIdxData(
        title: title ?? this.title,
        contentPlain: contentPlain ?? this.contentPlain,
      );
  TNoteIdxData copyWithCompanion(TNoteIdxCompanion data) {
    return TNoteIdxData(
      title: data.title.present ? data.title.value : this.title,
      contentPlain: data.contentPlain.present
          ? data.contentPlain.value
          : this.contentPlain,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TNoteIdxData(')
          ..write('title: $title, ')
          ..write('contentPlain: $contentPlain')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, contentPlain);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TNoteIdxData &&
          other.title == this.title &&
          other.contentPlain == this.contentPlain);
}

class TNoteIdxCompanion extends UpdateCompanion<TNoteIdxData> {
  final Value<String> title;
  final Value<String> contentPlain;
  final Value<int> rowid;
  const TNoteIdxCompanion({
    this.title = const Value.absent(),
    this.contentPlain = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TNoteIdxCompanion.insert({
    required String title,
    required String contentPlain,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        contentPlain = Value(contentPlain);
  static Insertable<TNoteIdxData> custom({
    Expression<String>? title,
    Expression<String>? contentPlain,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (contentPlain != null) 'content_plain': contentPlain,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TNoteIdxCompanion copyWith(
      {Value<String>? title, Value<String>? contentPlain, Value<int>? rowid}) {
    return TNoteIdxCompanion(
      title: title ?? this.title,
      contentPlain: contentPlain ?? this.contentPlain,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contentPlain.present) {
      map['content_plain'] = Variable<String>(contentPlain.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TNoteIdxCompanion(')
          ..write('title: $title, ')
          ..write('contentPlain: $contentPlain, ')
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
  late final TNote tNote = TNote(this);
  late final TNoteHistory tNoteHistory = TNoteHistory(this);
  late final TNoteIdx tNoteIdx = TNoteIdx(this);
  late final Trigger triOnNoteInserted = Trigger(
      'CREATE TRIGGER tri_on_note_inserted AFTER INSERT ON t_note WHEN new.deleted_at IS NULL BEGIN INSERT INTO t_note_idx ("rowid", title, content_plain) VALUES (new."rowid", new.title, new.content_plain);END',
      'tri_on_note_inserted');
  late final Trigger triOnNoteUpdated = Trigger(
      'CREATE TRIGGER tri_on_note_updated AFTER UPDATE ON t_note WHEN new.deleted_at IS NULL BEGIN INSERT INTO t_note_idx (t_note_idx, "rowid", title, content_plain) VALUES (\'delete\', old."rowid", old.title, old.content_plain);INSERT INTO t_note_idx ("rowid", title, content_plain) VALUES (new."rowid", new.title, new.content_plain);END',
      'tri_on_note_updated');
  late final Trigger triOnNoteDeleted = Trigger(
      'CREATE TRIGGER tri_on_note_deleted AFTER UPDATE ON t_note WHEN new.deleted_at IS NOT NULL BEGIN INSERT INTO t_note_idx (t_note_idx, "rowid", title, content_plain) VALUES (\'delete\', old."rowid", old.title, old.content_plain);END',
      'tri_on_note_deleted');
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

  Selectable<SelectNotesResult> selectNotes(SelectNotes$order order) {
    var $arrayStartIndex = 1;
    final generatedorder = $write(
        order?.call(this.tNote) ?? const OrderBy.nothing(),
        startIndex: $arrayStartIndex);
    $arrayStartIndex += generatedorder.amountOfVariables;
    return customSelect(
        'SELECT id, classification, title, abstract, created_at, updated_at FROM t_note WHERE deleted_at IS NULL ${generatedorder.sql}',
        variables: [
          ...generatedorder.introducedVariables
        ],
        readsFrom: {
          tNote,
          ...generatedorder.watchedTables,
        }).map((QueryRow row) => SelectNotesResult(
          id: row.read<String>('id'),
          classification: row.read<String>('classification'),
          title: row.readNullable<String>('title'),
          abstract: row.readNullable<String>('abstract'),
          createdAt: row.read<DateTime>('created_at'),
          updatedAt: row.read<DateTime>('updated_at'),
        ));
  }

  Selectable<SearchNotesResult> searchNotes(String var1) {
    return customSelect(
        'SELECT n.id, n.title, n.classification, n.abstract, n.created_at, n.updated_at FROM t_note_idx AS i JOIN t_note AS n ON i."rowid" = n."rowid" WHERE t_note_idx MATCH ?1 AND n.deleted_at IS NULL ORDER BY rank',
        variables: [
          Variable<String>(var1)
        ],
        readsFrom: {
          tNote,
          tNoteIdx,
        }).map((QueryRow row) => SearchNotesResult(
          id: row.read<String>('id'),
          title: row.readNullable<String>('title'),
          classification: row.read<String>('classification'),
          abstract: row.readNullable<String>('abstract'),
          createdAt: row.read<DateTime>('created_at'),
          updatedAt: row.read<DateTime>('updated_at'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categories,
        passwords,
        attributes,
        tNote,
        tNoteHistory,
        tNoteIdx,
        triOnNoteInserted,
        triOnNoteUpdated,
        triOnNoteDeleted
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('t_note',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('t_note_idx', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('t_note',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('t_note_idx', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('t_note',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('t_note_idx', kind: UpdateKind.insert),
            ],
          ),
        ],
      );
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
typedef $TNoteCreateCompanionBuilder = TNoteCompanion Function({
  required String id,
  Value<String?> title,
  required String contentJson,
  required String contentChecksum,
  required String contentPlain,
  Value<String?> abstract,
  required String classification,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $TNoteUpdateCompanionBuilder = TNoteCompanion Function({
  Value<String> id,
  Value<String?> title,
  Value<String> contentJson,
  Value<String> contentChecksum,
  Value<String> contentPlain,
  Value<String?> abstract,
  Value<String> classification,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

class $TNoteFilterComposer extends Composer<_$SqliteDb, TNote> {
  $TNoteFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get abstract => $composableBuilder(
      column: $table.abstract, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $TNoteOrderingComposer extends Composer<_$SqliteDb, TNote> {
  $TNoteOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get abstract => $composableBuilder(
      column: $table.abstract, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $TNoteAnnotationComposer extends Composer<_$SqliteDb, TNote> {
  $TNoteAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum, builder: (column) => column);

  GeneratedColumn<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => column);

  GeneratedColumn<String> get abstract =>
      $composableBuilder(column: $table.abstract, builder: (column) => column);

  GeneratedColumn<String> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $TNoteTableManager extends RootTableManager<
    _$SqliteDb,
    TNote,
    TNoteData,
    $TNoteFilterComposer,
    $TNoteOrderingComposer,
    $TNoteAnnotationComposer,
    $TNoteCreateCompanionBuilder,
    $TNoteUpdateCompanionBuilder,
    (TNoteData, BaseReferences<_$SqliteDb, TNote, TNoteData>),
    TNoteData,
    PrefetchHooks Function()> {
  $TNoteTableManager(_$SqliteDb db, TNote table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TNoteFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TNoteOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TNoteAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<String> contentChecksum = const Value.absent(),
            Value<String> contentPlain = const Value.absent(),
            Value<String?> abstract = const Value.absent(),
            Value<String> classification = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TNoteCompanion(
            id: id,
            title: title,
            contentJson: contentJson,
            contentChecksum: contentChecksum,
            contentPlain: contentPlain,
            abstract: abstract,
            classification: classification,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> title = const Value.absent(),
            required String contentJson,
            required String contentChecksum,
            required String contentPlain,
            Value<String?> abstract = const Value.absent(),
            required String classification,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TNoteCompanion.insert(
            id: id,
            title: title,
            contentJson: contentJson,
            contentChecksum: contentChecksum,
            contentPlain: contentPlain,
            abstract: abstract,
            classification: classification,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $TNoteProcessedTableManager = ProcessedTableManager<
    _$SqliteDb,
    TNote,
    TNoteData,
    $TNoteFilterComposer,
    $TNoteOrderingComposer,
    $TNoteAnnotationComposer,
    $TNoteCreateCompanionBuilder,
    $TNoteUpdateCompanionBuilder,
    (TNoteData, BaseReferences<_$SqliteDb, TNote, TNoteData>),
    TNoteData,
    PrefetchHooks Function()>;
typedef $TNoteHistoryCreateCompanionBuilder = TNoteHistoryCompanion Function({
  Value<int> id,
  required String noteId,
  required String contentJson,
  required String contentChecksum,
  required String contentPlain,
  Value<DateTime> changedAt,
});
typedef $TNoteHistoryUpdateCompanionBuilder = TNoteHistoryCompanion Function({
  Value<int> id,
  Value<String> noteId,
  Value<String> contentJson,
  Value<String> contentChecksum,
  Value<String> contentPlain,
  Value<DateTime> changedAt,
});

class $TNoteHistoryFilterComposer extends Composer<_$SqliteDb, TNoteHistory> {
  $TNoteHistoryFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));
}

class $TNoteHistoryOrderingComposer extends Composer<_$SqliteDb, TNoteHistory> {
  $TNoteHistoryOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get noteId => $composableBuilder(
      column: $table.noteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));
}

class $TNoteHistoryAnnotationComposer
    extends Composer<_$SqliteDb, TNoteHistory> {
  $TNoteHistoryAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get noteId =>
      $composableBuilder(column: $table.noteId, builder: (column) => column);

  GeneratedColumn<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<String> get contentChecksum => $composableBuilder(
      column: $table.contentChecksum, builder: (column) => column);

  GeneratedColumn<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $TNoteHistoryTableManager extends RootTableManager<
    _$SqliteDb,
    TNoteHistory,
    TNoteHistoryData,
    $TNoteHistoryFilterComposer,
    $TNoteHistoryOrderingComposer,
    $TNoteHistoryAnnotationComposer,
    $TNoteHistoryCreateCompanionBuilder,
    $TNoteHistoryUpdateCompanionBuilder,
    (
      TNoteHistoryData,
      BaseReferences<_$SqliteDb, TNoteHistory, TNoteHistoryData>
    ),
    TNoteHistoryData,
    PrefetchHooks Function()> {
  $TNoteHistoryTableManager(_$SqliteDb db, TNoteHistory table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TNoteHistoryFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TNoteHistoryOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TNoteHistoryAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> noteId = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<String> contentChecksum = const Value.absent(),
            Value<String> contentPlain = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              TNoteHistoryCompanion(
            id: id,
            noteId: noteId,
            contentJson: contentJson,
            contentChecksum: contentChecksum,
            contentPlain: contentPlain,
            changedAt: changedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String noteId,
            required String contentJson,
            required String contentChecksum,
            required String contentPlain,
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              TNoteHistoryCompanion.insert(
            id: id,
            noteId: noteId,
            contentJson: contentJson,
            contentChecksum: contentChecksum,
            contentPlain: contentPlain,
            changedAt: changedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $TNoteHistoryProcessedTableManager = ProcessedTableManager<
    _$SqliteDb,
    TNoteHistory,
    TNoteHistoryData,
    $TNoteHistoryFilterComposer,
    $TNoteHistoryOrderingComposer,
    $TNoteHistoryAnnotationComposer,
    $TNoteHistoryCreateCompanionBuilder,
    $TNoteHistoryUpdateCompanionBuilder,
    (
      TNoteHistoryData,
      BaseReferences<_$SqliteDb, TNoteHistory, TNoteHistoryData>
    ),
    TNoteHistoryData,
    PrefetchHooks Function()>;
typedef $TNoteIdxCreateCompanionBuilder = TNoteIdxCompanion Function({
  required String title,
  required String contentPlain,
  Value<int> rowid,
});
typedef $TNoteIdxUpdateCompanionBuilder = TNoteIdxCompanion Function({
  Value<String> title,
  Value<String> contentPlain,
  Value<int> rowid,
});

class $TNoteIdxFilterComposer extends Composer<_$SqliteDb, TNoteIdx> {
  $TNoteIdxFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => ColumnFilters(column));
}

class $TNoteIdxOrderingComposer extends Composer<_$SqliteDb, TNoteIdx> {
  $TNoteIdxOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain,
      builder: (column) => ColumnOrderings(column));
}

class $TNoteIdxAnnotationComposer extends Composer<_$SqliteDb, TNoteIdx> {
  $TNoteIdxAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get contentPlain => $composableBuilder(
      column: $table.contentPlain, builder: (column) => column);
}

class $TNoteIdxTableManager extends RootTableManager<
    _$SqliteDb,
    TNoteIdx,
    TNoteIdxData,
    $TNoteIdxFilterComposer,
    $TNoteIdxOrderingComposer,
    $TNoteIdxAnnotationComposer,
    $TNoteIdxCreateCompanionBuilder,
    $TNoteIdxUpdateCompanionBuilder,
    (TNoteIdxData, BaseReferences<_$SqliteDb, TNoteIdx, TNoteIdxData>),
    TNoteIdxData,
    PrefetchHooks Function()> {
  $TNoteIdxTableManager(_$SqliteDb db, TNoteIdx table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TNoteIdxFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TNoteIdxOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TNoteIdxAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> title = const Value.absent(),
            Value<String> contentPlain = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TNoteIdxCompanion(
            title: title,
            contentPlain: contentPlain,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String title,
            required String contentPlain,
            Value<int> rowid = const Value.absent(),
          }) =>
              TNoteIdxCompanion.insert(
            title: title,
            contentPlain: contentPlain,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $TNoteIdxProcessedTableManager = ProcessedTableManager<
    _$SqliteDb,
    TNoteIdx,
    TNoteIdxData,
    $TNoteIdxFilterComposer,
    $TNoteIdxOrderingComposer,
    $TNoteIdxAnnotationComposer,
    $TNoteIdxCreateCompanionBuilder,
    $TNoteIdxUpdateCompanionBuilder,
    (TNoteIdxData, BaseReferences<_$SqliteDb, TNoteIdx, TNoteIdxData>),
    TNoteIdxData,
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
  $TNoteTableManager get tNote => $TNoteTableManager(_db, _db.tNote);
  $TNoteHistoryTableManager get tNoteHistory =>
      $TNoteHistoryTableManager(_db, _db.tNoteHistory);
  $TNoteIdxTableManager get tNoteIdx =>
      $TNoteIdxTableManager(_db, _db.tNoteIdx);
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

class SelectNotesResult {
  final String id;
  final String classification;
  final String? title;
  final String? abstract;
  final DateTime createdAt;
  final DateTime updatedAt;
  SelectNotesResult({
    required this.id,
    required this.classification,
    this.title,
    this.abstract,
    required this.createdAt,
    required this.updatedAt,
  });
}

typedef SelectNotes$order = OrderBy Function(TNote t_note);

class SearchNotesResult {
  final String id;
  final String? title;
  final String classification;
  final String? abstract;
  final DateTime createdAt;
  final DateTime updatedAt;
  SearchNotesResult({
    required this.id,
    this.title,
    required this.classification,
    this.abstract,
    required this.createdAt,
    required this.updatedAt,
  });
}
