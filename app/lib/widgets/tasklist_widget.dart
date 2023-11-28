import 'package:app/models/task.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:app/views/detailed_task_view.dart';
import 'package:app/views/tasklist_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// gloabl key error from her

class TaskListWidget extends StatefulWidget {
  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  bool _isLoading = true;
  bool _isInit = true;

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
                DetailedTaskWidget(key: detailedTaskWidgetKey),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.tasks.length,
                    itemBuilder: (context, index) {
                      final taskViewModel = viewModel.tasks[index];
                      return ListTile(
                        title: Text(taskViewModel.title),
                        onTap: () => detailedTaskWidgetKey.currentState
                            ?.showTaskDetailsDialog(context, taskViewModel),
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
