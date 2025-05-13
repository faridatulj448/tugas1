import 'package:flutter/material.dart';
import 'add_task_page.dart';

class Todo {
  String title;
  bool isDone;
  DateTime? deadline;
  Todo({required this.title, this.isDone = false, this.deadline});
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  void _navigateToAddPage() async {
    final newTodo = await Navigator.push<Todo>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskPage()),
    );

    if (newTodo != null) {
      setState(() {
        _todos.insert(0, newTodo);
      });
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Tugas')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) => _toggleDone(index),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: todo.deadline != null
                ? Text('Tenggat: ${todo.deadline!.toLocal().toString().split(' ')[0]}')
                : null,
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTodo(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
