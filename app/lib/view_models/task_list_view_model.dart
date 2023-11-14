import 'package:app/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/models/task.dart';

// hddjkdjß

class TaskListViewModel extends ChangeNotifier {

  List<TaskViewModel> _tasks = <TaskViewModel>[];

  List<TaskViewModel> get tasks => _tasks;
  
  void addTask(TaskViewModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void editTask(int index, Task updatedTask) {
  if (index >= 0 && index < _tasks.length) {
    _tasks[index] = updatedTask;
    notifyListeners();
  }
}




}