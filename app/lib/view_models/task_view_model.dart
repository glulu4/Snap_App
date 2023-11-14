import 'package:app/models/task.dart';

class TaskViewModel {

  final Task task;

  TaskViewModel({required this.task});

  String get title {
    return task.title;
  }

  String get poster {
    return task.posterUrl;
  }

  String get category {
    return this.task.category;
  }

  bool get isCompleted {
    return this.task.isCompleted;
  }

}