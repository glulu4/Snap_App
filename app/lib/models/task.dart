class Task {

  final String title;
  final DateTime dueDate;
  final String category;
  final bool isCompleted;

  Task({required this.title, required this.dueDate, required this.category, required this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        title: json["Title"],
        dueDate: json["Due Date"],
        category: json["Category"],
        isCompleted: json["Completed"],
    );
  }
}