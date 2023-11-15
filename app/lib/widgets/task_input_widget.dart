import 'package:app/models/task.dart';
import 'package:app/task_utils.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TaskInputWidget extends StatefulWidget {
  @override
  _TaskInputWidgetState createState() => _TaskInputWidgetState();
}

class _TaskInputWidgetState extends State<TaskInputWidget> {
  
  // variables & controllers
  int? priority;
  int? effort;
  final List<int> options = [1, 2, 3];
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dueDateController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    dueDateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  // create task
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final viewModel = Provider.of<TaskListViewModel>(context, listen: false);

      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
        title: titleController.text,
        dueDate: DateTime.parse(dueDateController.text), // Example date
        category: categoryController.text, // Example category
        priority: priority ?? 1, // Example priority
        effort: effort ?? 1, // Example effort
        isCompleted: false,
      );

      viewModel.addTask(TaskViewModel(task: task));
      titleController.clear();
      dueDateController.clear();
      categoryController.clear();
      // Reset priority and effort
      setState(() {
        priority = null;
        effort = null;
      });

    } else {
      print('Form is not valid');
    }
  }

  // input form widget
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskListViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            'Add a Task:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [

                  TaskUtils.createTextFormField(
                      controller: titleController,
                      labelText: 'Task Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  TaskUtils.createTextFormField(
                    
                      controller: dueDateController,
                      labelText: 'Due Date',
                      readOnly: true,
                      onTap: () => TaskUtils.selectDate(
                          context, dueDateController, null),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a due date';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  TaskUtils.createTextFormField(
                      controller: categoryController,
                      labelText: 'Category',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
