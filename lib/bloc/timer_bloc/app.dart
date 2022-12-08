import 'package:flutter/material.dart';
import 'package:widget_test_practice/bloc/timer_bloc/timer/timer.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Timer',
      home: TimerPage(),
    );
  }
}
