class ToDo {
  final String? id;
  final String? title;
  final int? priority;
  final int? success;
  final int? color;
  final String? date;

  ToDo(
      {this.id,
      this.title,
      this.priority,
      this.success,
      this.color,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'success': success,
      'color': color,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, title: $title, priority: $priority, success: $success, color: $color, date: $date}';
  }
}
