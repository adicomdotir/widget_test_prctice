import 'dart:math';

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
            painter: ChartPainter(
              data: [
                chartData1,
                chartData2,
              ],
              colors: [
                Colors.greenAccent,
                Colors.redAccent,
              ],
              strokeWidth: 1,
              radius: 3,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<List<Point>> data;
  final List<Color> colors;
  final double strokeWidth;
  final double radius;
  double? xMax;
  double? xMin;
  double? yMax;
  double? yMin;

  ChartPainter({
    required this.data,
    required this.colors,
    this.strokeWidth = 1,
    this.radius = 5,
    this.xMax = 10,
    this.yMax = 10,
    this.xMin = 0,
    this.yMin = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = strokeWidth;

    // xMax = data
    //     .map((e) => e.x)
    //     .reduce((value, element) => value > element ? value : element);
    // yMax = data
    //     .map((e) => e.y)
    //     .reduce((value, element) => value > element ? value : element);
    // xMin = data
    //     .map((e) => e.x)
    //     .reduce((value, element) => value < element ? value : element);
    // yMin = data
    //     .map((e) => e.y)
    //     .reduce((value, element) => value < element ? value : element);

    for (var i = xMin!; i < xMax!.toInt(); i++) {
      paint.color = Colors.grey.shade800;
      canvas.drawLine(
        Offset(
          size.width / xMax! * i,
          0,
        ),
        Offset(
          size.width / xMax! * i,
          size.height,
        ),
        paint,
      );
      drawText(
        i.toString(),
        canvas,
        size,
        Offset(size.width / xMax! * i, size.height),
      );
    }

    for (var i = yMin!; i < yMax!.toInt(); i++) {
      paint.color = Colors.grey.shade800;
      canvas.drawLine(
        Offset(
          0,
          size.height / yMax! * i,
        ),
        Offset(
          size.width,
          size.height / yMax! * i,
        ),
        paint,
      );

      drawText(
        (yMax! - i).toString(),
        canvas,
        size,
        Offset(0, size.height / yMax! * i),
        xLabel: false,
      );
    }

    for (var j = 0; j < data.length; j++) {
      paint.color = colors[j];
      for (int i = 0; i < data[j].length - 1; i++) {
        final p1 = data[j][i];
        final p2 = data[j][i + 1];
        canvas.drawLine(
          Offset(
            size.width / xMax! * p1.x,
            size.height - size.height / yMax! * p1.y,
          ),
          Offset(
            size.width / xMax! * p2.x,
            size.height - size.height / yMax! * p2.y,
          ),
          paint,
        );
      }
      for (int i = 0; i < data[j].length; i++) {
        final p1 = data[j][i];
        canvas.drawCircle(
          Offset(
            size.width / xMax! * p1.x,
            size.height - size.height / yMax! * p1.y,
          ),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ChartPainter oldDelegate) => false;

  drawText(
    String text,
    Canvas canvas,
    Size size,
    Offset offset, {
    bool xLabel = true,
  }) {
    const fontSize = 12.0;
    const letterSize = fontSize / 2 + 1;
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    Offset newOffset = Offset(
      offset.dx - textPainter.width / 2 - (xLabel ? 0 : letterSize),
      offset.dy - textPainter.height / 2 + (xLabel ? letterSize : 0),
    );
    textPainter.paint(canvas, newOffset);
  }
}

class Point {
  final double x;
  final double y;

  Point({required this.x, required this.y});
}

List<Point> chartData1 = [
  Point(x: 1, y: 1),
  Point(x: 2, y: 1),
  Point(x: 3, y: 3),
  Point(x: 4, y: 0),
  Point(x: 7, y: 8),
];

List<Point> chartData2 = [
  Point(x: 1, y: 10),
  Point(x: 2, y: 3),
  Point(x: 5, y: 5),
  Point(x: 7, y: 3),
  Point(x: 9, y: 9),
];
