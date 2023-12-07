import 'dart:html';
import 'package:flutter/material.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app/view_models/task_view_model.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar> {
  void _showPopup(BuildContext context, DateTime selectedDate) {
    // Access the TaskListViewModel from the provider
    final taskListViewModel =
        Provider.of<TaskListViewModel>(context, listen: false);

    // Filter the tasks by the selected due date
    List<TaskViewModel> tasksDueOnSelectedDate = taskListViewModel.tasks
        .where((taskViewModel) =>
            DateTime(taskViewModel.dueDate.year, taskViewModel.dueDate.month,
                taskViewModel.dueDate.day) ==
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day))
        .toList();

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Tasks due on ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                // Display the tasks due on the selected date
                ...tasksDueOnSelectedDate.map((taskViewModel) => ListTile(
                      title: Text(taskViewModel.title ?? 'No Title'),
                      subtitle: Text(
                          'Category: ${taskViewModel.category ?? 'No Category'}'),
                      // Display more task details here if needed
                    )),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(102, 136, 255, 0.83),
      elevation: 4.0,

      //title: Text('Snap, The Productivity App'),
      // leading: IconButton(
      //   onPressed: (){},
      //   icon: Image.asset("./SnapIcon.png")
      // ),

      leading: Navigator.canPop(context)
          ? null // If can pop, let Flutter handle the back button

          : InkWell(
              onTap: () {
                // Your action here
              },
              child: Container(
                width: 60, // Set your width and height to the desired size
                height: 60,
                decoration: BoxDecoration(
                    // Add your decoration as needed
                    ),
                child: Center(
                  child:
                      Icon('SnapIcon.png', size: 50.0), // Adjust the size here
                ),
              ),
            ),

      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
          ),
        ),
        IconButton(
          onPressed: () {
            _showPopup(
                context,
                DateTime
                    .now()); // Adjust DateTime.now() to the date you want to filter by
          },
          icon: Icon(Icons.assignment, size: 40.0),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.access_time_filled_rounded, size: 40.0),
        ),
      ],
    );
  }
}
