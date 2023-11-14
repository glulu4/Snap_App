import 'package:flutter/material.dart';
import 'package:app/views/add_task_view.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<bool> taskValues = [false, false]; // Example list of task values

  DropdownButton<String> myDropDown = DropdownButton<String>(
    value: 'Option 1',
    onChanged: (String? newValue) {
      // Handle dropdown value change
    },
    items: <String>[
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4',
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
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
                      automaticallyImplyLeading: false,
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Tooltip(
                        message: 'This is a tooltip',
                        child: IconButton(
                          color: Colors.blueGrey[300],
                          hoverColor: Colors.blueGrey[700],
                          icon: Icon(Icons.filter_alt),
                          onPressed: () {
                            // Action to be performed when filter button is pressed
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () {
                          // Action to be performed when sort button is pressed
                        },
                        color: Colors.blueGrey[300],
                        hoverColor: Colors.blueGrey[700],
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: taskValues.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text('Task ${index + 1}'),
                        value: taskValues[index],
                        onChanged: (bool? value) {
                          setState(() {
                            taskValues[index] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: FloatingActionButton(
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTaskView()),
                    );
                    // Action to be performed when the plus button is pressed
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
