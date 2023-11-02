import 'package:flutter/material.dart';
import 'views/home_page.dart'; // import the home page
import 'views/task_list.dart'; // import task list page
import 'views/calendar.dart'; // import calendar page

void main() {
  runApp(MyApp());
}

// Main Application Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snap App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define named routes and map them to the corresponding widgets
      routes: {
        '/': (context) => HomePage(),
        '/tasklist': (context) => TaskList(),
        '/calendar': (context) => Calendar(),
        // Add as many routes as you have pages
      },
    );
  }
}