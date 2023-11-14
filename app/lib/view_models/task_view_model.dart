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

}