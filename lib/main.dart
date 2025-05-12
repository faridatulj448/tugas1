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