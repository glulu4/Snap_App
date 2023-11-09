import 'package:flutter/material.dart';



class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
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
