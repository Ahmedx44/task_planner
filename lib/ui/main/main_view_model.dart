import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';
import 'package:todo_app/ui/new_task/newTask_view.dart';

class MainViewModel extends BaseViewModel {
  List<TaskModel> _inCompleteTasks = [];
  List<TaskModel> get inCompleteTasks => _inCompleteTasks;

  List<TaskModel> _completeTasks = [];
  List<TaskModel> get completeTasks => _completeTasks;

  List<TaskModel> _lateTasks = [];
  List<TaskModel> get lateTasks => _lateTasks;

  showCreateNewTask(context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const NewtaskView();
      },
    );
  }

  Future<void> getInCompeleteTasks() async {
    final result = await locator<TaskService>().getIncompleteTasks();
    result.fold(
      (error) {
        print(error);
      },
      (success) {
        _inCompleteTasks = success;
        notifyListeners();
      },
    );
  }

  Future<void> getCompeleteTasks() async {
    final result = await locator<TaskService>().getCompleteTasks();
    result.fold(
      (error) {
        print(error);
      },
      (success) {
        _completeTasks = success;
        notifyListeners();
      },
    );
  }

  Future<void> getLateTasks() async {
    final result = await locator<TaskService>().getLateTasks();
    result.fold(
      (error) {
        print(error);
      },
      (success) {
        _lateTasks = success;
        notifyListeners();
      },
    );
  }

  Future<void> refreshContent() async {
    await Future.wait([
      getInCompeleteTasks(),
      getLateTasks(),
      getCompeleteTasks(),
    ]);
  }
}
