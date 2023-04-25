import 'dart:convert';

class PeopleModel {
  final int id;
  final String name;
  final int age;
  final bool bookmark;

  PeopleModel({
    required this.id,
    required this.name,
    required this.age,
    required this.bookmark,
  });

  PeopleModel copyWith({
    int? id,
    String? name,
    int? age,
    bool? bookmark,
  }) {
    return PeopleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      bookmark: bookmark ?? this.bookmark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'bookmark': bookmark,
    };
  }

  factory PeopleModel.fromMap(Map<String, dynamic> map) {
    return PeopleModel(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      age: map['age'].toInt() as int,
      bookmark: map['bookmark'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PeopleModel.fromJson(String source) =>
      PeopleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PeopleModel(id: $id, name: $name, age: $age)';

  @override
  bool operator ==(covariant PeopleModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.age == age;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ age.hashCode;
}
