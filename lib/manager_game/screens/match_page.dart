import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/manager_game/models/fixture.dart';
import 'package:widget_test_practice/manager_game/providers/game_provider.dart';
import 'package:widget_test_practice/manager_game/utils/goal_validate.dart';
import 'package:widget_test_practice/common/log_extension.dart';
import 'package:widget_test_practice/provider_sample/provider_17/app_provider.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  Timer? timer;
  int matchTimer = 0;
  bool matchStart = false;
  List<List<int>> chancesPerMatch = [];
  late String Function(int) returnTeamName;
  late int week;
  late List<Fixture> weekFixtures;

  @override
  void initState() {
    super.initState();
    returnTeamName = context.read<GameProvider>().returnTeamName;
    week = context.read<GameProvider>().week;
    weekFixtures = context
        .read<GameProvider>()
        .fixtures
        .where((fixture) => fixture.weekId == week)
        .toList();

    for (int i = 0; i < weekFixtures.length; i++) {
      int chance = Random().nextInt(8) + 1;
      chancesPerMatch.add([]);
      for (int j = 0; j < chance; j++) {
        int chanceTime = Random().nextInt(90) + 1;
        if (chancesPerMatch[i].isNotEmpty) {
          int retry = 0;
          while (
              chancesPerMatch[i][chancesPerMatch[i].length - 1] >= chanceTime &&
                  retry < 15) {
            retry += 1;
            chanceTime = Random().nextInt(90) + 1;
          }
          if (chancesPerMatch[i][chancesPerMatch[i].length - 1] < chanceTime) {
            chancesPerMatch[i].add(chanceTime);
          }
        } else if (chancesPerMatch[i].isEmpty) {
          chancesPerMatch[i].add(chanceTime);
        }
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  startMatchTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      matchTimer += 1;
      if (matchTimer >= 90) {
        timer.cancel();
      }
      for (int i = 0; i < weekFixtures.length; i++) {
        if (chancesPerMatch[i].contains(matchTimer)) {
          final homeOrAway = Random().nextInt(2);
          String msg = 'Chance for ';
          msg += context.read<GameProvider>().returnTeamName(
                homeOrAway == 0
                    ? weekFixtures[i].homeTeamId
                    : weekFixtures[i].awayTeamId,
              );
          msg += ' at $matchTimer minute';
          final goalOrNot = Random().nextInt(2);
          if (goalOrNot == 0) {
            msg += ', GOAL';
            context.read<GameProvider>().updateFixture(
                  weekFixtures[i].id,
                  homeOrAway == 0 ? 1 : 0,
                  homeOrAway == 0 ? 0 : 1,
                );
          }
          context.read<GameProvider>().updateMatch(weekFixtures[i].id, msg);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('Match'),
      ),
      floatingActionButton: (matchStart == false)
          ? FloatingActionButton(
              onPressed: () {
                startMatchTimer();
                setState(() {
                  matchStart = true;
                });
                for (var fixture in weekFixtures) {
                  context.read<GameProvider>().updateFixture(fixture.id, 1, 1);
                }
                context.read<GameProvider>().gotoNextWeek();
              },
              child: const Icon(Icons.navigate_next),
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Minute $matchTimer',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                returnTeamName(weekFixtures[index].homeTeamId),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${goalValidate(weekFixtures[index].homeTeamGoal)} - ${goalValidate(weekFixtures[index].awayTeamGoal)}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                returnTeamName(weekFixtures[index].awayTeamId),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ...List.generate(
                          context
                              .read<GameProvider>()
                              .getChancesCount(weekFixtures[index].id),
                          (chanceIdx) => Text(
                            context
                                .read<GameProvider>()
                                .getChance(weekFixtures[index].id, chanceIdx),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: weekFixtures.length,
            ),
          ),
        ],
      ),
    );
  }
}
