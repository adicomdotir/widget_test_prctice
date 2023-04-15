import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/convertors.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

class PieChartPainter extends CustomPainter {
  final List<ReportEntity> reports;
  final List<Color> colors;

  PieChartPainter({required this.reports, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final ovalSize = size.height;
    final rect = Rect.fromLTWH(
      0,
      0,
      ovalSize,
      ovalSize,
    );

    final sumAmounts = reports
        .map((report) => report.amount)
        .reduce((value, amount) => value + amount);

    double startDegree = 0;
    int colorIndex = 0;

    for (ReportEntity report in reports) {
      double percent = report.amount * 100 / sumAmounts;
      double degree = percent * 360 / 100;
      Path path = Path();
      path.moveTo(ovalSize / 2, ovalSize / 2);
      path.arcTo(
        rect,
        degreeToRadian(startDegree),
        degreeToRadian(degree),
        false,
      );
      path.close();
      Paint paint = Paint()..color = colors[colorIndex % colors.length];
      colorIndex += 1;
      canvas.drawPath(path, paint);
      startDegree += degree;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
