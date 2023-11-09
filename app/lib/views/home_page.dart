import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'task_list.dart'; // task list page
import 'calendar.dart'; // calendar page
import '../Home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Go to Task List Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskList()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Go to Calendar Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
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
              child: Text('Pop up'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text('Pop Up'),
                        content: Text(
                            'hi'
                        ),
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
