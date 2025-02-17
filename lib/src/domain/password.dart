import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';

import '../database/database.dart';

class Password {
  String? id;
  int type;
  int categoryId;
  String title;
  DateTime? expireTime;
  ProtectedValue value;
  String? remark;
  DateTime createTime;
  DateTime lastUpdateTime;

  Password(
      {this.id,
      required this.type,
      required this.title,
      this.expireTime,
      required this.value,
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
      remark: entity.remark,
      expireTime:
          entity.expireTime == null ? null : DateTime.parse(entity.expireTime!),
      value: ProtectedValue.fromString(entity.value),
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
    );
  }
}
