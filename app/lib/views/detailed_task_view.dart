import 'package:app/models/task.dart';
import 'package:app/task_utils.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

GlobalKey<_DetailedTaskWidgetState> detailedTaskWidgetKey = GlobalKey<_DetailedTaskWidgetState>();

class DetailedTaskWidget extends StatefulWidget {
   DetailedTaskWidget({Key? key}) : super(key: key);

  @override
  _DetailedTaskWidgetState createState() => _DetailedTaskWidgetState();
}

class _DetailedTaskWidgetState extends State<DetailedTaskWidget> {
  // variables
  final _formKey = GlobalKey<FormState>();
  final List<int> options = [1, 2, 3];
  int? priority;
  int? effort;

  // view task details
  void showTaskDetailsDialog(
    BuildContext context,
    TaskViewModel taskViewModel,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(taskViewModel.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Due Date: ${DateFormat('MM/dd/yyyy').format(taskViewModel.dueDate)}'),
                Text('Category: ${taskViewModel.category}'),
                Text('Priority: ${taskViewModel.priority}'),
                Text('Effort: ${taskViewModel.effort}'),
                Text('Completed: ${taskViewModel.isCompleted ? 'Yes' : 'No'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                editTaskDialog(context, taskViewModel);
              },
            ),
            // TextButton(
            //   child: Text('Delete'),
            //   onPressed: () {
            //     final viewModel =
            //         Provider.of<TaskListViewModel>(context, listen: false);
            //     viewModel.deleteTask(taskViewModel);
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        );
      },
    );
  }

  // edit details of task
  void editTaskDialog(BuildContext context, TaskViewModel taskViewModel) {
    // controllers
    TextEditingController titleController =
        TextEditingController(text: taskViewModel.title);
    TextEditingController dueDateController = TextEditingController(
        text: taskViewModel.dueDate.toString().split(' ')[0]);
    TextEditingController categoryController =
        TextEditingController(text: taskViewModel.category);

    // pop up edit dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(taskViewModel.title),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TaskUtils.createTextFormField(
                      controller: titleController,
                      labelText: 'Task Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  TaskUtils.createTextFormField(
                      controller: dueDateController,
                      labelText: 'Due Date',
                      readOnly: true,
                      onTap: () => TaskUtils.selectDate(
                          context, dueDateController, taskViewModel),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a due date';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  TaskUtils.createTextFormField(
                      controller: categoryController,
                      labelText: 'Category',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  TaskUtils.createDropdownButtonFormField(
                    labelText: 'Select a Priority',
                    value: priority,
                    options: options,
                    onChanged: (int? newValue) {
                      setState(() {
                        priority = newValue;
                      });
                    },
                    validator: (int? value) {
                      if (value == null) {
                        return 'Please select a priority';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TaskUtils.createDropdownButtonFormField(
                    labelText: 'Select an Effort',
                    value: effort,
                    options: options,
                    onChanged: (int? newValue) {
                      setState(() {
                        effort = newValue;
                      });
                    },
                    validator: (int? value) {
                      if (value == null) {
                        return 'Please select an effort';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // edit and save task
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // create a new Task instance with updated values
                  Task updatedTask = taskViewModel.task.copyWith(
                    title: titleController.text,
                    dueDate: DateTime.parse(dueDateController.text),
                    category: categoryController.text, 
                    priority: priority ?? 1, 
                    effort: effort ?? 1, 
                  );

                  // update the task in the viewModel
                  Provider.of<TaskListViewModel>(context, listen: false)
                      .editTask(TaskViewModel(task: updatedTask));

                  Navigator.of(context).pop();
                }
              },
            ),

            // delete task
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                final viewModel =
                    Provider.of<TaskListViewModel>(context, listen: false);
                viewModel.deleteTask(taskViewModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    
  }
}
