import 'package:app/view_models/tasklist_view_model.dart';
import 'package:app/views/tasklist_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_page_view.dart'; 
import 'views/calendar_view.dart'; 

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
        routes: {
          '/': (context) => HomePage(),
          '/tasklist': (context) => TasklistView(),
          '/calendar': (context) => CalendarView(),
        },
      ),
    );
  }
}
