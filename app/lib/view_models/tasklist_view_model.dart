import 'package:app/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskListViewModel extends ChangeNotifier {
  List<TaskViewModel> _tasks = <TaskViewModel>[];

  List<TaskViewModel> get tasks => _tasks;

  // add task to list
  void addTask(TaskViewModel task) {
    _tasks.add(task);
    saveTasksToPreferences();
    notifyListeners();
  }

  // delete task from list
  void deleteTask(TaskViewModel task) {
    _tasks.remove(task);
    saveTasksToPreferences();
    notifyListeners();
  }

  // edit and update task in list
  void editTask(TaskViewModel updatedTask) {
    int index =
        _tasks.indexWhere((task) => task.task.id == updatedTask.task.id);
    if (index != -1) {
      // create new task instance with updated values using copyWith
      Task updatedModel = _tasks[index].task.copyWith(
            // add the properties to update
            title: updatedTask.title,
            dueDate: updatedTask.dueDate,
            category: updatedTask.category,
            isCompleted: updatedTask.isCompleted,
            priority: updatedTask.priority,
            effort: updatedTask.effort,
          );

      // update the TaskViewModel with the new task instance
      _tasks[index] = TaskViewModel(task: updatedModel);

      saveTasksToPreferences();
      notifyListeners();
    }
  }

  // save tasks to local storage for now
  Future<void> saveTasksToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = _tasks
        .map((taskViewModel) => json.encode(taskViewModel.task.toJson()))
        .toList();
    await prefs.setStringList('tasks', tasksString);
  }

  // load tasks from local storage
  Future<void> loadTasksFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksString = prefs.getStringList('tasks') ?? [];
    List<Task> loadedTasks = tasksString
        .map((taskString) => Task.fromJson(json.decode(taskString)))
        .toList();

    _tasks = loadedTasks.map((task) => TaskViewModel(task: task)).toList();
    notifyListeners();
  }
  
}
