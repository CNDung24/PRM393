import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_provider.dart';
import 'todo_form_screen.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. Read: Theo dõi State bằng Riverpod (ref.watch)
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Công việc (CRUD)'),
        centerTitle: true,
      ),
      body: todos.isEmpty
          ? const Center(
        child: Text(
          'Chưa có công việc nào.\nHãy nhấn + để thêm.',
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(todo.title),
              subtitle: todo.description.isNotEmpty
                  ? Text(todo.description)
                  : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút Edit (Update)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TodoFormScreen(todoToEdit: todo),
                        ),
                      );
                    },
                  ),
                  // 4. Delete: Nút Xóa dữ liệu
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteDialog(context, ref, todo.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Mở màn hình Thêm mới (Create)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const TodoFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Hộp thoại xác nhận trước khi xóa
  void _showDeleteDialog(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa công việc này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Đóng dialog
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              // Gọi hàm delete từ Provider
              ref.read(todoProvider.notifier).deleteTodo(id);
              Navigator.of(context).pop(); // Đóng dialog
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}