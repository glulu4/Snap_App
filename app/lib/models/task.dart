
class Task {
  final int id;
  String title;
  DateTime dueDate;
  String category;
  bool isCompleted;
  int priority;
  // List<Task> subtasks; // Changed to a list
  int effort;
  // int? eventId;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    required this.priority,
    // List<Task>? subtasks, // Optional parameter
    required this.effort,
    // int? eventId,
  }); // Initialize if null

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'priority': priority,
        // 'subtasks': subtasks
        //     .map((subtask) => subtask.toJson())
        //     .toList(), // Serialize each subtask
        'effort': effort,
        // 'eventId': eventId,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    // Extract 'subtasks' as a List<dynamic> if it's not null, else use an empty list
    // var subtasksFromJson = json['subtasks'] as List<dynamic>? ?? [];

    // // Convert each element in the list from dynamic to Task
    // var subtasks = subtasksFromJson.map((subtaskJson) {
    //   // Ensure each element is a Map<String, dynamic> before calling Task.fromJson
    //   return Task.fromJson(subtaskJson as Map<String, dynamic>);
    // }).toList();

    return Task(
      id: json["id"],
      title: json["title"],
      dueDate: DateTime.parse(json['dueDate']),
      category: json["category"],
      isCompleted: json["isCompleted"],
      priority: json["priority"],
      // subtasks: subtasks, // Now correctly typed as List<Task>
      effort: json["effort"],
      // eventId: json["eventId"],
    );
  }

  // copyWith method for editTask function
  Task copyWith({
    int? id,
    String? title,
    DateTime? dueDate,
    String? category,
    bool? isCompleted,
    int? priority,
    List<Task>? subtasks,
    int? effort,
    // int? eventId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      // subtasks: subtasks ?? this.subtasks,
      effort: effort ?? this.effort,
      // eventId: eventId ?? this.effort,
    );
  }
}

