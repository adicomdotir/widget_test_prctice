import 'package:hive_flutter/hive_flutter.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  String? name;
}

@HiveType(typeId: 1)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? quantity;
}
