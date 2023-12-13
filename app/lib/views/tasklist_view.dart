import 'package:app/view_models/task_view_model.dart';
import 'package:app/widgets/appbar_widget.dart';
import 'package:app/widgets/task_input_widget.dart';
import 'package:app/widgets/tasklist_widget.dart';
import "package:flutter/material.dart";

class TasklistView extends StatelessWidget {
  final bool isEditMode; // to determine if it's edit mode
  final TaskViewModel?
      initialTaskViewModel; // the task to be edited, if in edit mode

  TasklistView({this.isEditMode = false, this.initialTaskViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: TaskInputWidget(
                isEditMode: isEditMode,
                initialTaskViewModel: initialTaskViewModel),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
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
