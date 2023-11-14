import 'package:app/models/task.dart';
import 'package:app/models/task_details.dart';

class TaskDetailsViewModel {

  final TaskDetails taskDetails;

  TaskDetailsViewModel({required this.taskDetails});

  String get title {
    return this.taskDetails.title;
  }

  int get priority {
    return this.taskDetails.priority;
  }

  Task get subtask {
    return this.taskDetails.subtask;
  }

  int get effort {
    return this.taskDetails.effort;
  }

  DateTime get dueDate {
    return this.taskDetails.dueDate;
  }

  String get category {
    return this.taskDetails.category;
  }

  bool get isCompleted {
    return this.taskDetails.isCompleted;
  }

}