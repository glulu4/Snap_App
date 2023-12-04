import 'dart:js_interop';

import 'package:app/models/task.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
// import 'package:app/views/detailed_task_view.dart';
import 'package:app/views/tasklist_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:developer';


// gloabl key error from her

class TaskListWidget extends StatefulWidget {
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  bool _isLoading = true;
  bool _isInit = true;
  final List<int> options = [1, 2, 3];
  int? priority;
  int? effort;

  // load tasks
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final viewModel = Provider.of<TaskListViewModel>(context, listen: false);
      viewModel.loadTasksFromPreferences().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        // handle errors here
      });
      _isInit = false;
    }
  }


// view task details
  void showTaskDetailsDialog(
    BuildContext context,
    TaskViewModel taskViewModel,
  ) {
    // pop up box of details
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(taskViewModel.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                 Text('Due Date: ${DateFormat('yyyy-MM-dd').format(taskViewModel.dueDate)}', 
                 style: TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text('Category: ${taskViewModel.category}', 
                 style: TextStyle(fontWeight: FontWeight.bold),
                ),
                 Text('Priority: ${taskViewModel.priority}'),
                 Text('Effort: ${taskViewModel.effort}'),
                 Text('Subtask', style: TextStyle(
                    decoration: TextDecoration.underline, ),
                ),
                  if (taskViewModel.task.subtasks.isNotEmpty) ...[
                  for (var subtask in taskViewModel.task.subtasks)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0), // Indent the subtasks
                      child: ListTile(
                        // title: Text(subtask.title),
                        title: Text(subtask.title, style: TextStyle(fontSize: 15.0)),
                        subtitle: Text(
                              'Due: ${DateFormat.yMMMd().format(subtask.dueDate)}')
                        // Other properties of the subtask can be displayed here
                      ),
                    ),
                ]
                 
                // Text('Completed: ${taskViewModel.isCompleted ? 'Yes' : 'No'}'),
              ],
              // Displaying task details
              // ...
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                navigateToEditTask(context, taskViewModel);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteTask(context, taskViewModel);
              },
            ),
          ],
        );
      },
    );
  }

// Function to handle task editing
  void navigateToEditTask(BuildContext context, TaskViewModel taskViewModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TasklistView(
          isEditMode: true,
          initialTaskViewModel: taskViewModel,
        ),
      ),
    );
  }

  // Function to handle task deletion
  void deleteTask(BuildContext context, TaskViewModel taskViewModel) {
    final viewModel = Provider.of<TaskListViewModel>(context, listen: false);
    viewModel.deleteTask(taskViewModel);
    Navigator.of(context).pop(); // Close the dialog
    // Optionally, show a snackbar or other feedback to the user
  }


  // widget list component
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskListViewModel>(context);
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            // width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: AppBar(
                    backgroundColor: const Color.fromRGBO(102, 136, 255, 0.83),
                    title: Text('Tasks'),
                    automaticallyImplyLeading: false,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tooltip(
                        message: 'Filter',
                        child: IconButton(
                          color: Colors.blueGrey[300],
                          hoverColor: Colors.blueGrey[700],
                          icon: Icon(Icons.filter_alt),
                          onPressed: () {
                            // action to be performed when filter button is pressed
                          },
                        ),
                      ),
                      Tooltip(
                        message: "Sort",



                        
                        child: IconButton(
                          icon: Icon(Icons.sort),
                          onPressed: () {
                            // action to be performed when sort button is pressed
                          },
                          color: Colors.blueGrey[300],
                          hoverColor: Colors.blueGrey[700],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    
                    itemCount: viewModel.tasks.length,
                    itemBuilder: (context, index) {
                      final taskViewModel = viewModel.tasks[index];
                      // print(
                      //     'Task: ${taskViewModel.title}, Subtasks: ${taskViewModel.task.subtasks.length}');
                      // print(taskViewModel.toString());
                      
                      return Column(
                        children: [
                        ListTile(
                        
                        title: Text(taskViewModel.title),
                        subtitle: Text(
                                'Due: ${DateFormat.yMMMd().format(taskViewModel.dueDate)}'),
                        

                        onTap: () => showTaskDetailsDialog(context, taskViewModel),
                        trailing: Checkbox(
                          value: taskViewModel.isCompleted,
                          onChanged: (bool? value) {
                            // create a new Task instance with updated values using copyWith
                            Task updatedTask =
                                taskViewModel.task.copyWith(isCompleted: value);

                            // create a new TaskViewModel with the updated Task
                            TaskViewModel updatedTaskViewModel =
                                TaskViewModel(task: updatedTask);

                            // update the task in the viewModel
                            viewModel.editTask(updatedTaskViewModel);
                          },
                        ),

                        
                      ),
                        if (taskViewModel.task.subtasks.isNotEmpty) ...[
                            for (var subtask in taskViewModel.task.subtasks)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0), // Indent the subtasks
                                child: ListTile(
                                  // title: Text(subtask.title),
                                  title: Text('${subtask.title}'),
                                  subtitle: Text(
                                        'Due: ${DateFormat.yMMMd().format(subtask.dueDate)}')
                                  // Other properties of the subtask can be displayed here
                                ),
                              ),
                          ]




                        ],
                      );
                      

                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TasklistView()),
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Color.fromARGB(255, 192, 55, 45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
