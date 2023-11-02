import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskList Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go Back to Home Page'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
