import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:widget_test_practice/fifa_youth_tools/add_edit_player_screen.dart';
import 'package:widget_test_practice/fifa_youth_tools/config/constants.dart';
import 'package:widget_test_practice/fifa_youth_tools/fifa_database.dart';
import 'package:widget_test_practice/fifa_youth_tools/player_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlayerModelAdapter());
  await Hive.openBox<PlayerModel>(Constants.playerTableName);

  runApp(
    const MaterialApp(
      home: FifaYouthToolsHome(),
    ),
  );
}

class FifaYouthToolsHome extends StatefulWidget {
  const FifaYouthToolsHome({Key? key}) : super(key: key);

  @override
  State<FifaYouthToolsHome> createState() => _FifaYouthToolsHomeState();
}

class _FifaYouthToolsHomeState extends State<FifaYouthToolsHome> {
  List<PlayerModel> players = [];

  @override
  void initState() {
    super.initState();
    players = FifaDatabase.getInstance().fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    players.sort(
      (b, a) =>
          (a.maxPotential + a.minPotential) ~/ 2 -
          (b.maxPotential + b.minPotential) ~/ 2,
    );
    int topPlayerCount = players.where(
      (player) {
        return (player.maxPotential + player.minPotential) ~/ 2 >= 90;
      },
    ).length;
    int goodPlayerCount = players.where(
      (player) {
        int playerAveragePotential =
            (player.maxPotential + player.minPotential) ~/ 2;
        return playerAveragePotential < 90 && playerAveragePotential > 85;
      },
    ).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditPlayerScreen(),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...getItems(topPlayerCount, goodPlayerCount),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(PlayerModel player) {
    final averageOverall = (player.minPotential + player.maxPotential) / 2;
    if (averageOverall >= 90) {
      return Colors.red;
    } else if (averageOverall <= 85) {
      return Colors.yellow;
    }
    return Colors.orange;
  }

  List<Widget> getItems(int topPlayerCount, int goodPlayerCount) {
    List<Widget> items = [];
    for (var index = 0; index < players.length; index++) {
      final player = players[index];
      final Color playerColor = getColor(player);
      const textStyle = TextStyle(color: Colors.black);
      if (index == 0) {
        Widget header = const HeaderWidget(
          title: 'TOP PLAYERS',
        );
        items.add(header);
      }
      if (index == topPlayerCount) {
        Widget header = const HeaderWidget(
          title: 'GOOD PLAYERS',
        );
        items.add(header);
      }

      if (index == topPlayerCount + goodPlayerCount) {
        Widget header = const HeaderWidget(
          title: 'NORMAL PLAYERS',
        );
        items.add(header);
      }
      Widget card = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditPlayerScreen(player: player),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (player.sold)
                  const Text(
                    'SOLD',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                Text(
                  '${player.position.toUpperCase()} => ${player.name}',
                  style: textStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'POTENTIAL => ',
                      style: textStyle,
                    ),
                    Container(
                      color: playerColor,
                      child: Text(
                        '[${player.minPotential} - ${player.maxPotential}]',
                        style: textStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
      items.add(card);
    }
    return items;
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
