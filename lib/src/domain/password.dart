import 'package:cryptowl/src/common/classification.dart';

import '../crypto/protected_value.dart';
import '../database/database.dart';

class PasswordBasic {
  String id;
  int type;
  int categoryId;
  String title;
  Classification classification;
  DateTime? expireTime;
  DateTime createdAt;
  DateTime updatedAt;

  PasswordBasic({
    required this.id,
    required this.type,
    required this.categoryId,
    required this.title,
    this.classification = Classification.secret,
    this.expireTime,
    required this.createdAt,
    required this.updatedAt,
  });
}

class PasswordAttribute {
  String name;
  bool isProtected;
  ProtectedValue value;

  PasswordAttribute(
      {required this.name, required this.isProtected, required this.value});
}

class Password {
  String id;
  int type;
  Classification classification;
  int categoryId;
  String? title;
  DateTime? expireTime;
  ProtectedValue value;
  List<PasswordAttribute>? attributes;
  DateTime createdAt;
  DateTime updatedAt;

  Password(
      {required this.id,
      required this.type,
      this.classification = Classification.secret,
      required this.title,
      this.expireTime,
      required this.value,
      this.attributes,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});

  static Password fromEntity(TPasswordData e) {
    return Password(
        id: e.id,
        type: e.type,
        title: e.title,
        value: ProtectedValue.fromString("tbd"),
        categoryId: e.categoryId,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt);
  }
}
