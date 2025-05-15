import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_task_page.dart';
import 'theme_provider.dart';

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

  void _addTodo(Todo newTodo) {
    setState(() {
      _todos.insert(0, newTodo);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _editTodo(int index, Todo updatedTodo) {
    setState(() {
      _todos[index] = updatedTodo;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
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
                  ? Text(
                      'Deadline: ${todo.deadline!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final updatedTodo = await Navigator.push<Todo>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskPage(
                            todo: todo,
                          ),
                        ),
                      );
                      if (updatedTodo != null) {
                        _editTodo(index, updatedTodo);
                      }
                    },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.push<Todo>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskPage(),
            ),
          );
          if (newTodo != null) {
            _addTodo(newTodo);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
