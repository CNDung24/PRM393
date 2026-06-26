import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';

class TodoNotifier extends Notifier<List<TodoItem>> {
  @override
  List<TodoItem> build() {
    // Trạng thái khởi tạo (Initial State)
    return [
      TodoItem(
        id: DateTime.now().toString(),
        title: 'Học Flutter Riverpod',
        description: 'Đọc tài liệu và làm demo CRUD.',
      ),
    ];
  }

  // 1. Create (Thêm dữ liệu)
  void addTodo(String title, String description) {
    final newTodo = TodoItem(
      id: DateTime.now().toString(),
      title: title,
      description: description,
    );
    // Cập nhật State: Tạo list mới bao gồm các phần tử cũ và phần tử mới
    state = [...state, newTodo];
  }

  // 3. Update (Cập nhật dữ liệu)
  void updateTodo(String id, String title, String description) {
    // Cập nhật State: Duyệt qua list cũ, nếu trùng id thì thay thế bằng đối tượng mới
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          title: title,
          description: description,
        );
      }
      return todo;
    }).toList();
  }

  // 4. Delete (Xóa dữ liệu)
  void deleteTodo(String id) {
    // Cập nhật State: Lọc ra các phần tử không có id cần xóa
    state = state.where((todo) => todo.id != id).toList();
  }
}

// Provider để cung cấp State cho UI (Dùng NotifierProvider cho Riverpod 2.0+)
final todoProvider = NotifierProvider<TodoNotifier, List<TodoItem>>(() {
  return TodoNotifier();
});