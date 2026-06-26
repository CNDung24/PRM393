class TodoItem {
  final String id;
  final String title;
  final String description;

  TodoItem({
    required this.id,
    required this.title,
    this.description = '',
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}