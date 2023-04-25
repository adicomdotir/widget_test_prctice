import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/repositories/home_repository.dart';
import '../entities/people_entity.dart';

class BookmarkUseCase {
  final HomeRepository repository;

  BookmarkUseCase({required this.repository});

  Future<bool> call(PeopleEntity peopleEntity) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return repository.bookmarkPeople(peopleEntity);
  }
}
