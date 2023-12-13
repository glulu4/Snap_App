import 'package:app/calendar_utils.dart';
import 'package:app/view_models/eventlist_view_model.dart';
import 'package:app/view_models/tasklist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CombinedViewModel extends ChangeNotifier {
  late TaskListViewModel _taskListViewModel;
  late EventListViewModel _eventListViewModel;
  CombinedViewModel();

  ValueNotifier<List<dynamic>> selectedItems = ValueNotifier([]);
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  // Method to update the view models
  void updateViewModels(
      TaskListViewModel taskListVM, EventListViewModel eventListVM) {
    _taskListViewModel = taskListVM;
    _eventListViewModel = eventListVM;
    notifyListeners();
  }

  // Call this method to update the items for a selected day
  void updateSelectedDay(DateTime day) {
    selectedDay = day;
    selectedItems.value = getItemsForDay(day);
  }


  List<dynamic> getItemsForDay(DateTime day) {
    List<dynamic> items = [];

    // Add events for the day
    items.addAll(_eventListViewModel.getEventsForDay(day));

    // Add tasks for the day
    items.addAll(_taskListViewModel.getTasksForDay(day));

    return items;
  }

  List<dynamic> getItemsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) getItemsForDay(d),
    ];
  }

  void onDaySelected(DateTime pselectedDay, DateTime focusedDay) {
    if (!isSameDay(selectedDay, pselectedDay)) {
      selectedDay = pselectedDay;
      focusedDay = focusedDay;
      rangeStart = null; 
      rangeEnd = null;
      rangeSelectionMode = RangeSelectionMode.toggledOff;
      selectedItems.value = getItemsForDay(pselectedDay);
    }
    notifyListeners();
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    selectedDay = null;
    focusedDay = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;

    if (start != null && end != null) {
      selectedItems.value = getItemsForRange(start, end);
    } else if (start != null) {
      selectedItems.value = _eventListViewModel.getEventsForDay(start);
    } else if (end != null) {
      selectedItems.value = _eventListViewModel.getEventsForDay(end);
    }
    notifyListeners();
  }
}
