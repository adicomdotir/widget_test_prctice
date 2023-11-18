import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:widget_test_practice/mock_sample/constants.dart';
import 'package:widget_test_practice/mock_sample/screens/home_screen.dart';

import 'screens/edit_screen.dart';
import 'service/app_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  createTable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes,
      initialRoute: '/',
      home: const HomeScreen(),
    );
  }

  Route _routes(RouteSettings settings) {
    Widget _builder = Container();
    switch (settings.name) {
      case '/':
        _builder = const HomeScreen();
        break;
      case 'edit':
        EditScreenArg arg = settings.arguments as EditScreenArg;
        _builder = EditScreen(
          task: arg.task,
        );
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: (_) => _builder,
      settings: settings,
    );
  }
}

createTable() async {
  var databasesPath = await getDatabasesPath();
  String path = (databasesPath + demoDb);
  await TaskService.instance.initialize(path);
}
