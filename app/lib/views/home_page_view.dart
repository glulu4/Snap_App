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
              // height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.05),
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

    // return Scaffold(
    //   appBar: MyAppBar(),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         ElevatedButton(
    //           child: const Text('Go to Task List Page'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => TaskList()),
    //             );
    //           },
    //         ),
    //         ElevatedButton(
    //           child: const Text('Go to Calendar Page'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => CalendarView()),
    //             );
    //           },
    //         ),
    //         ElevatedButton(
    //           child: Text('Go to real home page'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => HomeScreen()),
    //             );
    //           },
    //         ),
    //         ElevatedButton(
    //           child: const Text('Pop up'),
    //           onPressed: () {
    //             showDialog(
    //                 context: context,
    //                 builder: (context) => const AlertDialog(
    //                     title:  Text('Pop Up'),
    //                     content: Text(
    //                         'hi'
    //                     ),
    //                 ),
    //             );
    //           },
    //         ),
    //           ElevatedButton(
    //           child: const Text('Go to add task Page'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => AddTaskView()),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
