import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/clean_architecture/sample_06/features/dashboard/presentation/state/dashboard_state.dart';

class DashboardController extends Cubit<DashboardState> {
  DashboardController() : super(const DashboardState());

  void setPageIndex(int value) {
    emit(state.copyWith(pageIndex: value));
  }
}
