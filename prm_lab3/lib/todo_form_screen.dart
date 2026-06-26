import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';
import 'todo_provider.dart';

class TodoFormScreen extends ConsumerStatefulWidget {
  final TodoItem? todoToEdit; // Truyền vào nếu là Update, null nếu là Create

  const TodoFormScreen({Key? key, this.todoToEdit}) : super(key: key);

  @override
  ConsumerState<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends ConsumerState<TodoFormScreen> {
  // Key để quản lý trạng thái của Form
  final _formKey = GlobalKey<FormState>();

  // TextEditingController để lấy dữ liệu từ TextField
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    // Đổ dữ liệu lên Input Widget bằng TextEditingController (Nếu là chế độ Update)
    _titleController = TextEditingController(text: widget.todoToEdit?.title ?? '');
    _descController = TextEditingController(text: widget.todoToEdit?.description ?? '');
  }

  @override
  void dispose() {
    // Luôn dispose controller để tránh leak memory
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Kiểm tra dữ liệu đầu vào (Validate)
    if (_formKey.currentState!.validate()) {
      if (widget.todoToEdit == null) {
        // Chế độ Create: Thêm dữ liệu
        ref.read(todoProvider.notifier).addTodo(
          _titleController.text,
          _descController.text,
        );
      } else {
        // Chế độ Update: Cập nhật dữ liệu
        ref.read(todoProvider.notifier).updateTodo(
          widget.todoToEdit!.id,
          _titleController.text,
          _descController.text,
        );
      }
      // Trở lại màn hình trước
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todoToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Cập nhật Công việc' : 'Thêm Công việc mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 1. TextFormField cho Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Tên công việc',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                // Validate dữ liệu đầu vào
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập tên công việc';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. TextFormField cho Description
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 24),

              // Nút Submit
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEditing ? 'CẬP NHẬT' : 'THÊM MỚI',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}