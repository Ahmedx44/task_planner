import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
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
}
