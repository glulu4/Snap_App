import 'package:app/view_models/task_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:table_calendar/table_calendar.dart';


class TaskListViewModel extends ChangeNotifier {
  List<TaskViewModel> _tasks = <TaskViewModel>[];
  List<TaskViewModel> get tasks => _tasks;


  List<TaskViewModel> getDueTasks(DateTime selectedDate, int numEvents) {
  DateTime today = DateTime.now();
  // Filter tasks that are due and sort them
  int taskCount = 5 - numEvents;
  taskCount > 0 ? taskCount : 0; 

  var dueTasks = tasks
      .where((task) => ((DateTime(task.dueDate.year, task.dueDate.month,
                task.dueDate.day) ==
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day)) || task.dueDate.isAfter(DateTime.now())))
      .toList();

  dueTasks.sort((a, b) {
    int dateComparison = a.dueDate.compareTo(b.dueDate);
    if (dateComparison != 0) return dateComparison;
    int priorityComparison = b.priority.compareTo(a.priority);
    if (priorityComparison != 0) return priorityComparison;
    return b.effort.compareTo(a.effort);
  });
  return dueTasks.take(taskCount).toList(); 
}


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
      Task updatedModel = _tasks[index].task.copyWith(
            title: updatedTask.title,
            dueDate: updatedTask.dueDate,
            category: updatedTask.category,
            isCompleted: updatedTask.isCompleted,
            priority: updatedTask.priority,
            effort: updatedTask.effort,
            // subtasks: updatedTask.subtasks,
          );

      _tasks[index] = TaskViewModel(task: updatedModel);
      saveTasksToPreferences();
      notifyListeners();
    }
  }

  List<TaskViewModel> getTasksForDay(DateTime day) {
  return _tasks.where((taskViewModel) => isSameDay(taskViewModel.task.dueDate, day)).toList();
}


  // save tasks to local storage
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
