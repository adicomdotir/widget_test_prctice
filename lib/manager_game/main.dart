import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:widget_test_practice/manager_game/providers/game_provider.dart';
import 'package:widget_test_practice/manager_game/screens/fixture_page.dart';
import 'package:widget_test_practice/manager_game/screens/home_page.dart';
import 'package:widget_test_practice/manager_game/screens/match_page.dart';


final sl = GetIt.instance;

class AppRoutes {
  static String home = '/';
  static String fixture = 'fixture';
  static String league = 'league';
  static String match = 'match';
}

final routeGenerate = {
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.fixture: (context) => const FixturePage(),
  AppRoutes.league: (context) => const HomePage(),
  AppRoutes.match: (context) => const MatchPage(),
};

void main() {
  runApp(
    ChangeNotifierProvider<GameProvider>(
      create: (_) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routeGenerate,
        initialRoute: AppRoutes.home,
      ),
    ),
  );
}
