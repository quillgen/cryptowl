import 'package:drift/drift.dart';
import '../database/database.dart';
import 'category.dart';
import 'common.dart';

enum NoteType {
  journal(1),
  note(2),
  idea(3),
  todo(4);

  final int value;

  const NoteType(this.value);

  static NoteType getByValue(num i) {
    return NoteType.values.firstWhere((x) => x.value == i);
  }
}

enum NoteFormat {
  plain(0),
  quill(1);

  final int value;

  const NoteFormat(this.value);

  static NoteFormat getByValue(num i) {
    return NoteFormat.values.firstWhere((x) => x.value == i);
  }
}

class Note {
  int? id;
  NoteType type;
  NoteFormat format;
  String title;
  String content;
  String? abstract;
  List<String>? tags;
  String? location;
  String? weather;
  String? mood;
  EncryptType encryptType;
  String? encryptArguments;
  DateTime createTime;
  DateTime lastUpdateTime;
  Category? category;

  Note(
      {this.id,
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
      this.category});

  NotesCompanion toCompanion() {
    return NotesCompanion(
      id: Value.absentIfNull(id),
      type: Value(type.value),
      format: Value(format.value),
      title: Value(title),
      content: Value(content),
      abstract: Value.absentIfNull(abstract),
      tags: Value.absentIfNull(tags?.join(",")),
      location: Value.absentIfNull(location),
      weather: Value.absentIfNull(weather),
      mood: Value.absentIfNull(mood),
      encryptType: Value(encryptType.value),
      encryptArguments: Value.absentIfNull(encryptArguments),
      createTime: Value(createTime.toIso8601String()),
      lastUpdateTime: Value(lastUpdateTime.toIso8601String()),
      categoryId: Value.absentIfNull(category?.id),
    );
  }

  static Note fromEntity(NoteEntity entity, CategoryEntity? category) {
    if (entity.categoryId != null) {
      assert(category != null && category.id == entity.categoryId);
    }
    return Note(
      id: entity.id,
      type: NoteType.getByValue(entity.type),
      format: NoteFormat.getByValue(entity.format),
      title: entity.title,
      content: entity.content,
      abstract: entity.abstract,
      tags: entity.tags?.split(","),
      location: entity.location,
      weather: entity.weather,
      mood: entity.mood,
      encryptType: EncryptType.getByValue(entity.encryptType),
      encryptArguments: entity.encryptArguments,
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
      category: category != null ? Category.fromEntity(category) : null,
    );
  }
}
