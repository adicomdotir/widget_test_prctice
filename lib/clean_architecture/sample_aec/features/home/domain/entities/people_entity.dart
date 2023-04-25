import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/models/people_model.dart';

class PeopleEntity {
  final int id;
  final String name;
  final int age;
  final bool bookmark;

  PeopleEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.bookmark,
  });

  factory PeopleEntity.fromModel(PeopleModel peopleModel) => PeopleEntity(
        id: peopleModel.id,
        name: peopleModel.name,
        age: peopleModel.age,
        bookmark: peopleModel.bookmark,
      );

  PeopleModel toModel() => PeopleModel(
        id: id,
        name: name,
        age: age,
        bookmark: bookmark,
      );
}
