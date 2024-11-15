import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    String? id,
    required this.title,
    required this.description,
    required this.additionalInfo,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.priority,
    required this.color,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  factory TaskModel.fromFirestore(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      additionalInfo: json['additionalInfo'],
      title: json['title'],
      description: json['description'],
      startTime: (json['startTime'] as Timestamp).toDate(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      category: json['category'],
      priority: json['priority'],
      isCompleted: json['isCompleted'],
      color: json['color'],
    );
  }
}
