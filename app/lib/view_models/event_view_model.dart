import 'package:app/models/event.dart';

class EventViewModel {
  final Event event;

  EventViewModel({required this.event});

  String get title {
    return event.title;
  }

  DateTime get dueDate {
    return event.dueDate;
  }

  String get details {
    return event.details;
  }

  String get location {
    return event.location;
  }

  String get category {
    return event.category;
  }

  bool get isCompleted {
    return event.isCompleted;
  }

  bool get isTask {
    return event.isTask;
  }

  void set isCompleted(bool value) {
    event.isCompleted = value;
  }

  int get id {
    return event.id;
  }
}
