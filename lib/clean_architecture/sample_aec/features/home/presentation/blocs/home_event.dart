import '../../domain/entities/people_entity.dart';

abstract class HomeEvent {}

class GetPeoplesHomeEvent extends HomeEvent {}

class BookmarkPeopleHomeEvent extends HomeEvent {
  final PeopleEntity peopleEntity;
  final bool loadFromBookmark;

  BookmarkPeopleHomeEvent({
    required this.peopleEntity,
    required this.loadFromBookmark,
  });
}

class GetBookmarkHomeEvent extends HomeEvent {}
