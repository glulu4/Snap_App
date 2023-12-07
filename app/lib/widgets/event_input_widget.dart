import 'package:app/models/event.dart';
import 'package:app/task_utils.dart';
import 'package:app/view_models/combined_view_model.dart';
import 'package:app/view_models/eventlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// input widget & state
class EventInput extends StatefulWidget {
  final bool isEditMode; // to determine if it's edit mode
  final Event? initialEvent; // the event to be edited, if in edit mode

  EventInput(
      {this.isEditMode = false,
      this.initialEvent});

  @override
  _EventInputState createState() => _EventInputState();
}

class _EventInputState extends State<EventInput> {
  bool _isLoading = true;
  bool _isInit = true;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  final locationController = TextEditingController();
  final categoryController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.initialEvent != null) {
      // Initialize fields with the existing task data
      titleController.text = widget.initialEvent!.title;
      detailsController.text = widget.initialEvent!.details;
      locationController.text = widget.initialEvent!.location;
      categoryController.text = widget.initialEvent!.category.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    locationController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void _clearFormFields() {
    titleController.clear();
    detailsController.clear();
    locationController.clear();
    categoryController.clear();
  }

  // add event
  void _submitForm() {
    final eventListViewModel = Provider.of<EventListViewModel>(context, listen: false);
    final combinedViewModel = Provider.of<CombinedViewModel>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      if (widget.isEditMode) {
        // Handle task edit logic here
        // create a new Task instance with updated values
        Event updatedEvent = widget.initialEvent!.copyWith(
          title: titleController.text,
          dueDate: combinedViewModel.selectedDay!,
          category: categoryController.text,
          details: detailsController.text,
          location: locationController.text,
          isCompleted: false,
        );

        // update the event in the viewModel
        Provider.of<EventListViewModel>(context, listen: false).editEvent(widget.initialEvent!.dueDate, updatedEvent);
        combinedViewModel.updateSelectedDay(updatedEvent.dueDate);

        Navigator.of(context).pop();
      } else {
        if (combinedViewModel.selectedDay == null) {
          // Show an error message if selectedDay is null
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please select a day before adding an event."),
              backgroundColor: Colors.red,
            ),
          );
          return; // Exit the function as we can't proceed without a selected day
        }
        final event = Event(
          id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
          title: titleController.text,
          dueDate: combinedViewModel.selectedDay!,
          category: categoryController.text,
          details: detailsController.text,
          location: locationController.text,
          isCompleted: false,
          isTask: false,
          // taskId: null
        );

        eventListViewModel.addEvent(event);
        combinedViewModel.updateSelectedDay(event.dueDate);
      }
      _clearFormFields();
    } else {
      print('Form is not valid');
    }
  }

// input widget
  @override
  Widget build(BuildContext context) {
    // Update the UI elements based on the mode
    String headerText = widget.isEditMode ? 'Edit Event:' : 'Add an Event:';
    String buttonText = widget.isEditMode ? 'Save Changes' : 'Add an Event';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Text(
            headerText,
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
                  _buildInputFields(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    ),
                    onPressed: _submitForm,
                    child: Text(buttonText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // build input fields
  Widget _buildInputFields() {
    return Column(
      children: [
        TaskUtils.createTextFormField(
            controller: titleController,
            labelText: 'Event Title',
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter an event title'
                : null),
        const SizedBox(height: 20),
        TaskUtils.createTextFormField(
            controller: categoryController,
            labelText: 'Category',
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a category'
                : null),
        const SizedBox(height: 20),
        TaskUtils.createTextFormField(
          controller: detailsController,
          labelText: 'Details',
          validator: (value) {
            return null;
          },
        ),
        const SizedBox(height: 20),
        TaskUtils.createTextFormField(
          controller: locationController,
          labelText: 'Location',
          validator: (value) {
            return null;
          },
        ),
      ],
    );
  }
}
