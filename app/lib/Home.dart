import 'package:flutter/material.dart';
import './views/task_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child:
                    TaskList(), // Wrap TaskList with Expanded to give it a constrained width
              ),
              Expanded(
                child: Text(
                    "Soon to be calendar"), // Wrap Text with Expanded as well if you want it to take up remaining space evenly
              ),
            ],
          ),
        ),
      ),
    );
  }
}
