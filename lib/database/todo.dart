class ToDo {
  final String? id;
  final String? title;
  final int? priority;
  final int? success;
  final int? color;

  ToDo({this.id, this.title, this.priority, this.success, this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'success': success,
      'color': color,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, title: $title, priority: $priority, success: $success, color: $colorㄴㅁㅇㅁ}';
  }
}
