import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';

@injectable
class CalendarViewModel extends BaseViewModel {
  List<DateTime> dates = [];
  DateTime selectedDate = DateTime.now();
  List<TaskModel> tasks = [];

  CalendarViewModel() {
    _generateDates();
  }

  List<Appointment> get appointments {
    return tasks.map((task) {
      return Appointment(
        startTime: task.startTime,
        endTime: task.endTime,
        subject: task.title,
        color: task.color ?? Colors.grey, // Default color if none is set
      );
    }).toList();
  }

  Future<void> loadUserTasks() async {
    setBusy(true);
    final result = await locator<TaskService>().getUserTasks();
    result.fold(
      (failure) {
        print('Error: $failure');
      },
      (tasks) {
        this.tasks = tasks; // Update the tasks list
      },
    );
    setBusy(false);
    notifyListeners();
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void onTaskTapped(TaskModel task) {
    print('Task tapped: ${task.title}');
    // Handle task tapped. You can navigate or show details.
  }

  void _generateDates() {
    final now = DateTime.now();
    for (int i = -7; i <= 7; i++) {
      dates.add(now.add(Duration(days: i)));
    }
    notifyListeners();
  }
}
