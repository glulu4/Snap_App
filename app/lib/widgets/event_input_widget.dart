import 'package:flutter/material.dart';

// input widget & state
class EventInput extends StatefulWidget {
  @override
  _EventInputState createState() => _EventInputState();
}

class _EventInputState extends State<EventInput> {
  final _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // process the input data
      print('Form is valid');
      print('Field 1: ${_controller1.text}');
      print('Field 2: ${_controller2.text}');
      print('Field 3: ${_controller3.text}');
    } else {
      print('Form is not valid');
    }
  }

// input widget
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start, 
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            'Add an Event:',
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
                    controller: _controller1,
                    decoration: const InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller2,
                    decoration: const InputDecoration(
                      labelText: 'Event Details',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter details';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller3,
                    decoration: const InputDecoration(
                      labelText: 'Event Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
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
                    child: const Text('Add Event'),
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
