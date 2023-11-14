class Task {
  final String title;
  final DateTime dueDate;
  final String category;
  final bool isCompleted;
  final int priority;
  final Task? subtask;
  final int effort;

  Task({
    required this.title,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
    required this.priority,
    this.subtask,
    required this.effort,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'priority': priority,
        'subtask': subtask?.toJson(),
        'effort': effort,
  };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json["Title"],
      dueDate: DateTime.parse(json['dueDate']),
      category: json["Category"],
      isCompleted: json["Completed"],
      priority: json["Priority"],
      subtask: json["Subtask"] != null ? Task.fromJson(json['subtask']) : null, 
      effort: json["Effort"],
    );
  }
}
