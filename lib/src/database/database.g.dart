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
  static const VerificationMeta _encryptTypeMeta =
      const VerificationMeta('encryptType');
  late final GeneratedColumn<int> encryptType = GeneratedColumn<int>(
      'encrypt_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _encryptArgumentsMeta =
      const VerificationMeta('encryptArguments');
  late final GeneratedColumn<String> encryptArguments = GeneratedColumn<String>(
      'encrypt_arguments', aliasedName, true,
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
      [id, name, encryptType, encryptArguments, createTime, lastUpdateTime];
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
    if (data.containsKey('encrypt_type')) {
      context.handle(
          _encryptTypeMeta,
          encryptType.isAcceptableOrUnknown(
              data['encrypt_type']!, _encryptTypeMeta));
    } else if (isInserting) {
      context.missing(_encryptTypeMeta);
    }
    if (data.containsKey('encrypt_arguments')) {
      context.handle(
          _encryptArgumentsMeta,
          encryptArguments.isAcceptableOrUnknown(
              data['encrypt_arguments']!, _encryptArgumentsMeta));
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
      encryptType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}encrypt_type'])!,
      encryptArguments: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypt_arguments']),
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
  final int encryptType;
  final String? encryptArguments;
  final String createTime;
  final String lastUpdateTime;
  const CategoryEntity(
      {required this.id,
      required this.name,
      required this.encryptType,
      this.encryptArguments,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['encrypt_type'] = Variable<int>(encryptType);
    if (!nullToAbsent || encryptArguments != null) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      encryptType: Value(encryptType),
      encryptArguments: encryptArguments == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptArguments),
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
      encryptType: serializer.fromJson<int>(json['encrypt_type']),
      encryptArguments: serializer.fromJson<String?>(json['encrypt_arguments']),
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
      'encrypt_type': serializer.toJson<int>(encryptType),
      'encrypt_arguments': serializer.toJson<String?>(encryptArguments),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  CategoryEntity copyWith(
          {int? id,
          String? name,
          int? encryptType,
          Value<String?> encryptArguments = const Value.absent(),
          String? createTime,
          String? lastUpdateTime}) =>
      CategoryEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        encryptType: encryptType ?? this.encryptType,
        encryptArguments: encryptArguments.present
            ? encryptArguments.value
            : this.encryptArguments,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, encryptType, encryptArguments, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.encryptType == this.encryptType &&
          other.encryptArguments == this.encryptArguments &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> encryptType;
  final Value<String?> encryptArguments;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.encryptType = const Value.absent(),
    this.encryptArguments = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int encryptType,
    this.encryptArguments = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
  })  : name = Value(name),
        encryptType = Value(encryptType),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<CategoryEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? encryptType,
    Expression<String>? encryptArguments,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (encryptType != null) 'encrypt_type': encryptType,
      if (encryptArguments != null) 'encrypt_arguments': encryptArguments,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? encryptType,
      Value<String?>? encryptArguments,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      encryptType: encryptType ?? this.encryptType,
      encryptArguments: encryptArguments ?? this.encryptArguments,
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
    if (encryptType.present) {
      map['encrypt_type'] = Variable<int>(encryptType.value);
    }
    if (encryptArguments.present) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments.value);
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
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  late final GeneratedColumn<int> format = GeneratedColumn<int>(
      'format', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
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
  static const VerificationMeta _abstractMeta =
      const VerificationMeta('abstract');
  late final GeneratedColumn<String> abstract = GeneratedColumn<String>(
      'abstract', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _weatherMeta =
      const VerificationMeta('weather');
  late final GeneratedColumn<String> weather = GeneratedColumn<String>(
      'weather', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
      'mood', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _encryptTypeMeta =
      const VerificationMeta('encryptType');
  late final GeneratedColumn<int> encryptType = GeneratedColumn<int>(
      'encrypt_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _encryptArgumentsMeta =
      const VerificationMeta('encryptArguments');
  late final GeneratedColumn<String> encryptArguments = GeneratedColumn<String>(
      'encrypt_arguments', aliasedName, true,
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
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        format,
        title,
        content,
        abstract,
        tags,
        location,
        weather,
        mood,
        encryptType,
        encryptArguments,
        createTime,
        lastUpdateTime,
        categoryId
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
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
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
    if (data.containsKey('abstract')) {
      context.handle(_abstractMeta,
          abstract.isAcceptableOrUnknown(data['abstract']!, _abstractMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('weather')) {
      context.handle(_weatherMeta,
          weather.isAcceptableOrUnknown(data['weather']!, _weatherMeta));
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('encrypt_type')) {
      context.handle(
          _encryptTypeMeta,
          encryptType.isAcceptableOrUnknown(
              data['encrypt_type']!, _encryptTypeMeta));
    } else if (isInserting) {
      context.missing(_encryptTypeMeta);
    }
    if (data.containsKey('encrypt_arguments')) {
      context.handle(
          _encryptArgumentsMeta,
          encryptArguments.isAcceptableOrUnknown(
              data['encrypt_arguments']!, _encryptArgumentsMeta));
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
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
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
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}format'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      abstract: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abstract']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      weather: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weather']),
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood']),
      encryptType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}encrypt_type'])!,
      encryptArguments: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypt_arguments']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
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
  final int id;
  final int type;
  final int format;
  final String title;
  final String content;
  final String? abstract;
  final String? tags;
  final String? location;
  final String? weather;
  final String? mood;
  final int encryptType;
  final String? encryptArguments;
  final String createTime;
  final String lastUpdateTime;
  final int? categoryId;
  const NoteEntity(
      {required this.id,
      required this.type,
      required this.format,
      required this.title,
      required this.content,
      this.abstract,
      this.tags,
      this.location,
      this.weather,
      this.mood,
      required this.encryptType,
      this.encryptArguments,
      required this.createTime,
      required this.lastUpdateTime,
      this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<int>(type);
    map['format'] = Variable<int>(format);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || abstract != null) {
      map['abstract'] = Variable<String>(abstract);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || weather != null) {
      map['weather'] = Variable<String>(weather);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    map['encrypt_type'] = Variable<int>(encryptType);
    if (!nullToAbsent || encryptArguments != null) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      type: Value(type),
      format: Value(format),
      title: Value(title),
      content: Value(content),
      abstract: abstract == null && nullToAbsent
          ? const Value.absent()
          : Value(abstract),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      weather: weather == null && nullToAbsent
          ? const Value.absent()
          : Value(weather),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      encryptType: Value(encryptType),
      encryptArguments: encryptArguments == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptArguments),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
    );
  }

  factory NoteEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteEntity(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      format: serializer.fromJson<int>(json['format']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      abstract: serializer.fromJson<String?>(json['abstract']),
      tags: serializer.fromJson<String?>(json['tags']),
      location: serializer.fromJson<String?>(json['location']),
      weather: serializer.fromJson<String?>(json['weather']),
      mood: serializer.fromJson<String?>(json['mood']),
      encryptType: serializer.fromJson<int>(json['encrypt_type']),
      encryptArguments: serializer.fromJson<String?>(json['encrypt_arguments']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
      categoryId: serializer.fromJson<int?>(json['category_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(type),
      'format': serializer.toJson<int>(format),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'abstract': serializer.toJson<String?>(abstract),
      'tags': serializer.toJson<String?>(tags),
      'location': serializer.toJson<String?>(location),
      'weather': serializer.toJson<String?>(weather),
      'mood': serializer.toJson<String?>(mood),
      'encrypt_type': serializer.toJson<int>(encryptType),
      'encrypt_arguments': serializer.toJson<String?>(encryptArguments),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
      'category_id': serializer.toJson<int?>(categoryId),
    };
  }

  NoteEntity copyWith(
          {int? id,
          int? type,
          int? format,
          String? title,
          String? content,
          Value<String?> abstract = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> weather = const Value.absent(),
          Value<String?> mood = const Value.absent(),
          int? encryptType,
          Value<String?> encryptArguments = const Value.absent(),
          String? createTime,
          String? lastUpdateTime,
          Value<int?> categoryId = const Value.absent()}) =>
      NoteEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        format: format ?? this.format,
        title: title ?? this.title,
        content: content ?? this.content,
        abstract: abstract.present ? abstract.value : this.abstract,
        tags: tags.present ? tags.value : this.tags,
        location: location.present ? location.value : this.location,
        weather: weather.present ? weather.value : this.weather,
        mood: mood.present ? mood.value : this.mood,
        encryptType: encryptType ?? this.encryptType,
        encryptArguments: encryptArguments.present
            ? encryptArguments.value
            : this.encryptArguments,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
      );
  @override
  String toString() {
    return (StringBuffer('NoteEntity(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('format: $format, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('abstract: $abstract, ')
          ..write('tags: $tags, ')
          ..write('location: $location, ')
          ..write('weather: $weather, ')
          ..write('mood: $mood, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      format,
      title,
      content,
      abstract,
      tags,
      location,
      weather,
      mood,
      encryptType,
      encryptArguments,
      createTime,
      lastUpdateTime,
      categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteEntity &&
          other.id == this.id &&
          other.type == this.type &&
          other.format == this.format &&
          other.title == this.title &&
          other.content == this.content &&
          other.abstract == this.abstract &&
          other.tags == this.tags &&
          other.location == this.location &&
          other.weather == this.weather &&
          other.mood == this.mood &&
          other.encryptType == this.encryptType &&
          other.encryptArguments == this.encryptArguments &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.categoryId == this.categoryId);
}

class NotesCompanion extends UpdateCompanion<NoteEntity> {
  final Value<int> id;
  final Value<int> type;
  final Value<int> format;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> abstract;
  final Value<String?> tags;
  final Value<String?> location;
  final Value<String?> weather;
  final Value<String?> mood;
  final Value<int> encryptType;
  final Value<String?> encryptArguments;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  final Value<int?> categoryId;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.format = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.abstract = const Value.absent(),
    this.tags = const Value.absent(),
    this.location = const Value.absent(),
    this.weather = const Value.absent(),
    this.mood = const Value.absent(),
    this.encryptType = const Value.absent(),
    this.encryptArguments = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required int type,
    required int format,
    required String title,
    required String content,
    this.abstract = const Value.absent(),
    this.tags = const Value.absent(),
    this.location = const Value.absent(),
    this.weather = const Value.absent(),
    this.mood = const Value.absent(),
    required int encryptType,
    this.encryptArguments = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
    this.categoryId = const Value.absent(),
  })  : type = Value(type),
        format = Value(format),
        title = Value(title),
        content = Value(content),
        encryptType = Value(encryptType),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<NoteEntity> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<int>? format,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? abstract,
    Expression<String>? tags,
    Expression<String>? location,
    Expression<String>? weather,
    Expression<String>? mood,
    Expression<int>? encryptType,
    Expression<String>? encryptArguments,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (format != null) 'format': format,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (abstract != null) 'abstract': abstract,
      if (tags != null) 'tags': tags,
      if (location != null) 'location': location,
      if (weather != null) 'weather': weather,
      if (mood != null) 'mood': mood,
      if (encryptType != null) 'encrypt_type': encryptType,
      if (encryptArguments != null) 'encrypt_arguments': encryptArguments,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? type,
      Value<int>? format,
      Value<String>? title,
      Value<String>? content,
      Value<String?>? abstract,
      Value<String?>? tags,
      Value<String?>? location,
      Value<String?>? weather,
      Value<String?>? mood,
      Value<int>? encryptType,
      Value<String?>? encryptArguments,
      Value<String>? createTime,
      Value<String>? lastUpdateTime,
      Value<int?>? categoryId}) {
    return NotesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      format: format ?? this.format,
      title: title ?? this.title,
      content: content ?? this.content,
      abstract: abstract ?? this.abstract,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      weather: weather ?? this.weather,
      mood: mood ?? this.mood,
      encryptType: encryptType ?? this.encryptType,
      encryptArguments: encryptArguments ?? this.encryptArguments,
      createTime: createTime ?? this.createTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (format.present) {
      map['format'] = Variable<int>(format.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (abstract.present) {
      map['abstract'] = Variable<String>(abstract.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (weather.present) {
      map['weather'] = Variable<String>(weather.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (encryptType.present) {
      map['encrypt_type'] = Variable<int>(encryptType.value);
    }
    if (encryptArguments.present) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<String>(createTime.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<String>(lastUpdateTime.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('format: $format, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('abstract: $abstract, ')
          ..write('tags: $tags, ')
          ..write('location: $location, ')
          ..write('weather: $weather, ')
          ..write('mood: $mood, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class Files extends Table with TableInfo<Files, FileEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Files(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _thumbnailPathMeta =
      const VerificationMeta('thumbnailPath');
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
      'thumbnail_path', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _checksumMeta =
      const VerificationMeta('checksum');
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
      'checksum', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _encryptTypeMeta =
      const VerificationMeta('encryptType');
  late final GeneratedColumn<int> encryptType = GeneratedColumn<int>(
      'encrypt_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _encryptArgumentsMeta =
      const VerificationMeta('encryptArguments');
  late final GeneratedColumn<String> encryptArguments = GeneratedColumn<String>(
      'encrypt_arguments', aliasedName, true,
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
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
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
  List<GeneratedColumn> get $columns => [
        id,
        type,
        name,
        path,
        thumbnailPath,
        format,
        checksum,
        encryptType,
        encryptArguments,
        remark,
        categoryId,
        createTime,
        lastUpdateTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'files';
  @override
  VerificationContext validateIntegrity(Insertable<FileEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
          _thumbnailPathMeta,
          thumbnailPath.isAcceptableOrUnknown(
              data['thumbnail_path']!, _thumbnailPathMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('checksum')) {
      context.handle(_checksumMeta,
          checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta));
    }
    if (data.containsKey('encrypt_type')) {
      context.handle(
          _encryptTypeMeta,
          encryptType.isAcceptableOrUnknown(
              data['encrypt_type']!, _encryptTypeMeta));
    } else if (isInserting) {
      context.missing(_encryptTypeMeta);
    }
    if (data.containsKey('encrypt_arguments')) {
      context.handle(
          _encryptArgumentsMeta,
          encryptArguments.isAcceptableOrUnknown(
              data['encrypt_arguments']!, _encryptArgumentsMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      thumbnailPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_path']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      checksum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checksum']),
      encryptType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}encrypt_type'])!,
      encryptArguments: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypt_arguments']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  Files createAlias(String alias) {
    return Files(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(category_id)REFERENCES categories(id)'];
  @override
  bool get dontWriteConstraints => true;
}

class FileEntity extends DataClass implements Insertable<FileEntity> {
  final int id;
  final int type;
  final String name;
  final String path;
  final String? thumbnailPath;
  final String format;
  final String? checksum;
  final int encryptType;
  final String? encryptArguments;
  final String? remark;
  final int? categoryId;
  final String createTime;
  final String lastUpdateTime;
  const FileEntity(
      {required this.id,
      required this.type,
      required this.name,
      required this.path,
      this.thumbnailPath,
      required this.format,
      this.checksum,
      required this.encryptType,
      this.encryptArguments,
      this.remark,
      this.categoryId,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<int>(type);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    map['format'] = Variable<String>(format);
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    map['encrypt_type'] = Variable<int>(encryptType);
    if (!nullToAbsent || encryptArguments != null) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  FilesCompanion toCompanion(bool nullToAbsent) {
    return FilesCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      path: Value(path),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      format: Value(format),
      checksum: checksum == null && nullToAbsent
          ? const Value.absent()
          : Value(checksum),
      encryptType: Value(encryptType),
      encryptArguments: encryptArguments == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptArguments),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory FileEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileEntity(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<int>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnail_path']),
      format: serializer.fromJson<String>(json['format']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      encryptType: serializer.fromJson<int>(json['encrypt_type']),
      encryptArguments: serializer.fromJson<String?>(json['encrypt_arguments']),
      remark: serializer.fromJson<String?>(json['remark']),
      categoryId: serializer.fromJson<int?>(json['category_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(type),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'thumbnail_path': serializer.toJson<String?>(thumbnailPath),
      'format': serializer.toJson<String>(format),
      'checksum': serializer.toJson<String?>(checksum),
      'encrypt_type': serializer.toJson<int>(encryptType),
      'encrypt_arguments': serializer.toJson<String?>(encryptArguments),
      'remark': serializer.toJson<String?>(remark),
      'category_id': serializer.toJson<int?>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  FileEntity copyWith(
          {int? id,
          int? type,
          String? name,
          String? path,
          Value<String?> thumbnailPath = const Value.absent(),
          String? format,
          Value<String?> checksum = const Value.absent(),
          int? encryptType,
          Value<String?> encryptArguments = const Value.absent(),
          Value<String?> remark = const Value.absent(),
          Value<int?> categoryId = const Value.absent(),
          String? createTime,
          String? lastUpdateTime}) =>
      FileEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        path: path ?? this.path,
        thumbnailPath:
            thumbnailPath.present ? thumbnailPath.value : this.thumbnailPath,
        format: format ?? this.format,
        checksum: checksum.present ? checksum.value : this.checksum,
        encryptType: encryptType ?? this.encryptType,
        encryptArguments: encryptArguments.present
            ? encryptArguments.value
            : this.encryptArguments,
        remark: remark.present ? remark.value : this.remark,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('FileEntity(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('format: $format, ')
          ..write('checksum: $checksum, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      name,
      path,
      thumbnailPath,
      format,
      checksum,
      encryptType,
      encryptArguments,
      remark,
      categoryId,
      createTime,
      lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileEntity &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.path == this.path &&
          other.thumbnailPath == this.thumbnailPath &&
          other.format == this.format &&
          other.checksum == this.checksum &&
          other.encryptType == this.encryptType &&
          other.encryptArguments == this.encryptArguments &&
          other.remark == this.remark &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class FilesCompanion extends UpdateCompanion<FileEntity> {
  final Value<int> id;
  final Value<int> type;
  final Value<String> name;
  final Value<String> path;
  final Value<String?> thumbnailPath;
  final Value<String> format;
  final Value<String?> checksum;
  final Value<int> encryptType;
  final Value<String?> encryptArguments;
  final Value<String?> remark;
  final Value<int?> categoryId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const FilesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.format = const Value.absent(),
    this.checksum = const Value.absent(),
    this.encryptType = const Value.absent(),
    this.encryptArguments = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  FilesCompanion.insert({
    this.id = const Value.absent(),
    required int type,
    required String name,
    required String path,
    this.thumbnailPath = const Value.absent(),
    required String format,
    this.checksum = const Value.absent(),
    required int encryptType,
    this.encryptArguments = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
  })  : type = Value(type),
        name = Value(name),
        path = Value(path),
        format = Value(format),
        encryptType = Value(encryptType),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<FileEntity> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<String>? name,
    Expression<String>? path,
    Expression<String>? thumbnailPath,
    Expression<String>? format,
    Expression<String>? checksum,
    Expression<int>? encryptType,
    Expression<String>? encryptArguments,
    Expression<String>? remark,
    Expression<int>? categoryId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (format != null) 'format': format,
      if (checksum != null) 'checksum': checksum,
      if (encryptType != null) 'encrypt_type': encryptType,
      if (encryptArguments != null) 'encrypt_arguments': encryptArguments,
      if (remark != null) 'remark': remark,
      if (categoryId != null) 'category_id': categoryId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  FilesCompanion copyWith(
      {Value<int>? id,
      Value<int>? type,
      Value<String>? name,
      Value<String>? path,
      Value<String?>? thumbnailPath,
      Value<String>? format,
      Value<String?>? checksum,
      Value<int>? encryptType,
      Value<String?>? encryptArguments,
      Value<String?>? remark,
      Value<int?>? categoryId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return FilesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      path: path ?? this.path,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      format: format ?? this.format,
      checksum: checksum ?? this.checksum,
      encryptType: encryptType ?? this.encryptType,
      encryptArguments: encryptArguments ?? this.encryptArguments,
      remark: remark ?? this.remark,
      categoryId: categoryId ?? this.categoryId,
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
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (encryptType.present) {
      map['encrypt_type'] = Variable<int>(encryptType.value);
    }
    if (encryptArguments.present) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('format: $format, ')
          ..write('checksum: $checksum, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class NoteFiles extends Table with TableInfo<NoteFiles, NoteFileEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NoteFiles(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  late final GeneratedColumn<int> fileId = GeneratedColumn<int>(
      'file_id', aliasedName, false,
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
      [id, noteId, fileId, createTime, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_files';
  @override
  VerificationContext validateIntegrity(Insertable<NoteFileEntity> instance,
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
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
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
  NoteFileEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteFileEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_id'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  NoteFiles createAlias(String alias) {
    return NoteFiles(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(note_id)REFERENCES notes(id)',
        'FOREIGN KEY(file_id)REFERENCES files(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class NoteFileEntity extends DataClass implements Insertable<NoteFileEntity> {
  final int id;
  final int noteId;
  final int fileId;
  final String createTime;
  final String lastUpdateTime;
  const NoteFileEntity(
      {required this.id,
      required this.noteId,
      required this.fileId,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<int>(noteId);
    map['file_id'] = Variable<int>(fileId);
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  NoteFilesCompanion toCompanion(bool nullToAbsent) {
    return NoteFilesCompanion(
      id: Value(id),
      noteId: Value(noteId),
      fileId: Value(fileId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory NoteFileEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteFileEntity(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<int>(json['note_id']),
      fileId: serializer.fromJson<int>(json['file_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'note_id': serializer.toJson<int>(noteId),
      'file_id': serializer.toJson<int>(fileId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  NoteFileEntity copyWith(
          {int? id,
          int? noteId,
          int? fileId,
          String? createTime,
          String? lastUpdateTime}) =>
      NoteFileEntity(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        fileId: fileId ?? this.fileId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('NoteFileEntity(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('fileId: $fileId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noteId, fileId, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteFileEntity &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.fileId == this.fileId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class NoteFilesCompanion extends UpdateCompanion<NoteFileEntity> {
  final Value<int> id;
  final Value<int> noteId;
  final Value<int> fileId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const NoteFilesCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.fileId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  NoteFilesCompanion.insert({
    this.id = const Value.absent(),
    required int noteId,
    required int fileId,
    required String createTime,
    required String lastUpdateTime,
  })  : noteId = Value(noteId),
        fileId = Value(fileId),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<NoteFileEntity> custom({
    Expression<int>? id,
    Expression<int>? noteId,
    Expression<int>? fileId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (fileId != null) 'file_id': fileId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  NoteFilesCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteId,
      Value<int>? fileId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return NoteFilesCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      fileId: fileId ?? this.fileId,
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
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<int>(fileId.value);
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
    return (StringBuffer('NoteFilesCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('fileId: $fileId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class Checklists extends Table with TableInfo<Checklists, ChecklistEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Checklists(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  late final GeneratedColumn<String> deadline = GeneratedColumn<String>(
      'deadline', aliasedName, true,
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
      [id, name, status, deadline, createTime, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklists';
  @override
  VerificationContext validateIntegrity(Insertable<ChecklistEntity> instance,
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
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
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
  ChecklistEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deadline']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  Checklists createAlias(String alias) {
    return Checklists(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ChecklistEntity extends DataClass implements Insertable<ChecklistEntity> {
  final int id;
  final String name;
  final int status;
  final String? deadline;
  final String createTime;
  final String lastUpdateTime;
  const ChecklistEntity(
      {required this.id,
      required this.name,
      required this.status,
      this.deadline,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<int>(status);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<String>(deadline);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  ChecklistsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistsCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory ChecklistEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<int>(json['status']),
      deadline: serializer.fromJson<String?>(json['deadline']),
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
      'status': serializer.toJson<int>(status),
      'deadline': serializer.toJson<String?>(deadline),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  ChecklistEntity copyWith(
          {int? id,
          String? name,
          int? status,
          Value<String?> deadline = const Value.absent(),
          String? createTime,
          String? lastUpdateTime}) =>
      ChecklistEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        deadline: deadline.present ? deadline.value : this.deadline,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('ChecklistEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('deadline: $deadline, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, status, deadline, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.deadline == this.deadline &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class ChecklistsCompanion extends UpdateCompanion<ChecklistEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> status;
  final Value<String?> deadline;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const ChecklistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.deadline = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  ChecklistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int status,
    this.deadline = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
  })  : name = Value(name),
        status = Value(status),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<ChecklistEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? status,
    Expression<String>? deadline,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (deadline != null) 'deadline': deadline,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  ChecklistsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? status,
      Value<String?>? deadline,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return ChecklistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
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
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<String>(deadline.value);
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
    return (StringBuffer('ChecklistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('deadline: $deadline, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

class NoteChecklists extends Table
    with TableInfo<NoteChecklists, NoteChecklistEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NoteChecklists(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _checklistIdMeta =
      const VerificationMeta('checklistId');
  late final GeneratedColumn<int> checklistId = GeneratedColumn<int>(
      'checklist_id', aliasedName, false,
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
      [id, noteId, checklistId, createTime, lastUpdateTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_checklists';
  @override
  VerificationContext validateIntegrity(
      Insertable<NoteChecklistEntity> instance,
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
    if (data.containsKey('checklist_id')) {
      context.handle(
          _checklistIdMeta,
          checklistId.isAcceptableOrUnknown(
              data['checklist_id']!, _checklistIdMeta));
    } else if (isInserting) {
      context.missing(_checklistIdMeta);
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
  NoteChecklistEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteChecklistEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      noteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}note_id'])!,
      checklistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}checklist_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
    );
  }

  @override
  NoteChecklists createAlias(String alias) {
    return NoteChecklists(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(note_id)REFERENCES notes(id)',
        'FOREIGN KEY(checklist_id)REFERENCES checklists(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class NoteChecklistEntity extends DataClass
    implements Insertable<NoteChecklistEntity> {
  final int id;
  final int noteId;
  final int checklistId;
  final String createTime;
  final String lastUpdateTime;
  const NoteChecklistEntity(
      {required this.id,
      required this.noteId,
      required this.checklistId,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['note_id'] = Variable<int>(noteId);
    map['checklist_id'] = Variable<int>(checklistId);
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  NoteChecklistsCompanion toCompanion(bool nullToAbsent) {
    return NoteChecklistsCompanion(
      id: Value(id),
      noteId: Value(noteId),
      checklistId: Value(checklistId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory NoteChecklistEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteChecklistEntity(
      id: serializer.fromJson<int>(json['id']),
      noteId: serializer.fromJson<int>(json['note_id']),
      checklistId: serializer.fromJson<int>(json['checklist_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'note_id': serializer.toJson<int>(noteId),
      'checklist_id': serializer.toJson<int>(checklistId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  NoteChecklistEntity copyWith(
          {int? id,
          int? noteId,
          int? checklistId,
          String? createTime,
          String? lastUpdateTime}) =>
      NoteChecklistEntity(
        id: id ?? this.id,
        noteId: noteId ?? this.noteId,
        checklistId: checklistId ?? this.checklistId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('NoteChecklistEntity(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('checklistId: $checklistId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, noteId, checklistId, createTime, lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteChecklistEntity &&
          other.id == this.id &&
          other.noteId == this.noteId &&
          other.checklistId == this.checklistId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class NoteChecklistsCompanion extends UpdateCompanion<NoteChecklistEntity> {
  final Value<int> id;
  final Value<int> noteId;
  final Value<int> checklistId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const NoteChecklistsCompanion({
    this.id = const Value.absent(),
    this.noteId = const Value.absent(),
    this.checklistId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  NoteChecklistsCompanion.insert({
    this.id = const Value.absent(),
    required int noteId,
    required int checklistId,
    required String createTime,
    required String lastUpdateTime,
  })  : noteId = Value(noteId),
        checklistId = Value(checklistId),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<NoteChecklistEntity> custom({
    Expression<int>? id,
    Expression<int>? noteId,
    Expression<int>? checklistId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (noteId != null) 'note_id': noteId,
      if (checklistId != null) 'checklist_id': checklistId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  NoteChecklistsCompanion copyWith(
      {Value<int>? id,
      Value<int>? noteId,
      Value<int>? checklistId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return NoteChecklistsCompanion(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      checklistId: checklistId ?? this.checklistId,
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
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (checklistId.present) {
      map['checklist_id'] = Variable<int>(checklistId.value);
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
    return (StringBuffer('NoteChecklistsCompanion(')
          ..write('id: $id, ')
          ..write('noteId: $noteId, ')
          ..write('checklistId: $checklistId, ')
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
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
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
      'tip', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _expireTimeMeta =
      const VerificationMeta('expireTime');
  late final GeneratedColumn<String> expireTime = GeneratedColumn<String>(
      'expire_time', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _encryptTypeMeta =
      const VerificationMeta('encryptType');
  late final GeneratedColumn<int> encryptType = GeneratedColumn<int>(
      'encrypt_type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _encryptArgumentsMeta =
      const VerificationMeta('encryptArguments');
  late final GeneratedColumn<String> encryptArguments = GeneratedColumn<String>(
      'encrypt_arguments', aliasedName, true,
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
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
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
  List<GeneratedColumn> get $columns => [
        id,
        title,
        url,
        username,
        tip,
        email,
        expireTime,
        value,
        encryptType,
        encryptArguments,
        remark,
        categoryId,
        createTime,
        lastUpdateTime
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
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('tip')) {
      context.handle(
          _tipMeta, tip.isAcceptableOrUnknown(data['tip']!, _tipMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('expire_time')) {
      context.handle(
          _expireTimeMeta,
          expireTime.isAcceptableOrUnknown(
              data['expire_time']!, _expireTimeMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('encrypt_type')) {
      context.handle(
          _encryptTypeMeta,
          encryptType.isAcceptableOrUnknown(
              data['encrypt_type']!, _encryptTypeMeta));
    } else if (isInserting) {
      context.missing(_encryptTypeMeta);
    }
    if (data.containsKey('encrypt_arguments')) {
      context.handle(
          _encryptArgumentsMeta,
          encryptArguments.isAcceptableOrUnknown(
              data['encrypt_arguments']!, _encryptArgumentsMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PasswordEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PasswordEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      tip: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tip']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      expireTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expire_time']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      encryptType: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}encrypt_type'])!,
      encryptArguments: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypt_arguments']),
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_time'])!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_update_time'])!,
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
  final int id;
  final String title;
  final String? url;
  final String? username;
  final String? tip;
  final String? email;
  final String? expireTime;
  final String value;
  final int encryptType;
  final String? encryptArguments;
  final String? remark;
  final int? categoryId;
  final String createTime;
  final String lastUpdateTime;
  const PasswordEntity(
      {required this.id,
      required this.title,
      this.url,
      this.username,
      this.tip,
      this.email,
      this.expireTime,
      required this.value,
      required this.encryptType,
      this.encryptArguments,
      this.remark,
      this.categoryId,
      required this.createTime,
      required this.lastUpdateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || tip != null) {
      map['tip'] = Variable<String>(tip);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || expireTime != null) {
      map['expire_time'] = Variable<String>(expireTime);
    }
    map['value'] = Variable<String>(value);
    map['encrypt_type'] = Variable<int>(encryptType);
    if (!nullToAbsent || encryptArguments != null) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments);
    }
    if (!nullToAbsent || remark != null) {
      map['remark'] = Variable<String>(remark);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['create_time'] = Variable<String>(createTime);
    map['last_update_time'] = Variable<String>(lastUpdateTime);
    return map;
  }

  PasswordsCompanion toCompanion(bool nullToAbsent) {
    return PasswordsCompanion(
      id: Value(id),
      title: Value(title),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      tip: tip == null && nullToAbsent ? const Value.absent() : Value(tip),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      expireTime: expireTime == null && nullToAbsent
          ? const Value.absent()
          : Value(expireTime),
      value: Value(value),
      encryptType: Value(encryptType),
      encryptArguments: encryptArguments == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptArguments),
      remark:
          remark == null && nullToAbsent ? const Value.absent() : Value(remark),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      createTime: Value(createTime),
      lastUpdateTime: Value(lastUpdateTime),
    );
  }

  factory PasswordEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PasswordEntity(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      url: serializer.fromJson<String?>(json['url']),
      username: serializer.fromJson<String?>(json['username']),
      tip: serializer.fromJson<String?>(json['tip']),
      email: serializer.fromJson<String?>(json['email']),
      expireTime: serializer.fromJson<String?>(json['expire_time']),
      value: serializer.fromJson<String>(json['value']),
      encryptType: serializer.fromJson<int>(json['encrypt_type']),
      encryptArguments: serializer.fromJson<String?>(json['encrypt_arguments']),
      remark: serializer.fromJson<String?>(json['remark']),
      categoryId: serializer.fromJson<int?>(json['category_id']),
      createTime: serializer.fromJson<String>(json['create_time']),
      lastUpdateTime: serializer.fromJson<String>(json['last_update_time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'url': serializer.toJson<String?>(url),
      'username': serializer.toJson<String?>(username),
      'tip': serializer.toJson<String?>(tip),
      'email': serializer.toJson<String?>(email),
      'expire_time': serializer.toJson<String?>(expireTime),
      'value': serializer.toJson<String>(value),
      'encrypt_type': serializer.toJson<int>(encryptType),
      'encrypt_arguments': serializer.toJson<String?>(encryptArguments),
      'remark': serializer.toJson<String?>(remark),
      'category_id': serializer.toJson<int?>(categoryId),
      'create_time': serializer.toJson<String>(createTime),
      'last_update_time': serializer.toJson<String>(lastUpdateTime),
    };
  }

  PasswordEntity copyWith(
          {int? id,
          String? title,
          Value<String?> url = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> tip = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> expireTime = const Value.absent(),
          String? value,
          int? encryptType,
          Value<String?> encryptArguments = const Value.absent(),
          Value<String?> remark = const Value.absent(),
          Value<int?> categoryId = const Value.absent(),
          String? createTime,
          String? lastUpdateTime}) =>
      PasswordEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url.present ? url.value : this.url,
        username: username.present ? username.value : this.username,
        tip: tip.present ? tip.value : this.tip,
        email: email.present ? email.value : this.email,
        expireTime: expireTime.present ? expireTime.value : this.expireTime,
        value: value ?? this.value,
        encryptType: encryptType ?? this.encryptType,
        encryptArguments: encryptArguments.present
            ? encryptArguments.value
            : this.encryptArguments,
        remark: remark.present ? remark.value : this.remark,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        createTime: createTime ?? this.createTime,
        lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      );
  @override
  String toString() {
    return (StringBuffer('PasswordEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('username: $username, ')
          ..write('tip: $tip, ')
          ..write('email: $email, ')
          ..write('expireTime: $expireTime, ')
          ..write('value: $value, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      url,
      username,
      tip,
      email,
      expireTime,
      value,
      encryptType,
      encryptArguments,
      remark,
      categoryId,
      createTime,
      lastUpdateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.url == this.url &&
          other.username == this.username &&
          other.tip == this.tip &&
          other.email == this.email &&
          other.expireTime == this.expireTime &&
          other.value == this.value &&
          other.encryptType == this.encryptType &&
          other.encryptArguments == this.encryptArguments &&
          other.remark == this.remark &&
          other.categoryId == this.categoryId &&
          other.createTime == this.createTime &&
          other.lastUpdateTime == this.lastUpdateTime);
}

class PasswordsCompanion extends UpdateCompanion<PasswordEntity> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> url;
  final Value<String?> username;
  final Value<String?> tip;
  final Value<String?> email;
  final Value<String?> expireTime;
  final Value<String> value;
  final Value<int> encryptType;
  final Value<String?> encryptArguments;
  final Value<String?> remark;
  final Value<int?> categoryId;
  final Value<String> createTime;
  final Value<String> lastUpdateTime;
  const PasswordsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.username = const Value.absent(),
    this.tip = const Value.absent(),
    this.email = const Value.absent(),
    this.expireTime = const Value.absent(),
    this.value = const Value.absent(),
    this.encryptType = const Value.absent(),
    this.encryptArguments = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
  });
  PasswordsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.url = const Value.absent(),
    this.username = const Value.absent(),
    this.tip = const Value.absent(),
    this.email = const Value.absent(),
    this.expireTime = const Value.absent(),
    required String value,
    required int encryptType,
    this.encryptArguments = const Value.absent(),
    this.remark = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String createTime,
    required String lastUpdateTime,
  })  : title = Value(title),
        value = Value(value),
        encryptType = Value(encryptType),
        createTime = Value(createTime),
        lastUpdateTime = Value(lastUpdateTime);
  static Insertable<PasswordEntity> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<String>? username,
    Expression<String>? tip,
    Expression<String>? email,
    Expression<String>? expireTime,
    Expression<String>? value,
    Expression<int>? encryptType,
    Expression<String>? encryptArguments,
    Expression<String>? remark,
    Expression<int>? categoryId,
    Expression<String>? createTime,
    Expression<String>? lastUpdateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (username != null) 'username': username,
      if (tip != null) 'tip': tip,
      if (email != null) 'email': email,
      if (expireTime != null) 'expire_time': expireTime,
      if (value != null) 'value': value,
      if (encryptType != null) 'encrypt_type': encryptType,
      if (encryptArguments != null) 'encrypt_arguments': encryptArguments,
      if (remark != null) 'remark': remark,
      if (categoryId != null) 'category_id': categoryId,
      if (createTime != null) 'create_time': createTime,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
    });
  }

  PasswordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? url,
      Value<String?>? username,
      Value<String?>? tip,
      Value<String?>? email,
      Value<String?>? expireTime,
      Value<String>? value,
      Value<int>? encryptType,
      Value<String?>? encryptArguments,
      Value<String?>? remark,
      Value<int?>? categoryId,
      Value<String>? createTime,
      Value<String>? lastUpdateTime}) {
    return PasswordsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      username: username ?? this.username,
      tip: tip ?? this.tip,
      email: email ?? this.email,
      expireTime: expireTime ?? this.expireTime,
      value: value ?? this.value,
      encryptType: encryptType ?? this.encryptType,
      encryptArguments: encryptArguments ?? this.encryptArguments,
      remark: remark ?? this.remark,
      categoryId: categoryId ?? this.categoryId,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (expireTime.present) {
      map['expire_time'] = Variable<String>(expireTime.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (encryptType.present) {
      map['encrypt_type'] = Variable<int>(encryptType.value);
    }
    if (encryptArguments.present) {
      map['encrypt_arguments'] = Variable<String>(encryptArguments.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PasswordsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('username: $username, ')
          ..write('tip: $tip, ')
          ..write('email: $email, ')
          ..write('expireTime: $expireTime, ')
          ..write('value: $value, ')
          ..write('encryptType: $encryptType, ')
          ..write('encryptArguments: $encryptArguments, ')
          ..write('remark: $remark, ')
          ..write('categoryId: $categoryId, ')
          ..write('createTime: $createTime, ')
          ..write('lastUpdateTime: $lastUpdateTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final Categories categories = Categories(this);
  late final Notes notes = Notes(this);
  late final Files files = Files(this);
  late final NoteFiles noteFiles = NoteFiles(this);
  late final Checklists checklists = Checklists(this);
  late final NoteChecklists noteChecklists = NoteChecklists(this);
  late final Passwords passwords = Passwords(this);
  Selectable<FetchNoteBasicsResult> fetchNoteBasics() {
    return customSelect(
        'SELECT id, type, format, title, abstract, tags, location, mood, encrypt_type, category_id, create_time, last_update_time FROM notes ORDER BY id DESC',
        variables: [],
        readsFrom: {
          notes,
        }).map((QueryRow row) => FetchNoteBasicsResult(
          id: row.read<int>('id'),
          type: row.read<int>('type'),
          format: row.read<int>('format'),
          title: row.read<String>('title'),
          abstract: row.readNullable<String>('abstract'),
          tags: row.readNullable<String>('tags'),
          location: row.readNullable<String>('location'),
          mood: row.readNullable<String>('mood'),
          encryptType: row.read<int>('encrypt_type'),
          categoryId: row.readNullable<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<FetchNoteBasicsByTypeResult> fetchNoteBasicsByType(int var1) {
    return customSelect(
        'SELECT id, type, format, title, abstract, tags, location, mood, encrypt_type, category_id, create_time, last_update_time FROM notes WHERE type = ?1 ORDER BY id DESC',
        variables: [
          Variable<int>(var1)
        ],
        readsFrom: {
          notes,
        }).map((QueryRow row) => FetchNoteBasicsByTypeResult(
          id: row.read<int>('id'),
          type: row.read<int>('type'),
          format: row.read<int>('format'),
          title: row.read<String>('title'),
          abstract: row.readNullable<String>('abstract'),
          tags: row.readNullable<String>('tags'),
          location: row.readNullable<String>('location'),
          mood: row.readNullable<String>('mood'),
          encryptType: row.read<int>('encrypt_type'),
          categoryId: row.readNullable<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  Selectable<FetchPasswordBasicsResult> fetchPasswordBasics() {
    return customSelect(
        'SELECT id, title, expire_time, remark, encrypt_type, category_id, create_time, last_update_time FROM passwords ORDER BY id DESC',
        variables: [],
        readsFrom: {
          passwords,
        }).map((QueryRow row) => FetchPasswordBasicsResult(
          id: row.read<int>('id'),
          title: row.read<String>('title'),
          expireTime: row.readNullable<String>('expire_time'),
          remark: row.readNullable<String>('remark'),
          encryptType: row.read<int>('encrypt_type'),
          categoryId: row.readNullable<int>('category_id'),
          createTime: row.read<String>('create_time'),
          lastUpdateTime: row.read<String>('last_update_time'),
        ));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        categories,
        notes,
        files,
        noteFiles,
        checklists,
        noteChecklists,
        passwords
      ];
}

class FetchNoteBasicsResult {
  final int id;
  final int type;
  final int format;
  final String title;
  final String? abstract;
  final String? tags;
  final String? location;
  final String? mood;
  final int encryptType;
  final int? categoryId;
  final String createTime;
  final String lastUpdateTime;
  FetchNoteBasicsResult({
    required this.id,
    required this.type,
    required this.format,
    required this.title,
    this.abstract,
    this.tags,
    this.location,
    this.mood,
    required this.encryptType,
    this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class FetchNoteBasicsByTypeResult {
  final int id;
  final int type;
  final int format;
  final String title;
  final String? abstract;
  final String? tags;
  final String? location;
  final String? mood;
  final int encryptType;
  final int? categoryId;
  final String createTime;
  final String lastUpdateTime;
  FetchNoteBasicsByTypeResult({
    required this.id,
    required this.type,
    required this.format,
    required this.title,
    this.abstract,
    this.tags,
    this.location,
    this.mood,
    required this.encryptType,
    this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class FetchPasswordBasicsResult {
  final int id;
  final String title;
  final String? expireTime;
  final String? remark;
  final int encryptType;
  final int? categoryId;
  final String createTime;
  final String lastUpdateTime;
  FetchPasswordBasicsResult({
    required this.id,
    required this.title,
    this.expireTime,
    this.remark,
    required this.encryptType,
    this.categoryId,
    required this.createTime,
    required this.lastUpdateTime,
  });
}
