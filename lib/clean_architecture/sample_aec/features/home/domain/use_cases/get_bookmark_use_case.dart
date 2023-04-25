import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/repositories/home_repository.dart';

class GetBookmarkUseCase {
  final HomeRepository repository;

  GetBookmarkUseCase({required this.repository});

  Future<List<PeopleEntity>> call() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return repository.getBookmark();
  }
}
