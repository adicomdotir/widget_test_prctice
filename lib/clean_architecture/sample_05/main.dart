import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/films/presentation/pages /home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(FilmModelAdapter());
  // Hive.registerAdapter(PropertiesModelAdapter());
  // Hive.registerAdapter(CharacterModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home05Page(),
    );
  }
}
