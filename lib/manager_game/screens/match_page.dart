import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final String Function(int) returnTeamName =
        context.read<GameProvider>().returnTeamName;
    final week = Provider.of<GameProvider>(context).week;
    final weekFixtures = context
        .read<GameProvider>()
        .fixtures
        .where((fixture) => fixture.weekId == week)
        .toList();

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
                  context.read<GameProvider>().updateFixture(fixture.id, 0, 0);
                }
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(returnTeamName(weekFixtures[index].homeTeamId)),
                        Text(
                          '${goalValidate(weekFixtures[index].homeTeamGoal)} - ${goalValidate(weekFixtures[index].awayTeamGoal)}',
                        ),
                        Text(returnTeamName(weekFixtures[index].awayTeamId)),
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
