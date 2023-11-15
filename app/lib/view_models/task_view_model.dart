import 'package:app/models/task.dart';

class TaskViewModel {

  final Task task;

  TaskViewModel({required this.task});

  String get title {
    return this.task.title;
  }

  DateTime get dueDate {
    return this.task.dueDate;
  }

  String get category {
    return this.task.category;
  }

  bool get isCompleted {
    return this.task.isCompleted;
  }

  void set isCompleted(bool) {
   task.isCompleted = bool;
  }

  int get priority {
    return this.task.priority;
  }

  // Task? get subtask {
  //   return this.task.subtask;
  // }

  int get effort {
    return this.task.effort;
  }

  int get id {
    return this.task.id;
  }

}