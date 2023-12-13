
class Task {
  final int id;
  String title;
  DateTime dueDate;
  String category;
  bool isCompleted;
  int priority;
  // List<Task> subtasks; 
  int effort;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    required this.priority,
    // List<Task>? subtasks, 
    required this.effort,
  }); 

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'priority': priority,
        // 'subtasks': subtasks
        //     .map((subtask) => subtask.toJson())
        //     .toList(), 
        'effort': effort,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    // var subtasksFromJson = json['subtasks'] as List<dynamic>? ?? [];

    // var subtasks = subtasksFromJson.map((subtaskJson) {
    //   return Task.fromJson(subtaskJson as Map<String, dynamic>);
    // }).toList();

    return Task(
      id: json["id"],
      title: json["title"],
      dueDate: DateTime.parse(json['dueDate']),
      category: json["category"],
      isCompleted: json["isCompleted"],
      priority: json["priority"],
      // subtasks: subtasks,
      effort: json["effort"],
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
    );
  }
}

