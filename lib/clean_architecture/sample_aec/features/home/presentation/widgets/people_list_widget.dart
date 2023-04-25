import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/domain/entities/people_entity.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_aec/features/home/presentation/blocs/home_event.dart';

class PeopleListWidget extends StatelessWidget {
  final List<PeopleEntity> peoples;
  final bool isLoadFromBookmark;

  const PeopleListWidget(
    this.peoples, {
    Key? key,
    required this.isLoadFromBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: peoples.length,
      itemBuilder: (context, index) {
        final people = peoples[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(people.name.substring(0, 1)),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          title: Text(people.name),
          subtitle: Text('Age: ${people.age}'),
          trailing: IconButton(
            icon: people.bookmark
                ? const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  )
                : const Icon(Icons.favorite_border),
            onPressed: () {
              final newPeopleEntity = PeopleEntity(
                id: people.id,
                name: people.name,
                age: people.age,
                bookmark: !people.bookmark,
              );
              BlocProvider.of<HomeBloc>(context).add(
                BookmarkPeopleHomeEvent(
                  peopleEntity: newPeopleEntity,
                  loadFromBookmark: isLoadFromBookmark,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
