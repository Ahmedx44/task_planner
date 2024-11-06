import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/model/task_model.dart';

abstract class TaskService {
  Future<Either<String, String>> addTask(TaskModel taskModel);
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
        'color': taskModel.color.value,
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
}
