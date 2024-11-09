import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/service/task_service.dart';

class TaskDetailViewModel extends BaseViewModel {
  markCompelete(BuildContext context, String id) async {
    final result = await locator<TaskService>().compeleteTask(id);

    result.fold((error) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }, (suceess) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(suceess.toString())));
    });
  }

  deleteTask(BuildContext context, String id) async {
    final result = await locator<TaskService>().deleteTask(id);

    result.fold((error) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }, (suceess) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(suceess.toString())));
    });
  }
}
