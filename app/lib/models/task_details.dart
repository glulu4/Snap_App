import 'package:flutter/material.dart';

class TaskDetails {
  final String title;
  final int priority;
  final Task subtask;
  final int effort;
  final DateTime dueDate;
  final String category;
  // final Event calendarEvent;

  TaskDetails(
      {required this.title,
      required this.priority,
      required this.subtask,
      required this.effort,
      required this.dueDate,
      required this.category,
      // required this.calendarEvent
      });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      title: json["Title"],
      priority: json["Priority"],
      subtask: json["Subtask"],
      effort: json["Effort"],
      dueDate: json["Due Date"],
      category: json["Category"],
      // calendarEvent: json[""],
    );
  }
}
