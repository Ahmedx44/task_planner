import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/ui/task_detail/task_detail_view_model.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;

  const TaskDetailView({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => TaskDetailViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  viewModel.navigateBack(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).colorScheme.onSecondary,
                )),
            title: Text(
              'Task Details',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 10),
                // Priority
                Row(
                  children: [
                    const Icon(Icons.priority_high,
                        size: 20, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      '${task.priority} Priority',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Category
                Row(
                  children: [
                    const Icon(Icons.category, size: 20, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      'Category: ${task.category}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Description
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  task.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                // Additional Info
                Text(
                  'Additional Information:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  task.additionalInfo,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                // Start Time
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 20, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      'Start Date: ${task.startTime.toLocal()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // End Time
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 20, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      'End Date: ${task.endTime.toLocal()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Completion Status
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      task.isCompleted
                          ? 'Status: Completed'
                          : 'Status: Incomplete',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Complete Task Button
                ElevatedButton(
                  onPressed: () {
                    viewModel.markCompelete(context, task.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Complete Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Delete Task Button
                OutlinedButton(
                  onPressed: () {
                    viewModel.showDeleteDialog(context, task.id);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Delete Task',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
