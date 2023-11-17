import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_test_practice/mock_sample/models/task.dart';

import '../../service/app_service.dart';

part 'home_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  late final TaskService taskService;

  HomeScreenCubit(TaskService service) : super(InitialState()) {
    taskService = service;
  }

  void fetchAllTask() async {
    emit(OnLoading());
    var p = await taskService.getAllTask();
    if (p != null) {
      if (p.isNotEmpty) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in p) {
          if (element.done == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: ''));
    }
  }

  void updateTask(Task task) async {
    var p = await taskService.update(task);
    if (p != null) {
      var p = await taskService.getAllTask();
      if (p != null) {
        if (p.isNotEmpty) {
          List<Task> _com = [];
          List<Task> _unCom = [];
          for (var element in p) {
            if (element.done == true) {
              _com.add(element);
            } else {
              _unCom.add(element);
            }
          }
          emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
        } else {
          emit(OnEmpty());
        }
      }
    } else {
      emit(OnUpdateFailure(error: ''));
    }
  }

  void updateList() async {
    var p = await taskService.getAllTask();
    if (p != null) {
      if (p.isNotEmpty) {
        List<Task> _com = [];
        List<Task> _unCom = [];
        for (var element in p) {
          if (element.done == true) {
            _com.add(element);
          } else {
            _unCom.add(element);
          }
        }
        emit(OnSuccess(completedTasks: _com, unCompletedTasks: _unCom));
      } else {
        emit(OnEmpty());
      }
    } else {
      emit(OnFailure(error: ''));
    }
  }
}
