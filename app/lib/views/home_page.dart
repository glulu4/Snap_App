// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/task_list.dart'; // task list page
import 'calendar.dart'; // calendar page
import '../Home.dart';
import 'app_bar.dart';
import 'add_task_view.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Go to Task List Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskList()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Go to Calendar Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarView()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Go to real home page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Pop up'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                        title:  Text('Pop Up'),
                        content: Text(
                            'hi'
                        ),
                    ),
                );
              },
            ),
              ElevatedButton(
              child: const Text('Go to add task Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTaskView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
