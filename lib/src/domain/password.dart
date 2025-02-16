import 'package:drift/drift.dart';
import 'package:kdbx/kdbx.dart';

import '../database/database.dart';
import 'category.dart';
import 'common.dart';

class Password {
  int? id;
  String title;
  String? url;
  String? username;
  String? tip;
  String? email;
  DateTime? expireTime;
  ProtectedValue value;
  String? remark;
  EncryptType encryptType;
  String? encryptArguments;
  DateTime createTime;
  DateTime lastUpdateTime;
  Category? category;

  Password(
      {this.id,
      required this.title,
      this.url,
      this.username,
      this.tip,
      this.email,
      this.expireTime,
      required this.value,
      this.remark,
      required this.encryptType,
      this.encryptArguments,
      required this.createTime,
      required this.lastUpdateTime,
      this.category});

  PasswordsCompanion toCompanion() {
    return PasswordsCompanion(
      id: Value.absentIfNull(id),
      title: Value(title),
      value: Value(value.getText()),
      remark: Value.absentIfNull(remark),
      url: Value.absentIfNull(url),
      username: Value.absentIfNull(username),
      tip: Value.absentIfNull(tip),
      email: Value.absentIfNull(email),
      expireTime: Value.absentIfNull(expireTime?.toIso8601String()),
      encryptType: Value(encryptType.value),
      encryptArguments: Value.absentIfNull(encryptArguments),
      createTime: Value(createTime.toIso8601String()),
      lastUpdateTime: Value(lastUpdateTime.toIso8601String()),
      categoryId: Value.absentIfNull(category?.id),
    );
  }

  static Password fromEntity(PasswordEntity entity, CategoryEntity? category) {
    if (entity.categoryId != null) {
      assert(category != null && category.id == entity.categoryId);
    }
    return Password(
      id: entity.id,
      title: entity.title,
      url: entity.url,
      username: entity.username,
      remark: entity.remark,
      tip: entity.tip,
      email: entity.email,
      expireTime:
          entity.expireTime == null ? null : DateTime.parse(entity.expireTime!),
      value: ProtectedValue.fromString(entity.value),
      encryptType: EncryptType.getByValue(entity.encryptType),
      encryptArguments: entity.encryptArguments,
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
      category: category != null ? Category.fromEntity(category) : null,
    );
  }
}
