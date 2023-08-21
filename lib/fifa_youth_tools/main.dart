import 'package:flutter/material.dart';
import 'package:widget_test_practice/fifa_youth_tools/add_edit_player_screen.dart';

void main() {
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
  @override
  Widget build(BuildContext context) {
    fakePlayers.sort(
      (b, a) =>
          (a.maxPotential + a.minPotential) ~/ 2 -
          (b.maxPotential + b.minPotential) ~/ 2,
    );
    int topPlayerCount = fakePlayers.where(
      (player) {
        return (player.maxPotential + player.minPotential) ~/ 2 >= 90;
      },
    ).length;
    int goodPlayerCount = fakePlayers.where(
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
    for (var index = 0; index < fakePlayers.length; index++) {
      final player = fakePlayers[index];
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

class PlayerModel {
  final String id;
  final String position;
  final String name;
  final int minPotential;
  final int maxPotential;
  final bool sold;

  const PlayerModel({
    required this.id,
    required this.position,
    required this.name,
    required this.minPotential,
    required this.maxPotential,
    this.sold = false,
  });
}

List<PlayerModel> fakePlayers = [
  const PlayerModel(
    id: '1',
    position: 'st',
    name: 'firstName1',
    minPotential: 70,
    maxPotential: 90,
    sold: true,
  ),
  const PlayerModel(
    id: '2',
    position: 'gk',
    name: 'firstName2',
    minPotential: 84,
    maxPotential: 94,
  ),
  // PlayerModel(
  //   id: '3',
  //   position: PositionType.gk.name,
  //   firstName: 'firstName3',
  //   lastName: 'lastName3',
  //   minPotential: 78,
  //   maxPotential: 90,
  // ),
  // PlayerModel(
  //   id: '4',
  //   position: PositionType.gk.name,
  //   firstName: 'firstName4',
  //   lastName: 'lastName4',
  //   minPotential: 84,
  //   maxPotential: 90,
  // ),
  // PlayerModel(
  //   id: '5',
  //   position: PositionType.gk.name,
  //   firstName: 'firstName5',
  //   lastName: 'lastName5',
  //   minPotential: 88,
  //   maxPotential: 95,
  // ),
  // PlayerModel(
  //   id: '6',
  //   position: PositionType.gk.name,
  //   firstName: 'firstName6',
  //   lastName: 'lastName6',
  //   minPotential: 90,
  //   maxPotential: 94,
  // ),
];
