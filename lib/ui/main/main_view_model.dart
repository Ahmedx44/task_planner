import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';
import 'package:todo_app/ui/new_task/newTask_view.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class MainViewModel extends BaseViewModel {
  final TaskService _taskService = locator<TaskService>();

  // Stream subscriptions
  List<StreamSubscription> _subscriptions = [];

  // Task lists
  List<TaskModel> _incompleteTasks = [];
  List<TaskModel> get incompleteTasks => _incompleteTasks;

  List<TaskModel> _completeTasks = [];
  List<TaskModel> get completeTasks => _completeTasks;

  List<TaskModel> _lateTasks = [];
  List<TaskModel> get lateTasks => _lateTasks;

  List<TaskModel> _allTasks = [];
  List<TaskModel> get allTasks => _allTasks;

  // Initialize data streams
  Future<void> initializeData() async {
    setBusy(true);
    try {
      // Setup stream listeners
      _setupTaskStreams();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _setupTaskStreams() {
    // Clear existing subscriptions
    _clearSubscriptions();

    // Listen to incomplete tasks
    _subscriptions.add(
      _taskService.getIncompleteTasks().listen(
        (result) {
          result.fold(
            (error) => setError(error),
            (tasks) {
              _incompleteTasks = tasks;
              notifyListeners();
            },
          );
        },
        onError: (error) => setError(error.toString()),
      ),
    );

    // Listen to complete tasks
    _subscriptions.add(
      _taskService.getCompleteTasks().listen(
        (result) {
          result.fold(
            (error) => setError(error),
            (tasks) {
              _completeTasks = tasks;
              notifyListeners();
            },
          );
        },
        onError: (error) => setError(error.toString()),
      ),
    );

    // Listen to late tasks
    _subscriptions.add(
      _taskService.getLateTasks().listen(
        (result) {
          result.fold(
            (error) => setError(error),
            (tasks) {
              _lateTasks = tasks;
              notifyListeners();
            },
          );
        },
        onError: (error) => setError(error.toString()),
      ),
    );

    // Listen to all tasks
    _subscriptions.add(
      _taskService.getUserTasks().listen(
        (result) {
          result.fold(
            (error) => setError(error),
            (tasks) {
              _allTasks = tasks;
              notifyListeners();
            },
          );
        },
        onError: (error) => setError(error.toString()),
      ),
    );
  }

  void _clearSubscriptions() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  Future<void> showCreateNewTask(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => const NewtaskView(),
    );

    // Only refresh if a task was actually created
    if (result == true) {
      // No need to manually refresh as streams will automatically update
      notifyListeners();
    }
  }

  void navigateToDetail(BuildContext context, TaskModel task) {
    context.push('/task_detail', extra: task);
  }

  @override
  void dispose() {
    _clearSubscriptions();
    super.dispose();
  }
}
