import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/task_model.dart';

import 'package:intl/intl.dart';
import 'package:todo_app/ui/main/main_view_model.dart';

class MiniCard extends StatelessWidget {
  final TaskModel task;
  MiniCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, viewModel, child) {
        return GestureDetector(
          onTap: () {
            viewModel.navigateToDetail(context, task);
          },
          child: Container(
            padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.02),
            height: MediaQuery.sizeOf(context).height * 0.1,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.category.replaceAll('Category.', ''),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                Text(
                  task.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                Row(
                  children: [
                    const Icon(Icons.watch_later_outlined),
                    Text('${DateFormat('d MMMM yyyy').format(task.endTime)}'),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
