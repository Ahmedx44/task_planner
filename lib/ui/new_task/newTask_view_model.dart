import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewtaskViewModel extends BaseViewModel {
  List<String> subtasks = [];

  void addSubtask() {
    subtasks.add("");
    notifyListeners();
  }

  void updateSubtask(int index, String value) {
    subtasks[index] = value;
    notifyListeners();
  }

  void deleteSubtask(int index) {
    subtasks.removeAt(index);
    notifyListeners();
  }

  void showDatePicker(BuildContext context, ValueNotifier<DateTime> date) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: Theme.of(context).colorScheme.surface,
          child: CupertinoDatePicker(
            backgroundColor: Theme.of(context).colorScheme.surface,
            initialDateTime: date.value,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime newDate) {
              date.value = DateTime(
                newDate.year,
                newDate.month,
                newDate.day,
                date.value.hour,
                date.value.minute,
              );
            },
          ),
        );
      },
    );
  }

  final priorities = {
    'Low': Colors.green,
    'Medium': Colors.blue,
    'High': Colors.yellow,
    'Urgent': Colors.red,
  };
  final colors = {
    'lightblue': Colors.lightBlue,
    'blue': Colors.blue,
    'pink': Colors.pink,
    'lightpink': Colors.pinkAccent,
    'purple': Colors.purple,
    'lightpurple': Colors.purpleAccent
  };
}
