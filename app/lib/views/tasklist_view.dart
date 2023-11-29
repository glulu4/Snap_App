import 'package:app/widgets/appbar_widget.dart';
import 'package:app/widgets/task_input_widget.dart';
import 'package:app/widgets/tasklist_widget.dart';
import "package:flutter/material.dart";

class TasklistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(), 
      body: Row(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: TaskInputWidget(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.05),
                child: TaskListWidget(),
              ),
            ),
          ],
        ),
    );
  }
}
