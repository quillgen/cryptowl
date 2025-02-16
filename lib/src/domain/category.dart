import '../database/database.dart';
import 'common.dart';

class Category {
  int? id;
  String name;
  EncryptType encryptType;
  String? encryptArguments;
  DateTime createTime;
  DateTime lastUpdateTime;

  Category(
      {this.id,
      required this.name,
      required this.encryptType,
      this.encryptArguments,
      required this.createTime,
      required this.lastUpdateTime});

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      id: entity.id,
      name: entity.name,
      encryptType: EncryptType.getByValue(entity.encryptType),
      encryptArguments: entity.encryptArguments,
      createTime: DateTime.parse(entity.createTime),
      lastUpdateTime: DateTime.parse(entity.lastUpdateTime),
    );
  }
}
