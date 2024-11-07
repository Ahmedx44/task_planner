import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.14,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: task.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            width: MediaQuery.sizeOf(context).width * 0.03,
            height: MediaQuery.sizeOf(context).height * 0.2,
          ),

          // Task details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.category.replaceAll('Category.', ''),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    decoration: BoxDecoration(
                      color: task.priority == 'Urgent'
                          ? Colors.red
                          : task.priority == 'High'
                              ? Colors.yellow
                              : task.priority == 'Medium'
                                  ? Colors.blue
                                  : task.priority == 'Low'
                                      ? Colors.green
                                      : Colors
                                          .grey, // Default color if no match
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      task.priority,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          height: 7,
                          width: 7,
                        ),
                        Text(
                            'Till ${DateFormat('d MMMM yyyy').format(task.endTime)}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
