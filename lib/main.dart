import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoListScreen());
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _todoList = ['Tugas 1', 'Tugas 2', 'Tugas 3'];
  final TextEditingController _controller = TextEditingController();

  // Fungsi untuk menambah tugas baru
  void _addTodo() {
    setState(() {
      _todoList.add('Tugas Baru');
    });
  }

  // Fungsi untuk mengedit tugas yang ada
  void _editTodo(int index) {
    _controller.text = _todoList[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Tugas'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Edit Tugas'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _todoList[index] = _controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Tugas')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Tambah Tugas'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todoList[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
