import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(title: const Text('Daftar Tugas'), elevation: 0),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Masukkan tugas baru...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: _addTodo, child: const Text('Tambah')),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: _todos[index].isDone,
                        onChanged: (_) => _toggleDone(index),
                      ),
                      title: Text(
                        _todos[index].title,
                        style: TextStyle(
                          decoration:
                              _todos[index].isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editTodo(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTodo(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
