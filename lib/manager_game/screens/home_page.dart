import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_test_practice/manager_game/main.dart';
import 'package:widget_test_practice/manager_game/models/fixture.dart';
import 'package:widget_test_practice/manager_game/models/team.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/manager_game/providers/game_provider.dart';
import 'package:widget_test_practice/manager_game/screens/widgets/my_bottom_appbar.dart';
import 'package:widget_test_practice/manager_game/team_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int leagueSize = -1;


  @override
  void initState() {
    super.initState();
    leagueSize = context.read<GameProvider>().leagueSize;
    createTeam();
    createFixture();
  }

  void createTeam() {
    final teamList = <Team>[];
    for (var i = 0; i < leagueSize; i++) {
      int rnd = Random().nextInt(teamNameMock.length);
      final team = Team(i, teamNameMock[rnd]);
      teamList.add(team);
    }
    context.read<GameProvider>().addTeams(teamList);
  }

  void createFixture() {
    final teamList = context.read<GameProvider>().teams;
    List<Fixture> fixtureList = [];
    List<int> teamsId = [];
    for (var i = 0; i < leagueSize; i++) {
      teamsId.add(teamList[i].id);
    }
    for (var i = 0; i < leagueSize; i++) {
      for (var j = 0; j < leagueSize; j += 2) {
        // fixture
        final fixture = Fixture(
          fixtureList.length + 1,
          i,
          teamsId[j],
          teamsId[j + 1],
          -1,
          -1,
        );
        fixtureList.add(fixture);
      }
      // swap teams id
      int id = teamsId.removeAt(1);
      teamsId.add(id);
    }
    context.read<GameProvider>().addFixtures(fixtureList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.match);
        },
        child: const Icon(Icons.navigate_next),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const MyBottomAppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: PageView(
          children: <Widget>[
            Container(
              color: Colors.pink,
            ),
            Container(
              color: Colors.cyan,
            ),
            Container(
              color: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  Widget textWithContainer(Color color, String txt) => SizedBox(
    height: 30,
    child: Center(child: Text(txt)),
  );
}
