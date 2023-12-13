class Event {
  int id;
  String title;
  String details;
  String location;
  DateTime dueDate;
  String category;
  bool isCompleted;
  bool isTask;
  

  Event({
    required this.id,
    required this.title,
    required this.details,
    required this.location,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    required this.isTask,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'details': details,
        'location': location,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'isTask': isTask,
      };

 factory Event.fromJson(Map<String, dynamic> json) { 
    return Event(
      id: json["id"],
      title: json["title"],
      details: json["details"],
      location: json["location"],
      dueDate: DateTime.parse(json['dueDate']),
      category: json["category"],
      isCompleted: json["isCompleted"],
      isTask: json["isTask"],
    );
  }

  // copyWith method for editEvent function
  Event copyWith({
    int? id,
    String? title,
    String? details,
    String? location,
    DateTime? dueDate,
    String? category,
    bool? isCompleted,
    bool? isTask,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      location: location ?? this.location,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      isTask: isTask ?? this.isTask,
    );
  }
}