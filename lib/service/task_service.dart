import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/task_model.dart';

abstract class TaskService {
  Future<Either<String, String>> addTask(TaskModel taskModel);
  Stream<Either<String, List<TaskModel>>> getUserTasks();
  Stream<Either<String, List<TaskModel>>> getIncompleteTasks();
  Stream<Either<String, List<TaskModel>>> getCompleteTasks();
  Stream<Either<String, List<TaskModel>>> getLateTasks();
  Future<Either<String, String>> compeleteTask(String id);
  Future<Either<String, String>> deleteTask(String id);
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
  Stream<Either<String, List<TaskModel>>> getUserTasks() async* {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
      final userStream = userRef.snapshots();

      yield* userStream.asyncMap((userDoc) async {
        if (!userDoc.exists) {
          return const Left('User document does not exist');
        }

        final taskIds = List<String>.from(userDoc.data()?['tasks'] ?? []);
        if (taskIds.isEmpty) return const Right([]);

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
      });
    } catch (e) {
      yield Left('Failed to retrieve tasks: $e');
    }
  }

  @override
  Stream<Either<String, List<TaskModel>>> getIncompleteTasks() async* {
    try {
      final tasksStream = FirebaseFirestore.instance
          .collection('tasks')
          .where('isCompleted', isEqualTo: false)
          .snapshots();

      yield* tasksStream.map((querySnapshot) {
        final tasks = querySnapshot.docs.map((doc) {
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
            color: data['color'] != null ? Color(data['color']) : null,
            isCompleted: data['isCompleted'],
          );
        }).toList();

        return Right(tasks);
      });
    } catch (e) {
      yield Left('Error retrieving tasks: $e');
    }
  }

  @override
  Stream<Either<String, List<TaskModel>>> getCompleteTasks() async* {
    try {
      final tasksStream = FirebaseFirestore.instance
          .collection('tasks')
          .where('isCompleted', isEqualTo: true)
          .snapshots();

      yield* tasksStream.map((querySnapshot) {
        final tasks = querySnapshot.docs.map((doc) {
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
            color: data['color'] != null ? Color(data['color']) : null,
            isCompleted: data['isCompleted'],
          );
        }).toList();

        return Right(tasks);
      });
    } catch (e) {
      yield Left('Error retrieving tasks: $e');
    }
  }

  @override
  Stream<Either<String, List<TaskModel>>> getLateTasks() async* {
    try {
      final tasksStream = FirebaseFirestore.instance
          .collection('tasks')
          .where('isCompleted', isEqualTo: false)
          .snapshots();

      yield* tasksStream.map((querySnapshot) {
        final lateTasks = querySnapshot.docs.where((doc) {
          final endTime = (doc.data()['endTime'] as Timestamp).toDate();
          return endTime.isBefore(DateTime.now());
        }).map((doc) {
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
            color: data['color'] != null ? Color(data['color']) : null,
            isCompleted: data['isCompleted'],
          );
        }).toList();

        return Right(lateTasks);
      });
    } catch (e) {
      yield Left('Error retrieving late tasks: $e');
    }
  }

  @override
  Future<Either<String, String>> compeleteTask(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(id)
          .update({'isCompleted': true});
      return const Right('Successfully updated');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteTask(String id) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
      return const Right('Deleted');
    } catch (e) {
      return const Left('Some Error occured');
    }
  }
}
