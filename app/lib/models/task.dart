class Task {
  final int id;
  String title;
  DateTime dueDate;
  String category;
  bool isCompleted;
  int priority;
  // Task? subtask;
  int effort;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    required this.priority,
    // this.subtask,
    required this.effort,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'priority': priority,
        // 'subtask': subtask?.toJson(),
        'effort': effort,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      dueDate: DateTime.parse(json['dueDate']),
      category: json["category"],
      isCompleted: json["isCompleted"],
      priority: json["priority"],
      // subtask: json["subtask"] != null ? Task.fromJson(json['subtask']) : null,
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
    // Task? subtask,
    int? effort,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      // subtask: subtask ?? this.subtask,
      effort: effort ?? this.effort,
    );
  }
}
