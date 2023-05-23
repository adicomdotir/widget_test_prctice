import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/datasources%20/film_hive_helper.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/datasources%20/film_local_datasource.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/datasources%20/film_remote_datasource.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/data/repository%20/film_repository_impl.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/domain/usecases%20/films_usecase.dart';
import 'package:widget_test_practice/clean_architecture/sample_05/features/films/presentation/bloc/home_bloc.dart';

class Home05Page extends StatelessWidget {
  const Home05Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dio = Dio();
    var filmHiveHelper = FilmHiveHelper();
    var remote = FilmsRemoteDataSourceImpl(dio: dio);
    var local = FilmLocalDataSourceImpl(filmHiveHelper: filmHiveHelper);
    var repository =
        FilmRepositoryImpl(remoteDataSource: remote, localDataSource: local);
    var filmsUsecase = FilmsUsecase(repository: repository);
    var homeBloc = HomeBloc(filmsUsecase: filmsUsecase);
    return BlocProvider(
      create: (context) => homeBloc..add(GetFilmsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Star Wars')),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetFilmsSuccess) {
                return ListView.builder(
                  itemCount: state.films.length,
                  itemBuilder: (context, index) {
                    final film = state.films[index];
                    return ListTile(
                      onTap: () {
                        // AutoRouter.of(context).push(
                        //   CharacterHomeRoute(
                        //     episodeNo: '${film.episodeId}',
                        //     characterUrls: film.characters,
                        //     uid: film.uid,
                        //   ),
                        // );
                      },
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      title: Text(film.title),
                      leading: IconButton(
                        icon: film.isFavorite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        onPressed: () {
                          // ref.read(filmsProvider.notifier).toggleFilmAsFavorite(
                          //       uid: film.uid,
                          //       params: FilmsParams(path: '/films'),
                          //     );
                        },
                      ),
                      subtitle: Text(film.releaseDate),
                    );
                  },
                );
              } else if (state is GetFilmsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetFilmsError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () {
            // ref
            //     .read(filmsProvider.notifier)
            //     .getFilms(params: FilmsParams(path: '/films'));
          },
        ),
      ),
    );
  }
}
