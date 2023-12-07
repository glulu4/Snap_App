import 'package:app/models/event.dart';
import 'package:app/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/event_input_widget.dart';

// calendar view
class CalendarView extends StatelessWidget {
  final bool isEditMode; // to determine if it's edit mode
  final Event?
      initialEvent; // the task to be edited, if in edit mode

  CalendarView({this.isEditMode = false, this.initialEvent});

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
              // EdgeInsets.only(bottom: 50),
              child: Calendar(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: EventInput(
                isEditMode: isEditMode,
                initialEvent: initialEvent),
            ),
          ],
        ),
    );
  }
}