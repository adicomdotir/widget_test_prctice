import 'package:hive/hive.dart';

part 'player_model.g.dart';

@HiveType(typeId: 0)
class PlayerModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String position;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final int minPotential;
  @HiveField(4)
  final int maxPotential;
  @HiveField(5)
  final bool sold;

  const PlayerModel({
    required this.id,
    required this.position,
    required this.name,
    required this.minPotential,
    required this.maxPotential,
    this.sold = false,
  });

  PlayerModel copyWith({
    int? id,
    String? position,
    String? name,
    int? minPotential,
    int? maxPotential,
    bool? sold,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      position: position ?? this.position,
      name: name ?? this.name,
      minPotential: minPotential ?? this.minPotential,
      maxPotential: maxPotential ?? this.maxPotential,
      sold: sold ?? this.sold,
    );
  }

  @override
  String toString() {
    return '[id: $id, id: $name]';
  }
}
