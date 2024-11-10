import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/app/locator.dart';
import 'package:todo_app/service/task_service.dart';
import 'package:go_router/go_router.dart';

class TaskDetailViewModel extends BaseViewModel {
  markCompelete(BuildContext context, String id) async {
    final result = await locator<TaskService>().compeleteTask(id);

    result.fold((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(error.toString())));
    }, (suceess) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(suceess.toString())));
    });
  }

  deleteTask(BuildContext context, String id) async {
    final result = await locator<TaskService>().deleteTask(id);

    result.fold((error) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(error.toString())));
    }, (suceess) {
      context.pop(context);
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(suceess.toString())));
    });
  }

  void showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure you want to delete this task?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          deleteTask(context, id);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  navigateBack(BuildContext context) {
    context.pop();
  }
}
