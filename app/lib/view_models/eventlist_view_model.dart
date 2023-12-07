import 'dart:collection';
import 'dart:convert';
import 'package:app/models/event.dart';
import 'package:app/calendar_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class EventListViewModel extends ChangeNotifier {
  LinkedHashMap<DateTime, List<Event>> events =
      LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  // calendar specific functions
  List<Event> getEventsForDay(DateTime day) {
    // Implementation example
    return events[day] ?? [];
  }
  

  // event functions
  void addEvent(Event event) {
    final date = event.dueDate;
    if (!events.containsKey(date)) {
      events[date] = [];
    }
    events[date]!.add(event);
    saveEventsToPreferences();
    notifyListeners();
  }

  void deleteEvent(Event event) {
    final date = event.dueDate;
    events[date]?.remove(event);
    if (events[date]?.isEmpty ?? true) {
      events.remove(date);
    }
    saveEventsToPreferences();
    notifyListeners();
  }

  void editEvent(DateTime oldDate, Event updatedEvent) {
    if (events[oldDate]?.any((e) => e.id == updatedEvent.id) ?? false) {
      deleteEvent(events[oldDate]!.firstWhere((e) => e.id == updatedEvent.id));
      addEvent(updatedEvent);
      saveEventsToPreferences();
      notifyListeners();
    }
  }
  

  Future<void> saveEventsToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Create a list of maps, each containing the date and the corresponding events
    List<Map<String, dynamic>> eventEntries = [];
    events.forEach((date, eventsList) {
      var dateString = date.toIso8601String(); // Convert DateTime to a string
      var eventJsonList = eventsList
          .map((event) => event.toJson())
          .toList(); // Convert each Event to JSON
      eventEntries.add({"date": dateString, "events": eventJsonList});
    });

    // Convert the entire structure to a JSON string
    String serializedData = json.encode(eventEntries);
    await prefs.setString('events', serializedData);
  }

  Future<void> loadEventsFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? serializedData = prefs.getString('events');

    if (serializedData != null) {
      List<dynamic> eventEntries = json.decode(serializedData);
      LinkedHashMap<DateTime, List<Event>> loadedEvents =
          LinkedHashMap<DateTime, List<Event>>(
        equals: isSameDay,
        hashCode: getHashCode,
      );

      for (var entry in eventEntries) {
        DateTime date = DateTime.parse(entry["date"]);
        List<Event> eventsList = (entry["events"] as List)
            .map((eventJson) => Event.fromJson(eventJson))
            .toList();
        loadedEvents[date] = eventsList;
      }

      events = loadedEvents;
      notifyListeners();
    }
  }
}
