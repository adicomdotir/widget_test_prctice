import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/generate_colors.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/injection_container.dart'
    as di;
import 'dart:math' as math;

import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.inject.get<ReportBloc>()..add(GetReportEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Report'),
        ),
        body: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state is ReportLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is ReportLoadedState) {
              if (state.reports.isEmpty) {
                return const Text('Not Data');
              }
              return content(context, state);
            } else if (state is ReportErrorState) {
              return const Text('Error');
            } else {
              return Text(state.runtimeType.toString());
            }
          },
        ),
      ),
    );
  }

  Widget content(BuildContext context, ReportLoadedState state) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: size.width,
          child: CustomPaint(
            painter: PieChartClipper(state.reports,
                color: Theme.of(context).primaryColor),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              final report = state.reports[index];
              return ListTile(
                title: Text(report.category),
                subtitle: Text('\$${report.amount.toString()}'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PieChartClipper extends CustomPainter {
  final List<ReportEntity> reports;
  final Color color;

  PieChartClipper(this.reports, {required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final colors = generateColors(color);

    final ovalSize = size.width / 2;
    final rect = Rect.fromLTWH(
      size.width / 2 - ovalSize / 2,
      size.height / 2 - ovalSize / 2,
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
      path.moveTo(size.width / 2, size.height / 2);
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
    return true;
  }
}

double degreeToRadian(double degree) {
  return degree * math.pi / 180;
}
