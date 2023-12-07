import 'package:app/models/event.dart';
import 'package:app/view_models/combined_view_model.dart';
import 'package:app/view_models/eventlist_view_model.dart';
import 'package:app/view_models/task_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:app/views/calendar_view.dart';
import 'package:app/views/tasklist_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../calendar_utils.dart';

// calendar widget & state
class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _isLoading = true;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final viewModel = Provider.of<EventListViewModel>(context, listen: false);
      viewModel.loadEventsFromPreferences().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error) {
        // handle errors here
      });
      _isInit = false;
    }
  }

  // view event details
  void showEventDetailsDialog(
    BuildContext context,
    EventListViewModel eventlistViewModel,
    Event event,
  ) {
    // pop up box of details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Date: ${DateFormat('yyyy-MM-dd').format(event.dueDate)}'),
                Text('Category: ${event.category}'),
                if (event.details.isNotEmpty) Text('Details: ${event.details}'),
                if (event.location.isNotEmpty)
                  Text('Location: ${event.location}'),
              ],
              // Displaying event details
              // ...
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                navigateToEditEvent(context, event);
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteTask(context, event);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to handle event editing
  void navigateToEditEvent(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarView(
          isEditMode: true,
          initialEvent: event,
        ),
      ),
    );
  }

  // Function to handle event deletion
  void deleteTask(BuildContext context, Event event) {
    DateTime temp = event.dueDate;
    final viewModel = Provider.of<EventListViewModel>(context, listen: false);
    final combinedViewModel =
        Provider.of<CombinedViewModel>(context, listen: false);
    viewModel.deleteEvent(event);
    combinedViewModel.updateSelectedDay(temp);
    Navigator.of(context).pop(); // Close the dialog
  }

// calendar widget
  // @override
  Widget build(BuildContext context) {
    final eventListViewModel = Provider.of<EventListViewModel>(context);
    final combinedViewModel = Provider.of<CombinedViewModel>(context);
    var routeName = ModalRoute.of(context)?.settings.name;

    return Column(
      children: [
        _buildTableCalendar(combinedViewModel, context),
        const SizedBox(height: 8.0),
        Expanded(
          child: _buildEventList(combinedViewModel, eventListViewModel),
        ),
        if (routeName == '/') _buildAddEventButton(context),
      ],
    );
  }

  Widget _buildTableCalendar(CombinedViewModel combinedViewModel, context) {
    return TableCalendar<dynamic>(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: combinedViewModel.focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(combinedViewModel.selectedDay, day),
      rangeStartDay: combinedViewModel.rangeStart,
      rangeEndDay: combinedViewModel.rangeEnd,
      calendarFormat: combinedViewModel.calendarFormat,
      rangeSelectionMode: combinedViewModel.rangeSelectionMode,
      eventLoader: combinedViewModel.getItemsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              right: 1,
              bottom: 1,
              child: _buildEventsMarker(date, events),
            );
          }
        },
      ),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
          color: Color.fromRGBO(102, 136, 255, 0.83),
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(5),
        ),
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.rectangle,
          //  borderRadius: BorderRadius.circular(5),
        ),
      ),
      onDaySelected: combinedViewModel.onDaySelected,
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      // combinedViewModel.onDaySelected(selectedDay, focusedDay);
      // });
      // },
      onRangeSelected: combinedViewModel.onRangeSelected,
      onFormatChanged: (format) {
        if (combinedViewModel.calendarFormat != format) {
          setState(() {
            combinedViewModel.calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        combinedViewModel.focusedDay = focusedDay;
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List<dynamic> events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.black,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(CombinedViewModel combinedViewModel, viewModel) {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: combinedViewModel.selectedItems,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item = value[index];
            if (item is TaskViewModel) {
              // Render task
              return _buildTaskListItem(context, item);
            } else if (item is Event) {
              // Render event
              return _buildEventListItem(context, viewModel, item);
            } else {
              // Fallback for an unknown type
              return SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  Widget _buildTaskListItem(BuildContext context, TaskViewModel taskViewModel) {
    // Customize this widget to display task details
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        onTap: () => showTaskDetailsDialog(context, taskViewModel),
        leading: Icon(Icons.task, color: Color.fromRGBO(234, 70, 20, 0.824)),
        title: Text(taskViewModel.task.title),
        subtitle: Text(taskViewModel.category),
        trailing: Icon(Icons.arrow_forward_ios, size: 16), // Trailing icon
        // Add other task details
      ),
    );
  }

  Widget _buildEventListItem(
      BuildContext context, EventListViewModel viewModel, Event event) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        onTap: () => showEventDetailsDialog(context, viewModel, event),
        leading: Icon(Icons.event, color: Color.fromRGBO(20, 181, 234, 0.824)),
        title: Text(event.title),
        subtitle: Text(event.category), // Subtitle for the date
        trailing: Icon(Icons.arrow_forward_ios, size: 16), // Trailing icon
      ),
    );
  }

  Widget _buildAddEventButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // Aligns the button to the right
      child: SizedBox(
        width: 64,
        height: 58,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarView()),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Add Event'),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }
}

// view task details
void showTaskDetailsDialog(
  BuildContext context,
  TaskViewModel taskViewModel,
) {
  // pop up box of details
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(taskViewModel.title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Due Date: ${DateFormat('yyyy-MM-dd').format(taskViewModel.dueDate)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Category: ${taskViewModel.category}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Priority: ${taskViewModel.priority}'),
              Text('Effort: ${taskViewModel.effort}'),
              Text(
                'Subtask',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              if (taskViewModel.task.subtasks.isNotEmpty) ...[
                for (var subtask in taskViewModel.task.subtasks)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0), // Indent the subtasks
                    child: ListTile(
                        // title: Text(subtask.title),
                        title: Text(subtask.title,
                            style: TextStyle(fontSize: 15.0)),
                        subtitle: Text(
                            'Due: ${DateFormat.yMMMd().format(subtask.dueDate)}')
                        // Other properties of the subtask can be displayed here
                        ),
                  ),
              ]

              // Text('Completed: ${taskViewModel.isCompleted ? 'Yes' : 'No'}'),
            ],
            // Displaying task details
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Edit'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              navigateToEditTask(context, taskViewModel);
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              deleteTask(context, taskViewModel);
            },
          ),
        ],
      );
    },
  );
}

// Function to handle task editing
void navigateToEditTask(BuildContext context, TaskViewModel taskViewModel) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TasklistView(
        isEditMode: true,
        initialTaskViewModel: taskViewModel,
      ),
    ),
  );
}

// Function to handle task deletion
void deleteTask(BuildContext context, TaskViewModel taskViewModel) {
  DateTime temp = taskViewModel.dueDate;
  final viewModel = Provider.of<TaskListViewModel>(context, listen: false);
  final combinedViewModel =
      Provider.of<CombinedViewModel>(context, listen: false);
  viewModel.deleteTask(taskViewModel);
  combinedViewModel.updateSelectedDay(temp);
  Navigator.of(context).pop(); // Close the dialog
  // Optionally, show a snackbar or other feedback to the user
}
