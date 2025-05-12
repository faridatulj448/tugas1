import 'package:flutte/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Todo {
  String title;
  bool isDone;
  Todo({required this.title, this.isDone = false});
}

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}
class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _inputController = TextEditingController();

  void _addTodo() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() {
      _todos.insert(0, Todo(title: _inputController.text.trim()));
      _inputController.clear();
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _editTodo(int index) {
    _inputController.text = _todos[index].title;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Tugas'),
            content: TextField(
              controller: _inputController,
              decoration: const InputDecoration(labelText: 'Edit Tugas'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _todos[index].title = _inputController.text.trim();
                  });
                  _inputController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
              TextButton(
                onPressed: () {
                  _inputController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Batal'),
              ),
            ],
          ),
    );
  }
   void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hapus Tugas'),
            content: const Text('Apakah Anda yakin ingin menghapus tugas ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _todos.removeAt(index);
                  });
                  Navigator.pop(context); // Tutup dialog
                },
                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }