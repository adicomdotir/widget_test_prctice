import 'package:flutter/cupertino.dart';
import 'package:widget_test_practice/manager_game/models/fixture.dart';
import 'package:widget_test_practice/manager_game/models/fixture_match.dart';
import 'package:widget_test_practice/manager_game/models/team.dart';

class GameProvider extends ChangeNotifier {
  int _week = 0;
  final int _leagueSize = 8;
  List<Fixture> _fixtures = [];
  List<Team> _teams = [];
  final List<FixtureMatch> _matches = [];

  int get week => _week;

  int get leagueSize => _leagueSize;

  List<Fixture> get fixtures => _fixtures;

  List<Team> get teams => _teams;

  List<FixtureMatch> get matches => _matches;

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

  void updateMatch(int fixtureId, String chance) {
    if (_matches.isEmpty ||
        _matches.where((match) => match.fixtureId == fixtureId).isEmpty) {
      _matches.add(FixtureMatch(fixtureId: fixtureId, chances: [chance]));
    } else {
      for (int i = 0; i < _matches.length; i++) {
        if (_matches[i].fixtureId == fixtureId) {
          final match = _matches[i];
          match.chances.add(chance);
          _matches[i] = match;
        }
      }
    }
  }

  int getChancesCount(int fixtureId) {
    final filteredMatches = _matches.where((element) => element.fixtureId == fixtureId);
    if (filteredMatches.isEmpty) return 0;
    return filteredMatches.first.chances.length;
  }

  String getChance(int fixtureId, int index) {
    final filteredMatches = _matches.where((element) => element.fixtureId == fixtureId);
    return filteredMatches.first.chances[index];
  }

  void updateFixture(int id, int homeGoal, int awayGoal) {
    Fixture fixture = _fixtures.where((fixture) => fixture.id == id).first;
    fixture.homeTeamGoal += homeGoal;
    fixture.awayTeamGoal += awayGoal;
  }

  String returnTeamName(int teamId) {
    return teams.where((team) => team.id == teamId).first.name;
  }
}
