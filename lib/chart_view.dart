import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChartView(),
    );
  }
}

class ChartView extends StatelessWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart View'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.black,
          child: CustomPaint(
            painter: ChartPainter(data: chartData),
          ),
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<Point> data;
  final double xMax;
  final double yMax;

  ChartPainter({
    required this.data,
    this.xMax = 10,
    this.yMax = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = 1;

    // canvas.drawLine(Offset.zero, Offset(size.width * 0.5, size.height), paint);
    // canvas.drawLine(
    //   Offset(size.width * 0.5, size.height),
    //   Offset(size.width, 0),
    //   paint,
    // );
    for (int i = 0; i < data.length - 1; i++) {
      final p1 = data[i];
      final p2 = data[i + 1];
      canvas.drawLine(
        Offset(
          size.width / xMax * p1.x,
          size.height - size.height / yMax * p1.y,
        ),
        Offset(
          size.width / xMax * p2.x,
          size.height - size.height / yMax * p2.y,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ChartPainter oldDelegate) => false;
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}

List<Point> chartData = [
  Point(x: 1, y: 1),
  Point(x: 2, y: 1),
  Point(x: 3, y: 3),
  Point(x: 4, y: 0),
  Point(x: 7, y: 8),
];
