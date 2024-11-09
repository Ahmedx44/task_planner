import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';
import 'dart:async';

@injectable
class CalendarViewModel extends BaseViewModel {
  final TaskService _taskService = locator<TaskService>();

  // Stream subscription
  StreamSubscription? _taskSubscription;

  // State variables
  List<DateTime> _dates = [];
  List<DateTime> get dates => _dates;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  List<Appointment> get appointments => _tasks.map((task) {
        return Appointment(
          startTime: task.startTime,
          endTime: task.endTime,
          subject: task.title,
          color: task.color ?? Colors.grey, // Default color if none is set
        );
      }).toList();

  CalendarViewModel() {
    _generateDates();
    initializeData();
  }

  Future<void> initializeData() async {
    setBusy(true);
    try {
      _setupTaskStream();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void _setupTaskStream() {
    // Cancel existing subscription if any
    _taskSubscription?.cancel();

    // Setup new subscription
    _taskSubscription = _taskService.getUserTasks().listen(
      (result) {
        result.fold(
          (error) => setError(error),
          (tasks) {
            _tasks = tasks;
            notifyListeners();
          },
        );
      },
      onError: (error) => setError(error.toString()),
    );
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void onTaskTapped(TaskModel task) {
    // Handle task tapped. You can navigate or show details.
    print('Task tapped: ${task.title}');
  }

  void _generateDates() {
    final now = DateTime.now();
    _dates = List.generate(
      15,
      (index) => now.add(Duration(days: index - 7)),
    );
    notifyListeners();
  }

  // Refresh data manually if needed
  Future<void> refreshData() async {
    setBusy(true);
    try {
      _setupTaskStream();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    _taskSubscription?.cancel();
    super.dispose();
  }
}
