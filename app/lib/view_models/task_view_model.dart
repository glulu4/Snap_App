import 'package:app/models/task.dart';

class TaskViewModel {

<<<<<<< Updated upstream
=======
class TaskViewModel {
>>>>>>> Stashed changes
  final Task task;

  TaskViewModel({required this.task});

  String get title {
<<<<<<< Updated upstream
    return this.task.title;
  }

  DateTime get dueDate {
    return this.task.dueDate;
=======
    return task.title;
  }

  String get poster {
    return task.posterUrl;
>>>>>>> Stashed changes
  }

  String get category {
    return this.task.category;
  }

  bool get isCompleted {
    return this.task.isCompleted;
  }

}