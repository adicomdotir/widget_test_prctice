import 'package:widget_test_practice/clean_architecture/sample_04/shared/domain/entities/report_entity.dart';

abstract class ReportState {}

class ReportInitialState extends ReportState {}

class ReportLoadingState extends ReportState {}

class ReportLoadedState extends ReportState {
  final List<ReportEntity> reports;

  ReportLoadedState(this.reports);
}

class ReportErrorState extends ReportState {}
