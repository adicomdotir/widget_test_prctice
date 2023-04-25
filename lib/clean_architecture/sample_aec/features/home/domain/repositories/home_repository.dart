import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';

abstract class HomeRepository {
  Future<List<PeopleEntity>> getPeoples();

  Future<bool> bookmarkPeople(PeopleEntity peopleEntity);

  Future<List<PeopleEntity>> getBookmark();
}
