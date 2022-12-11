import 'package:flutter/material.dart';
import 'package:widget_test_practice/stopwatch_flutter/ui/clock_markers.dart';
import 'package:widget_test_practice/stopwatch_flutter/ui/elapsed_time_text.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({
    Key? key,
    required this.elapsed,
  }) : super(key: key);
  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.indigo,
        ),
        ElapsedTimeText(
          elapsed: elapsed,
        ),
      ],
    );
  }
}
