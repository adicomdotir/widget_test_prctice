import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/repositories/home_repository.dart';

class GetPeoplesUseCase {
  final HomeRepository repository;

  GetPeoplesUseCase({required this.repository});

  Future<List<PeopleEntity>> call() {
    return repository.getPeoples();
  }
}
