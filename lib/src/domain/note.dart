import 'package:cryptowl/src/common/classification.dart';
import 'package:cryptowl/src/common/note_util.dart';
import 'package:cryptowl/src/database/database.dart';

class NoteAbstract {
  String id;
  String? title;
  String? abstract;
  Classification classification;
  DateTime createTime;
  DateTime lastUpdateTime;

  NoteAbstract({
    required this.id,
    this.title,
    required this.abstract,
    required this.classification,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

enum NoteSortType { dateAsc, dateDesc }

class NoteDetailDto {
  String id;
  String? title;
  String contentJson;
  String? contentPlain;
  Classification classification;
  DateTime createdAt;
  DateTime updatedAt;

  NoteDetailDto({
    required this.id,
    this.title,
    this.contentPlain,
    required this.contentJson,
    required this.classification,
    required this.createdAt,
    required this.updatedAt,
  });

  TNoteData toEntity() {
    final abstract = NoteUtil.createAbstract(contentPlain ?? "");
    return TNoteData(
      id: id,
      classification: classification.value,
      title: title,
      contentJson: contentJson,
      createdAt: createdAt,
      updatedAt: updatedAt,
      contentChecksum: NoteUtil.checksum(contentJson),
      abstract: abstract,
      contentPlain: contentPlain ?? "",
    );
  }

  static NoteDetailDto fromEntity(TNoteData entity) {
    return NoteDetailDto(
      id: entity.id,
      classification: Classification.parse(entity.classification),
      title: entity.title,
      contentJson: entity.contentJson,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
