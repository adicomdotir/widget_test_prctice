import 'package:get_it/get_it.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/core/database_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/data_sources/home_local_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/data/repositories/home_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/repositories/home_repository.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/use_cases/bookmark_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/use_cases/get_bookmark_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/use_cases/get_peoples_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_bloc.dart';

final inject = GetIt.instance;

Future<void> init() async {
  inject.registerFactory(
    () => HomeBloc(
      getPeoplesUseCase: inject(),
      bookmarkUseCase: inject(),
      getBookMarkUseCase: inject(),
    ),
  );
  inject.registerLazySingleton<GetPeoplesUseCase>(
    () => GetPeoplesUseCase(repository: inject()),
  );
  inject.registerLazySingleton<GetBookmarkUseCase>(
    () => GetBookmarkUseCase(repository: inject()),
  );
  inject.registerLazySingleton<BookmarkUseCase>(
    () => BookmarkUseCase(repository: inject()),
  );
  inject.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(dataSource: inject(), localDataSource: inject()),
  );
  inject.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  inject.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(databaseHelper: inject()),
  );
  inject.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );
}
