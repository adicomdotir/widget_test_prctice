import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/domain/use_cases/get_report_use_case.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_event.dart';
import 'package:widget_test_practice/clean_architecture/sample_04/features/report/presentation/bloc/report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetReportUseCase getReportUseCase;

  ReportBloc(this.getReportUseCase) : super(ReportInitialState()) {
    on<GetReportEvent>((event, emit) async {
      emit(ReportLoadingState());
      final result = await getReportUseCase();
      emit(ReportLoadedState(result));
    });
  }
}
