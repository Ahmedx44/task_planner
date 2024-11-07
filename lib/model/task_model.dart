import 'dart:ui';
import 'package:uuid/uuid.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String additionalInfo;
  final DateTime startTime;
  final DateTime endTime;
  final String category;
  final String priority;
  final Color? color;
  final bool isCompleted;

  TaskModel({
    String? id, // Make `id` optional
    required this.title,
    required this.description,
    required this.additionalInfo,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.priority,
    required this.color,
    this.isCompleted = false,
  }) : id = id ?? Uuid().v4(); // Generate id if not provided
}
