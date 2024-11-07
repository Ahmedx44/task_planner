import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/service/task_service.dart';
import 'package:todo_app/ui/new_task/newTask_view.dart';

class MainViewModel extends BaseViewModel {
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

  List<TaskModel> _inCompleteTasks = [];

  List<TaskModel> get inCompleteTasks => _inCompleteTasks;

  getInCompeleteTasks(BuildContext context) async {
    final result = await locator<TaskService>().getIncompleteTasks();

    result.fold((error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(error.toString())));
    }, (success) {
      _inCompleteTasks = success;
      notifyListeners();
    });
  }
}
