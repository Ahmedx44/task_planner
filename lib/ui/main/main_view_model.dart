import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';
import 'package:todo_app/ui/new_task/newTask_view.dart';
import 'package:go_router/go_router.dart';

class MainViewModel extends BaseViewModel {
  final _taskService = locator<TaskService>();

  List<TaskModel> _inCompleteTasks = [];
  List<TaskModel> get inCompleteTasks => _inCompleteTasks;

  List<TaskModel> _completeTasks = [];
  List<TaskModel> get completeTasks => _completeTasks;

  List<TaskModel> _lateTasks = [];
  List<TaskModel> get lateTasks => _lateTasks;

  List<TaskModel> _allTasks = [];
  List<TaskModel> get allTasks => _allTasks;

  Future<void> initializeData() async {
    await refreshContent();
  }

  void showCreateNewTask(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => const NewtaskView(),
    );
    // Refresh data after adding new task
    await refreshContent();
  }

  Future<void> getAllTasks() async {
    final result = await locator<TaskService>().getUserTasks();
    result.fold((sucess) {}, (sucess) {
      _allTasks = sucess;
    });
  }

  Future<void> refreshContent() async {
    setBusy(true);
    try {
      await Future.wait([
        fetchIncompleteTasks(),
        fetchCompleteTasks(),
        fetchLateTasks(),
      ]);
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchIncompleteTasks() async {
    final result = await _taskService.getIncompleteTasks();
    result.fold(
      (error) => setError(error),
      (tasks) {
        _inCompleteTasks = tasks;
        notifyListeners();
      },
    );
  }

  Future<void> fetchCompleteTasks() async {
    final result = await _taskService.getCompleteTasks();
    result.fold(
      (error) => setError(error),
      (tasks) {
        _completeTasks = tasks;
        notifyListeners();
      },
    );
  }

  Future<void> fetchLateTasks() async {
    final result = await _taskService.getLateTasks();
    result.fold(
      (error) => setError(error),
      (tasks) {
        _lateTasks = tasks;
        notifyListeners();
      },
    );
  }

  navigateToDetail(BuildContext context, TaskModel task) {
    context.push('/task_detail', extra: task);
  }
}
