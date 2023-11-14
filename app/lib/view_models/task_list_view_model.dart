import 'package:app/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskListViewModel extends ChangeNotifier {
  List<TaskViewModel> _tasks = <TaskViewModel>[];

  List<TaskViewModel> get tasks => _tasks;

  void addTask(TaskViewModel task) {
    _tasks.add(task);
    saveTasksToPreferences(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void editTask(int index, TaskViewModel updatedTask) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void saveTasksToPreferences(List<Task> tasks) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> tasksString = tasks.map((task) => json.encode(task.toJson())).toList();
  await prefs.setStringList('tasks', tasksString);
}

Future<List<Task>> loadTasksFromPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> tasksString = prefs.getStringList('tasks') ?? [];
  return tasksString.map((taskString) => Task.fromJson(json.decode(taskString))).toList();
}

}
