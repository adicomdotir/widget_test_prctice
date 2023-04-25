import 'package:widget_test_practice/clean_architecture/sample_aec/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/models/people_model.dart';

abstract class HomeLocalDataSource {
  Future<bool> bookmarkPeople(PeopleModel model);

  Future<List<PeopleModel>> getBookmarkPeoples();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final DatabaseHelper databaseHelper;

  HomeLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> bookmarkPeople(PeopleModel model) {
    if (model.bookmark) {
      databaseHelper.bookmark.add(model);
    } else {
      databaseHelper.bookmark.remove(model);
    }
    return Future.value(true);
  }

  @override
  Future<List<PeopleModel>> getBookmarkPeoples() async {
    return databaseHelper.bookmark;
  }
}
