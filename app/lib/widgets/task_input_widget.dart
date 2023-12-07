import 'package:app/view_models/combined_view_model.dart';
import 'package:app/view_models/eventlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/models/task.dart';
import 'package:app/task_utils.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:intl/intl.dart';

class TaskInputWidget extends StatefulWidget {
  final bool isEditMode; // to determine if it's edit mode
  final TaskViewModel? initialTaskViewModel; // the task to be edited, if in edit mode
//  final Event? initialEvent; // the event to be edited, if in edit mode

  TaskInputWidget({this.isEditMode = false, this.initialTaskViewModel});

  @override
  _TaskInputWidgetState createState() => _TaskInputWidgetState();
}

class _TaskInputWidgetState extends State<TaskInputWidget> {
  int? priority;
  int? effort;
  bool isAddingSubtask = false;
  // List<Task> subtasks = [];
  final List<int> options = [1, 2, 3];
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dueDateController = TextEditingController();
  final categoryController = TextEditingController();
  final subtaskTitleController = TextEditingController();
  final subtaskDueDateController = TextEditingController();
  // Color _selectedColor = Colors.blue;

  @override
  void dispose() {
    titleController.dispose();
    dueDateController.dispose();
    categoryController.dispose();
    // subtaskTitleController.dispose();
    // subtaskDueDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode && widget.initialTaskViewModel != null) {
      // Initialize fields with the existing task data
      titleController.text = widget.initialTaskViewModel!.title;
      dueDateController.text = DateFormat('yyyy-MM-dd')
          .format(widget.initialTaskViewModel!.dueDate)
          .toString();
      categoryController.text =
          widget.initialTaskViewModel!.category.toString();
      priority = widget.initialTaskViewModel!.priority;
      effort = widget.initialTaskViewModel!.effort;
      // subtasks = List.from(widget.initialTaskViewModel!.subtasks);
    }
  }

  void _clearFormFields() {
    titleController.clear();
    dueDateController.clear();
    categoryController.clear();
    // subtaskTitleController.clear();
    // subtaskDueDateController.clear();
    setState(() {
      priority = null;
      effort = null;
      // subtasks.clear();
      isAddingSubtask = false;
    });
  }

  // void _addSubtask() {
  //   if (_formKey.currentState!.validate()) {
  //     final subtask = Task(
  //       id: DateTime.now().millisecondsSinceEpoch,
  //       title: subtaskTitleController.text,
  //       dueDate: DateTime.parse(subtaskDueDateController.text),
  //       category: categoryController.text,
  //       priority: priority ?? 1,
  //       effort: effort ?? 1,
  //       isCompleted: false,
  //     );

  //     setState(() {
  //       subtasks.add(subtask);
  //       subtaskTitleController.clear();
  //       subtaskDueDateController.clear();
  //     });
  //   }
  // }



  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('Submitting with subtasks: ${subtasks.length}');
      final viewModel = Provider.of<TaskListViewModel>(context, listen: false);
      final combinedViewModel = Provider.of<CombinedViewModel>(context, listen: false);
      if (widget.isEditMode) {

        // Handle task edit logic here
        // create a new Task instance with updated values
        Task updatedTask = widget.initialTaskViewModel!.task.copyWith(
          title: titleController.text,
          dueDate: DateTime.parse(dueDateController.text),
          category:categoryController.text,
          priority: priority ?? 1,
          effort: effort ?? 1,
          // subtasks: subtasks,
          // event: event,
        );

        // update the task in the viewModel
        Provider.of<TaskListViewModel>(context, listen: false)
            .editTask(TaskViewModel(task: updatedTask));

        combinedViewModel.updateSelectedDay(updatedTask.dueDate);

        Navigator.of(context).pop();
        viewModel.editTask(TaskViewModel(task: updatedTask));
        combinedViewModel.updateSelectedDay(updatedTask.dueDate);
      } else {
        final task = Task(
          id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
          title: titleController.text,
          dueDate: DateTime.parse(dueDateController.text),
          category: categoryController.text,
          priority: priority ?? 1,
          effort: effort ?? 1,
          isCompleted: false,
          // subtasks: subtasks,
        );

        viewModel.addTask(TaskViewModel(task: task));
        combinedViewModel.updateSelectedDay(task.dueDate);
      }
      _clearFormFields();
      // reset priority and effort
      setState(() {
        priority = null;
        effort = null;
      });
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the UI elements based on the mode
    String headerText = widget.isEditMode ? 'Edit Task:' : 'Add a Task:';
    String buttonText = widget.isEditMode ? 'Save Changes' : 'Add Task';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            headerText,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTaskInputFields(),
                  const SizedBox(height: 20),
                  
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                          ),
                          onPressed: _submitForm,
                          child: Text(buttonText),
                        ),
                        const SizedBox(height: 20),
                        // if (!isAddingSubtask && !widget.isEditMode)
                        //   ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.black,
                        //       foregroundColor: Colors.white,
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 20, horizontal: 20),
                        //     ),
                        //     onPressed: () {
                        //       setState(() {
                        //         isAddingSubtask = true;
                        //       });
                        //     },
                        //     child: const Text('Add Sub-Task'),
                        //   ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // form for task input
  Widget _buildTaskInputFields() {
    return Column(
      children: [
        TaskUtils.createTextFormField(
            controller: titleController,
            labelText: 'Task Name',
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a task name'
                : null),
        const SizedBox(height: 20),
        TaskUtils.createTextFormField(
            controller: dueDateController,
            labelText: 'Due Date',
            readOnly: true,
            onTap: () => TaskUtils.selectDate(context, dueDateController, null),
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a due date'
                : null),
        const SizedBox(height: 20),
        TaskUtils.createTextFormField(
            controller: categoryController,
            labelText: 'Category',
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a category'
                : null),
        const SizedBox(height: 20),
        TaskUtils.createDropdownButtonFormField(
          labelText: 'Select a Priority',
          value: priority,
          options: options,
          onChanged: (int? newValue) => setState(() => priority = newValue),
          validator: (int? value) =>
              value == null ? 'Please select a priority' : null,
        ),
        const SizedBox(height: 20),
        TaskUtils.createDropdownButtonFormField(
          labelText: 'Select an Effort',
          value: effort,
          options: options,
          onChanged: (int? newValue) => setState(() => effort = newValue),
          validator: (int? value) =>
              value == null ? 'Please select an effort' : null,
        ),
      ],
    );
  }

  // subtask form inputs
  // Widget _buildSubtaskInputFields() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 30.0, top: 30.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             IconButton(
  //               onPressed: _addSubtask,
  //               icon: Icon(Icons.add),
  //             ),
  //             IconButton(
  //               onPressed: () => setState(() => isAddingSubtask = false),
  //               icon: Icon(Icons.close),
  //             ),
  //           ],
  //         ),
  //         TaskUtils.createTextFormField(
  //             controller: subtaskTitleController,
  //             labelText: 'Subtask Name',
  //             validator: (value) => value == null || value.isEmpty
  //                 ? 'Please enter a subtask name'
  //                 : null),
  //         const SizedBox(height: 20),
  //         TaskUtils.createTextFormField(
  //             controller: subtaskDueDateController,
  //             labelText: 'Subtask Due Date',
  //             readOnly: true,
  //             onTap: () =>
  //                 TaskUtils.selectDate(context, subtaskDueDateController, null),
  //             validator: (value) => value == null || value.isEmpty
  //                 ? 'Please enter a subtask due date'
  //                 : null),
  //         const SizedBox(height: 20),
  //         for (var subtask in subtasks)
  //           ListTile(
  //             title: Text(subtask.title),
  //             subtitle: Text(
  //                 'Due Date: ${DateFormat('yyyy-MM-dd').format(subtask.dueDate)}'),
  //             trailing: IconButton(
  //               icon: Icon(Icons.delete),
  //               onPressed: () {
  //                 setState(() {
  //                   subtasks.remove(subtask);
  //                 });
  //               },
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }
}
