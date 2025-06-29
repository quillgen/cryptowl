import 'package:cryptowl/src/database/database.dart';

class NoteBasic {
  String id;
  int categoryId;
  String title;
  String abstract;
  int classification;
  DateTime createTime;
  DateTime lastUpdateTime;

  NoteBasic({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.abstract,
    required this.classification,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class Note {
  String id;
  int categoryId;
  String title;
  String content;
  int classification;
  DateTime createTime;
  DateTime lastUpdateTime;

  Note({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.classification,
    required this.createTime,
    required this.lastUpdateTime,
  });

  static Note fromEntity(NoteEntity entity) {
    return Note(
      id: entity.id,
      classification: entity.classification,
      categoryId: entity.categoryId,
      title: entity.title,
      content: entity.content,
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
    );
  }
}
