import 'package:flutter/material.dart';
import '../widgets/tasklist_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/appbar_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Row(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child:Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: TaskListWidget(),
            ),
          ),
         Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: Calendar(),
            ),
        ],
      ),
    );
  }
}
