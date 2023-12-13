import 'dart:html';
import 'package:app/models/task.dart';
import 'package:app/view_models/eventlist_view_model.dart';
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
    final taskListViewModel =
        Provider.of<TaskListViewModel>(context, listen: false);

  final eventListViewModel =
          Provider.of<EventListViewModel>(context, listen: false);

      int numEvents = eventListViewModel.getEventsForDay(selectedDate).length;

   // Use the getDueTasks method to filter tasks
    List<TaskViewModel> tasksDueOnSelectedDate = taskListViewModel.getDueTasks(selectedDate, numEvents);

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
                    'Agenda for ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                // Display the numbered tasks due on the selected date
                ...tasksDueOnSelectedDate.asMap().entries.map((entry) {
                  int taskNumber = entry.key + 1; 
                  TaskViewModel taskViewModel = entry.value;

                  return ListTile(
                    leading: Text('$taskNumber'), 
                    title: Text(taskViewModel.task.title ?? 'No Title'),
                    subtitle: Text('Category: ${taskViewModel.category ?? 'No Category'}'),
                  );
                }).toList(),
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

      leading: Navigator.canPop(context)
          ? null 
          : InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage('SnapIcon.png'),
                width: 900,
                fit: BoxFit.cover,
              ),
            ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            _showPopup(
                context,
                DateTime
                    .now());
          },
          icon: Icon(Icons.assignment, size: 40.0),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.access_time_filled_rounded, size: 40.0),
          color: Colors.white,
        ),
      ],
    );
  }
}
