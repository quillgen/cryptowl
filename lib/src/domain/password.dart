import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';

import '../database/database.dart';

class PasswordBasic {
  String id;
  int type;
  int categoryId;
  String title;
  DateTime? expireTime;
  DateTime createTime;
  DateTime lastUpdateTime;

  PasswordBasic({
    required this.id,
    required this.type,
    required this.categoryId,
    required this.title,
    this.expireTime,
    required this.createTime,
    required this.lastUpdateTime,
  });
}

class Password {
  String id;
  int type;
  int categoryId;
  String title;
  DateTime? expireTime;
  ProtectedValue value;
  String? username;
  String? uri;
  String? remark;
  DateTime createTime;
  DateTime lastUpdateTime;

  Password(
      {required this.id,
      required this.type,
      required this.title,
      this.expireTime,
      required this.value,
      this.username,
      this.uri,
      this.remark,
      required this.categoryId,
      required this.createTime,
      required this.lastUpdateTime});

  PasswordsCompanion toCompanion() {
    return PasswordsCompanion(
      id: Value.absentIfNull(id),
      type: Value(type),
      title: Value(title),
      value: Value(value.getText()),
      username: Value.absentIfNull(username),
      uri: Value.absentIfNull(uri),
      remark: Value.absentIfNull(remark),
      expireTime: Value.absentIfNull(expireTime?.toIso8601String()),
      createTime: Value(createTime.toIso8601String()),
      lastUpdateTime: Value(lastUpdateTime.toIso8601String()),
      categoryId: Value(categoryId),
    );
  }

  static Password fromEntity(PasswordEntity entity) {
    return Password(
      id: entity.id,
      type: entity.type,
      categoryId: entity.categoryId,
      title: entity.title,
      username: entity.username,
      uri: entity.uri,
      remark: entity.remark,
      expireTime:
          entity.expireTime == null ? null : DateTime.parse(entity.expireTime!),
      value: ProtectedValue.fromString(entity.value),
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
    );
  }
}
