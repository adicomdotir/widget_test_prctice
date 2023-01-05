import 'package:flutter/cupertino.dart';
import 'package:widget_test_practice/manager_game/models/fixture.dart';
import 'package:widget_test_practice/manager_game/models/team.dart';

class GameProvider extends ChangeNotifier {
  int _week = 0;
  final int _leagueSize = 8;
  List<Fixture> _fixtures = [];
  List<Team> _teams = [];

  int get week => _week;

  int get leagueSize => _leagueSize;

  List<Fixture> get fixtures => _fixtures;

  List<Team> get teams => _teams;

  void gotoNextWeek() {
    _week++;
    notifyListeners();
  }

  void addFixtures(List<Fixture> fixtures) {
    _fixtures = fixtures;
  }

  void addTeams(List<Team> teams) {
    _teams = teams;
  }

  void updateFixture(int id, int homeGoal, int awayGoal) {
    Fixture fixture = _fixtures.where((fixture) => fixture.id == id).first;
    fixture.homeTeamGoal = homeGoal;
    fixture.awayTeamGoal = awayGoal;
  }

  String returnTeamName(int teamId) {
    return teams.where((team) => team.id == teamId).first.name;
  }
}
