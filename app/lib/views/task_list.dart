// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool isChecked = false;


  DropdownButton<String> myDropDown = DropdownButton<String> (
    value: 'Option 1',
    onChanged: (String? newValue) {
      // Handle dropdown value change
    },
    items: <String>[
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskList Page'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: AppBar(
                  backgroundColor: Colors.blue[100],
                  title: Text('List widget'),
                  automaticallyImplyLeading:false,

                ),
              ),
              
              ButtonBar(
                

                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // myDropDown,
                  
                    Tooltip(
                      message: 'This is a tooltip',
                      child: IconButton(
                      color: Colors.blueGrey[300],
                      hoverColor: Colors.blueGrey[700],
                      icon: Icon(Icons.filter_alt),
                      onPressed: () {
                        //
                      },
                    ),
                    ),

                    IconButton(
                      icon: Icon(Icons.sort),
                      onPressed:() {
                      //
                    },
                    color: Colors.blueGrey[300],
                    hoverColor: Colors.blueGrey[700],
                    ),
                ],
              ),
              
              ListView(
                shrinkWrap: true,
                children: [
                    CheckboxListTile(
                    title: Text('Task 1'),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, // Places checkbox to the left
                  ),
                  CheckboxListTile(
                    title: Text('Task 2'),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
