import 'package:cryptowl/src/common/classification.dart';
import 'package:cryptowl/src/common/string.dart';
import 'package:cryptowl/src/crypto/random_util.dart';

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

const ATTR_USER = "user";
const ATTR_REMARK = "remark";

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
  bool isTopSecret;
  int categoryId;
  String? title;
  DateTime? expireTime;
  ProtectedValue value;
  List<PasswordAttribute> attributes;
  DateTime createdAt;
  DateTime updatedAt;

  Password(
      {required this.id,
      required this.type,
      required this.isTopSecret,
      required this.title,
      this.expireTime,
      required this.value,
      required this.attributes,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});

  factory Password.create(String title, ProtectedValue password,
      bool isTopSecret, String? user, String? remark) {
    final now = DateTime.now();
    return Password(
        id: RandomUtil.generateUUID(),
        type: 0,
        isTopSecret: isTopSecret,
        title: title,
        value: password,
        categoryId: 0,
        attributes: [
          if (user.isNotBlank)
            PasswordAttribute(
                name: ATTR_USER,
                isProtected: false,
                value: ProtectedValue.fromString(user!)),
          if (remark.isNotBlank)
            PasswordAttribute(
                name: ATTR_USER,
                isProtected: false,
                value: ProtectedValue.fromString(remark!)),
        ],
        createdAt: now,
        updatedAt: now);
  }
  static Password fromEntity(TPasswordData e) {
    return Password(
        id: e.id,
        type: e.type,
        title: e.title,
        isTopSecret: false,
        value: ProtectedValue.fromString("tbd"),
        categoryId: e.categoryId,
        createdAt: e.createdAt,
        attributes: [],
        updatedAt: e.updatedAt);
  }
}
