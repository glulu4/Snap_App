import 'package:app/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetails {
  final String title;
  final DateTime dueDate;
  final String category;
  final bool isCompleted;
  final int priority;
  final Task subtask;
  final int effort;
  
  // final Event calendarEvent;

  TaskDetails(
      {required this.title,
      required this.dueDate,
      required this.category,
      required this.isCompleted,
      required this.priority,
      required this.subtask,
      required this.effort,
      // required this.calendarEvent
      });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      title: json["Title"],
      dueDate: json["Due Date"],
      category: json["Category"],
      isCompleted: json["Completed"],
      priority: json["Priority"],
      subtask: json["Subtask"],
      effort: json["Effort"],
      // calendarEvent: json[""],
    );
  }
}
