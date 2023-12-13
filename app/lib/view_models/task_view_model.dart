import 'package:app/models/task.dart';

class TaskViewModel {
  late final Task task;

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

  void set isCompleted(bool value) {
    task.isCompleted = value;
  }

  int get priority {
    return this.task.priority;
  }

  // List<Task> get subtasks {
  //   return this.task.subtasks;
  // }

  // void set subtask(Task? newSubtask) {
  //   task.subtask = newSubtask;
  // }

  int get effort {
    return this.task.effort;
  }

  int get id {
    return this.task.id;
  }
}
