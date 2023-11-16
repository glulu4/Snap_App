import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/event_input_widget.dart';

// calendar view
class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar View'),
      ),
      body: Expanded(
        child: Row(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              // EdgeInsets.only(bottom: 50),
              child: Calendar(),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.03),
              child: EventInput(),
            ),
          ],
        ),
      ),
    );
  }
}