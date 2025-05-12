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