import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/manager_game/providers/game_provider.dart';
import 'package:widget_test_practice/manager_game/screens/widgets/my_bottom_appbar.dart';
import 'package:widget_test_practice/manager_game/utils/goal_validate.dart';

class FixturePage extends StatelessWidget {
  const FixturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int leagueSize = context.read<GameProvider>().leagueSize;
    final int week = context.read<GameProvider>().week;
    final String Function(int) returnTeamName = context.read<GameProvider>().returnTeamName;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Fixtures'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.navigate_next),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              ...List.generate(
                leagueSize - 1,
                (weekId) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: week == weekId ? Colors.amber[100] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Week ${weekId + 1}',
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
                                final weekFixture = context
                                    .read<GameProvider>()
                                    .fixtures
                                    .where(
                                        (fixture) => fixture.weekId == weekId)
                                    .toList();
                                return Row(
                                  children: [
                                    Flexible(
                                      child: textWithContainer(
                                        Colors.green,
                                        returnTeamName(
                                          weekFixture[index].homeTeamId,
                                        ),
                                      ),
                                      fit: FlexFit.tight,
                                    ),
                                    Flexible(
                                      child: textWithContainer(
                                        Colors.green,
                                        '${goalValidate(weekFixture[index].homeTeamGoal)} - ${goalValidate(weekFixture[index].awayTeamGoal)}',
                                      ),
                                      fit: FlexFit.tight,
                                    ),
                                    Flexible(
                                      child: textWithContainer(
                                        Colors.green,
                                        returnTeamName(
                                          weekFixture[index].awayTeamId,
                                        ),
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
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textWithContainer(Color color, String txt) => SizedBox(
      height: 30,
      child: Center(child: Text(txt)),
    );
