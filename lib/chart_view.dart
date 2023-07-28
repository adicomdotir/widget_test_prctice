import 'dart:async';
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

class ChartView extends StatefulWidget {
  const ChartView({Key? key}) : super(key: key);

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  Timer? timer;
  List<Point> chartData1 = [];

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int y = Random().nextInt(10);
      chartData1.add(Point(x: chartData1.length.toDouble(), y: y.toDouble()));
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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

    final mergedList = data
        .map((e) => e.map((e) => e).toList())
        .reduce((value, element) => [...value, ...element]);
    xMax = mergedList
        .map((e) => e.x)
        .reduce((value, element) => value > element ? value : element);
    yMax = mergedList
        .map((e) => e.y)
        .reduce((value, element) => value > element ? value : element);
    xMin = mergedList
        .map((e) => e.x)
        .reduce((value, element) => value < element ? value : element);
    yMin = mergedList
        .map((e) => e.y)
        .reduce((value, element) => value < element ? value : element);
    xMax = xMax! + 1;
    xMin = xMin! - 1;
    yMax = yMax! + 1;
    yMin = yMin! - 1;
    final xSize = xMax! - xMin!;
    final ySize = yMax! - yMin!;

    for (var i = 0, k = xMin!; i < xSize; i++, k++) {
      paint.color = Colors.grey.shade800;
      canvas.drawLine(
        Offset(
          size.width / xSize * i,
          0,
        ),
        Offset(
          size.width / xSize * i,
          size.height,
        ),
        paint,
      );
      drawText(
        k.toString(),
        canvas,
        size,
        Offset(size.width / xSize * i, size.height),
      );
    }

    for (var i = 0; i < ySize; i++) {
      paint.color = Colors.grey.shade800;
      canvas.drawLine(
        Offset(
          0,
          size.height / ySize * i,
        ),
        Offset(
          size.width,
          size.height / ySize * i,
        ),
        paint,
      );

      drawText(
        (yMax! - i).toString(),
        canvas,
        size,
        Offset(0, size.height / ySize * i),
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
            size.width / xSize * (p1.x + xMin!.abs()),
            size.height - size.height / ySize * (p1.y + yMin!.abs()),
          ),
          Offset(
            size.width / xSize * (p2.x + xMin!.abs()),
            size.height - size.height / ySize * (p2.y + yMin!.abs()),
          ),
          paint,
        );
      }
      for (int i = 0; i < data[j].length; i++) {
        final p1 = data[j][i];
        canvas.drawCircle(
          Offset(
            size.width / xSize * (p1.x + xMin!.abs()),
            size.height - size.height / ySize * (p1.y + yMin!.abs()),
          ),
          radius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) => true;

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

// List<Point> chartData1 = [
//   Point(x: -1, y: 1),
//   Point(x: 2, y: 1),
//   Point(x: 3, y: 3),
//   Point(x: 4, y: 0),
//   Point(x: 7, y: 8),
// ];

List<Point> chartData2 = [
  Point(x: 1, y: 10),
  Point(x: 2, y: 3),
  Point(x: 5, y: 5),
  Point(x: 7, y: 3),
  Point(x: 9, y: 9),
  Point(x: 11, y: 11),
  Point(x: 12, y: 5),
  Point(x: 20, y: 11),
];
