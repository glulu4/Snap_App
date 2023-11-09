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
              TaskList(), 
              Text("Soon to be calendar"),
            ],


          )

        )
        
        
      ),
    );
  }
}