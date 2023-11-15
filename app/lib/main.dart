// ignore_for_file: use_key_in_widget_constructors

import 'package:app/view_models/tasklist_view_model.dart';
import 'package:app/views/tasklist_view.dart';
// import 'package:app/widgets/tasklist_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_page_view.dart'; // import the home page
// import 'widgets/tasklist_widget.dart'; // import task list page
import 'views/calendar_view.dart'; // import calendar page

void main() {
  runApp(MyApp());
}

// Main Application Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskListViewModel(),
      child: MaterialApp(
        title: 'Snap App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Define named routes and map them to the corresponding widgets
        routes: {
          '/': (context) => HomePage(),
          '/tasklist': (context) => TasklistView(),
          '/calendar': (context) => CalendarView(),
          // Add as many routes as you have pages
        },
      ),
    );
  }
}
