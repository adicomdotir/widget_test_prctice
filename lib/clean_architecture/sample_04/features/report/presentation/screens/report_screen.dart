import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/core/utils/generate_colors.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/widgets/pie_chart_painter.dart';
import '../../../../injection_container.dart' as di;

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
    final sumAmounts = state.reports
        .map((report) => report.amount)
        .reduce((value, amount) => value + amount);
    final colors = generateColors(Theme.of(context).primaryColor);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: size.height * 0.25,
          width: size.height * 0.25,
          child: CustomPaint(
            painter: PieChartPainter(
              reports: state.reports,
              colors: colors,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              final report = state.reports[index];
              final percent = report.amount * 100 / sumAmounts;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: colors[index],
                ),
                title: Text('${report.category} %${percent.round()}'),
                subtitle: Text('\$${report.amount.toString()}'),
                trailing: Text('Count: ${report.count}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
