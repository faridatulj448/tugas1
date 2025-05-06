import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar tugas dengan batas waktu',
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Todo {
  String title;
  bool isDone;
  DateTime? deadline;

  Todo({required this.title, this.isDone = false, this.deadline});
}

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _inputController = TextEditingController();
  DateTime? _selectedDate;

  void _addTodo() {
    if (_inputController.text.trim().isEmpty) return;
    setState(() {
      _todos.insert(
        0,
        Todo(title: _inputController.text.trim(), deadline: _selectedDate),
      );
      _inputController.clear();
      _selectedDate = null;
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _editTodo(int index) {
    _inputController.text = _todos[index].title;
    _selectedDate = _todos[index].deadline;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Tugas'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _inputController,
                  decoration: const InputDecoration(labelText: 'Edit tugas'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Tidak ada batas waktu'
                            : 'Tenggat waktu: ${_selectedDate!.toString().split(' ')[0]}',
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDate,
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _todos[index].title = _inputController.text.trim();
                    _todos[index].deadline = _selectedDate;
                  });
                  _inputController.clear();
                  _selectedDate = null;
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
              TextButton(
                onPressed: () {
                  _inputController.clear();
                  _selectedDate = null;
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

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: const Text('Daftar Tugas dengan Batas Waktu'),
              backgroundColor: Colors.blueAccent,
              elevation: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan tugas baru',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'tidak ada batas waktu yang dipilih'
                              : 'Tenggat waktu: ${_selectedDate!.toString().split(' ')[0]}',
                        ),
                      ),
                      TextButton(
                        onPressed: _pickDate,
                        child: const Text('Pilih tanggal'),
                      ),
                      ElevatedButton(
                        onPressed: _addTodo,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) => _toggleDone(index),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration:
                              todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      subtitle:
                          todo.deadline != null
                              ? Text(
                                'Tenggat waktu: ${todo.deadline!.toString().split(' ')[0]}',
                                style: const TextStyle(fontSize: 12),
                              )
                              : null,
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
