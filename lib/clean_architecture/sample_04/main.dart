import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/home/presentation/screens/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

List<String> categories = [
  'Food',
  'Car',
  'Home',
  'Technonogy',
  'Smoke',
];
