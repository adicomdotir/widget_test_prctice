import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_state.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/injection_container.dart'
    as di;

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
              return ListView.builder(
                itemCount: state.reports.length,
                itemBuilder: (context, index) {
                  final report = state.reports[index];
                  return ListTile(
                    title: Text(report.category),
                    subtitle: Text('\$${report.amount.toString()}'),
                  );
                },
              );
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
}
