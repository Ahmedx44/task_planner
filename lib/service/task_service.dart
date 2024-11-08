import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/task_model.dart';

abstract class TaskService {
  Future<Either<String, String>> addTask(TaskModel taskModel);
  Future<Either<String, List<TaskModel>>> getUserTasks();
  Future<Either<String, List<TaskModel>>> getIncompleteTasks();
  Future<Either<String, List<TaskModel>>> getCompleteTasks();
  Future<Either<String, List<TaskModel>>> getLateTasks();
}

@LazySingleton(as: TaskService)
class TaskServiceImpl extends TaskService {
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<Either<String, String>> addTask(TaskModel taskModel) async {
    try {
      final newTaskRef = FirebaseFirestore.instance.collection('tasks').doc();

      final taskData = {
        'id': newTaskRef.id,
        'title': taskModel.title,
        'description': taskModel.description,
        'additionalInfo': taskModel.additionalInfo,
        'startTime': taskModel.startTime,
        'endTime': taskModel.endTime,
        'category': taskModel.category,
        'priority': taskModel.priority,
        'color': taskModel.color?.value,
        'isCompleted': taskModel.isCompleted,
      };

      await newTaskRef.set(taskData);
      final userRef = FirebaseFirestore.instance.collection('User').doc(user);
      await userRef.update({
        'tasks': FieldValue.arrayUnion([newTaskRef.id]),
      });

      return const Right('Task Successfully Added');
    } catch (e) {
      return const Left('Some error occurred');
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getUserTasks() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userRef = FirebaseFirestore.instance.collection('User').doc(userId);

      final userDoc = await userRef.get();
      final taskIds = List<String>.from(userDoc.data()?['tasks'] ?? []);

      final tasksQuery = await FirebaseFirestore.instance
          .collection('tasks')
          .where(FieldPath.documentId, whereIn: taskIds)
          .get();

      final tasks = tasksQuery.docs.map((doc) {
        final data = doc.data();
        return TaskModel(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          additionalInfo: data['additionalInfo'],
          startTime: (data['startTime'] as Timestamp).toDate(),
          endTime: (data['endTime'] as Timestamp).toDate(),
          category: data['category'],
          priority: data['priority'],
          color: Color(data['color']),
          isCompleted: data['isCompleted'],
        );
      }).toList();

      return Right(tasks);
    } catch (e) {
      return Left('Failed to retrieve tasks: $e');
    }
  }

  Future<Either<String, List<TaskModel>>> getIncompleteTasks() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('User').doc(user);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        final taskIds = List<String>.from(userDoc.data()?['tasks'] ?? []);

        final tasks = await Future.wait(
          taskIds.map((id) => FirebaseFirestore.instance
              .collection('tasks')
              .doc(id)
              .get()
              .then((doc) => doc.data())),
        );

        final incompleteTasks = tasks
            .whereType<Map<String, dynamic>>()
            .where((task) =>
                !task['isCompleted'] &&
                task['endTime'].toDate().isAfter(DateTime
                    .now())) // uncompleted tasks and also tasks that are on past they're end time
            .map((task) => TaskModel(
                  id: task['id'],
                  title: task['title'],
                  description: task['description'],
                  additionalInfo: task['additionalInfo'],
                  startTime: (task['startTime'] as Timestamp).toDate(),
                  endTime: (task['endTime'] as Timestamp).toDate(),
                  category: task['category'],
                  priority: task['priority'],
                  color: task['color'] != null ? Color(task['color']) : null,
                  isCompleted: task['isCompleted'],
                ))
            .toList();

        return Right(incompleteTasks);
      } else {
        return const Left('User document does not exist');
      }
    } catch (e) {
      return Left('Error retrieving tasks: $e');
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getCompleteTasks() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('User').doc(user);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        final taskIds = List<String>.from(userDoc.data()?['tasks'] ?? []);

        final tasks = await Future.wait(
          taskIds.map((id) => FirebaseFirestore.instance
              .collection('tasks')
              .doc(id)
              .get()
              .then((doc) => doc.data())),
        );

        final completeTasks = tasks
            .whereType<Map<String, dynamic>>()
            .where(
                (task) => task['isCompleted']) //tasks that are complete or true
            .map((task) => TaskModel(
                  id: task['id'],
                  title: task['title'],
                  description: task['description'],
                  additionalInfo: task['additionalInfo'],
                  startTime: (task['startTime'] as Timestamp).toDate(),
                  endTime: (task['endTime'] as Timestamp).toDate(),
                  category: task['category'],
                  priority: task['priority'],
                  color: task['color'] != null ? Color(task['color']) : null,
                  isCompleted: task['isCompleted'],
                ))
            .toList();

        return Right(completeTasks);
      } else {
        return const Left('User document does not exist');
      }
    } catch (e) {
      return Left('Error retrieving tasks: $e');
    }
  }

  @override
  Future<Either<String, List<TaskModel>>> getLateTasks() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('User').doc(user);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        final taskIds = List<String>.from(userDoc.data()?['tasks'] ?? []);

        final tasks = await Future.wait(
          taskIds.map((id) => FirebaseFirestore.instance
              .collection('tasks')
              .doc(id)
              .get()
              .then((doc) => doc.data())),
        );

        final completeTasks = tasks
            .whereType<Map<String, dynamic>>()
            .where((task) =>
                !task['isCompleted'] &&
                task['endTime'].toDate().isBefore(DateTime.now()))
            .map((task) => TaskModel(
                  id: task['id'],
                  title: task['title'],
                  description: task['description'],
                  additionalInfo: task['additionalInfo'],
                  startTime: (task['startTime'] as Timestamp).toDate(),
                  endTime: (task['endTime'] as Timestamp).toDate(),
                  category: task['category'],
                  priority: task['priority'],
                  color: task['color'] != null ? Color(task['color']) : null,
                  isCompleted: task['isCompleted'],
                ))
            .toList();

        print(completeTasks.length);
        return Right(completeTasks);
      } else {
        return const Left('User document does not exist');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
