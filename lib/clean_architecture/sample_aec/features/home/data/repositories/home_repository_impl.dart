import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/data_sources/home_local_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource dataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.dataSource,
    required this.localDataSource,
  });

  @override
  Future<List<PeopleEntity>> getPeoples() async {
    final result = await dataSource.getPeoples();
    final bookmarkResult = await localDataSource.getBookmarkPeoples();

    final List<PeopleEntity> newList = [];
    for (var remote in result) {
      bool exist = false;
      for (var local in bookmarkResult) {
        if (remote.id == local.id) {
          exist = true;
        }
      }
      newList.add(
        PeopleEntity(
          id: remote.id,
          name: remote.name,
          age: remote.age,
          bookmark: exist,
        ),
      );
    }
    return newList;
  }

  @override
  Future<bool> bookmarkPeople(PeopleEntity peopleEntity) {
    return localDataSource.bookmarkPeople(peopleEntity.toModel());
  }

  @override
  Future<List<PeopleEntity>> getBookmark() async {
    final result = await localDataSource.getBookmarkPeoples();
    return result
        .map(
          (e) => PeopleEntity(
            id: e.id,
            name: e.name,
            age: e.age,
            bookmark: e.bookmark,
          ),
        )
        .toList();
  }
}
