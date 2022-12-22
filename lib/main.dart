import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

final sl = GetIt.instance;

class AppRoutes {
  static String initial = '/';
  static String home = 'home page';
  static String login = 'login page';
  static String register = 'register page';
}

final routeGenerate = {
  AppRoutes.initial: (context) => const HomePage(),
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.login: (context) => const LoginPage(),
  AppRoutes.register: (context) => const RegisterPage(),
};

class Team {
  final int id;
  final String name;

  Team(this.id, this.name);
}

class Fixture {
  final int id;
  final int homeTeamId;
  final int awayTeamId;
  int homeTeamGoal;
  int awayTeamGoal;
  final int weekId;

  Fixture(
    this.id,
    this.weekId,
    this.homeTeamId,
    this.awayTeamId,
    this.homeTeamGoal,
    this.awayTeamGoal,
  );
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      routes: routeGenerate,
      initialRoute: AppRoutes.initial,
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int leagueSize = 8;

  final List<Team> teamList = [];

  List<Fixture> fixtureList = [];

  int weekId = 0;

  void createTeam() {
    for (var i = 0; i < leagueSize; i++) {
      final team = Team(i, 'Team ${i + 1}');
      teamList.add(team);
    }
  }

  void createFixture() {
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
  }

  String returnValidDataForGoal(int goal) => goal == -1 ? 'X' : goal.toString();

  String returnTeamName(int teamId) {
    return teamList.where((team) => team.id == teamId).first.name;
  }

  void playWeekGame() {
    setState(() {
      for (var element in fixtureList) {
        if (element.weekId == weekId) {
          element.homeTeamGoal = Random().nextInt(5);
          element.awayTeamGoal = Random().nextInt(5);
        }
      }
      weekId += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    createTeam();
    createFixture();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // print(size);
    // print(AppBar().preferredSize.height);
    // print(MediaQuery.of(context).padding);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              playWeekGame();
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              leagueSize - 1,
              (weekIdx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Week ${weekIdx + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ...List.generate(
                            leagueSize ~/ 2,
                            (index) {
                              final weekFixture = fixtureList
                                  .where((fixture) => fixture.weekId == weekIdx)
                                  .toList();
                              return Row(
                                children: [
                                  Flexible(
                                    child: textWithContainer(
                                      Colors.green,
                                      returnTeamName(
                                          weekFixture[index].homeTeamId),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  Flexible(
                                    child: textWithContainer(
                                      Colors.green,
                                      '${returnValidDataForGoal(weekFixture[index].homeTeamGoal)} - ${returnValidDataForGoal(weekFixture[index].awayTeamGoal)}',
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                  Flexible(
                                    child: textWithContainer(
                                      Colors.green,
                                      returnTeamName(
                                          weekFixture[index].awayTeamId),
                                    ),
                                    fit: FlexFit.tight,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget textWithContainer(Color color, String txt) => Container(
        height: 30,
        child: Center(child: Text(txt)),
      );
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: Text(AppRoutes.login.toUpperCase()),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
              child: Text(AppRoutes.home.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
