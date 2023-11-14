// import "package:app/views/app_bar.dart";
// import "package:flutter/material.dart";
// import "package:app/widgets/task_list.dart";
// import 'app_bar.dart';

// class AddTaskView extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(),
//       body: Center(
//       child: Row(
//         children: [
//           Expanded(
//              child: TaskList()
//           ),
//           Expanded(
//             child: TaskInput()
//           )
//         ],
//       ),
//     ),
//     );
//   }
// }

// class TaskInput extends StatefulWidget {
//   @override
//   _TaskInputState createState() => _TaskInputState();
// }

// class _TaskInputState extends State<TaskInput> {

//   int? priority;
//   int? effort;

//   final List<int> options = [1, 2, 3];

//   final _formKey = GlobalKey<FormState>();
//   final taskController = TextEditingController();
//   final dateController = TextEditingController();
//   final categoryController = TextEditingController();
//   // Add more controllers if you have more fields

//   @override
//   void dispose() {
//     taskController.dispose();
//     dateController.dispose();
//     categoryController.dispose();
//     // Dispose other controllers if you have more
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Process the input data
//       print('Form is valid');
//       print('Field 1: ${taskController.text}');
//       print('Field 2: ${dateController.text}');
//       print('Field 3: ${categoryController.text}');

//       // Process other fields if you have more
//     } else {
//       print('Form is not valid');
//     }
//   }

// // input widget
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment
//           .start, // Aligns children to the start of the horizontal axis
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Text(
//             'Add a Task:',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.left,
//           ),
//         ),
//         Expanded(
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
//               child: Column(
//                 children: [

//                   TextFormField(
//                     controller: taskController,
//                     decoration: const InputDecoration(
//                       labelText: 'Task Name',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a name';
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: dateController,
//                     decoration: const InputDecoration(
//                       labelText: 'Due Date',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Due Date';
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: categoryController,
//                     decoration: const InputDecoration(
//                       labelText: 'Category',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a Category';
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 20),
//                   DropdownButtonFormField<int>(
//                     decoration: const InputDecoration(
//                       labelText: 'Select a priority',
//                       border: OutlineInputBorder(),
//                     ),
//                     value: priority,
//                     onChanged: (int? newValue) {
//                       setState(() {
//                         priority = newValue;
//                       });
//                     },
//                     validator: (int? value) {
//                       if (value == null) {
//                         return 'Select a priority';
//                       }
//                       return null;
//                     },
//                     items: options.map<DropdownMenuItem<int>>((int value) {
//                       return DropdownMenuItem<int>(
//                         value: value,
//                         child: Text(value.toString()),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 20),
//                   DropdownButtonFormField<int>(
//                     decoration: const InputDecoration(
//                       labelText: 'Select an effort',
//                       border: OutlineInputBorder(),
//                     ),
//                     value: effort,
//                     onChanged: (int? newValue) {
//                       setState(() {
//                         effort = newValue;
//                       });
//                     },
//                     validator: (int? value) {
//                       if (value == null) {
//                         return 'Select an effort';
//                       }
//                       return null;
//                     },
//                     items: options.map<DropdownMenuItem<int>>((int value) {
//                       return DropdownMenuItem<int>(
//                         value: value,
//                         child: Text(value.toString()),
//                       );
//                     }).toList(),
//                   ),

//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                     ),
//                     onPressed: _submitForm,
//                     child: const Text('Add Task'),
//                   ),

//                   // DropdownButtonFormField<int>(
//                   //   value: priority,
//                   //   hint: Text('Select a number'),
//                   //   onChanged: (int? newValue) {
//                   //     setState(() {
//                   //       priority = newValue;
//                   //     });
//                   //   },
//                   //   validator: (int? value) {
//                   //     if (value == null) {
//                   //       return 'Please select a number';
//                   //     }
//                   //     return null;
//                   //   },
//                   //   items: options.map<DropdownMenuItem<int>>((int value) {
//                   //     return DropdownMenuItem<int>(
//                   //       value: value,
//                   //       child: Text(value.toString()),
//                   //     );
//                   //   }).toList(),
//                   // ),

//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import "package:flutter/material.dart";
import 'package:app/views/app_bar.dart'; // Make sure this path is correct
import 'package:app/widgets/task_list.dart'; // Make sure this path is correct

class AddTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(), // Ensure MyAppBar is correctly imported
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: TaskList(), // Ensure TaskList is correctly imported
            ),
            Expanded(
              child: TaskInput(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskInput extends StatefulWidget {
  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  int? priority;
  int? effort;

  final List<int> options = [1, 2, 3];
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the input data
      print('Form is valid');
      print('Task Name: ${taskController.text}');
      print('Due Date: ${dateController.text}');
      print('Category: ${categoryController.text}');
      // Process other fields if you have more
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            'Add a Task:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  TextFormField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      labelText: 'Due Date',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true, // Prevents keyboard from showing
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a due date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  // Add more TextFormField widgets if you have more fields
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Select a Priority',
                      border: OutlineInputBorder(),
                    ),
                    value: priority,
                    onChanged: (int? newValue) {
                      setState(() {
                        priority = newValue;
                      });
                    },
                    validator: (int? value) {
                      if (value == null) {
                        return 'Please select a priority';
                      }
                      return null;
                    },
                    items: options.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Select an Effort',
                      border: OutlineInputBorder(),
                    ),
                    value: effort,
                    onChanged: (int? newValue) {
                      setState(() {
                        effort = newValue;
                      });
                    },
                    validator: (int? value) {
                      if (value == null) {
                        return 'Please select an effort';
                      }
                      return null;
                    },
                    items: options.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    ),
                    onPressed: _submitForm,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
