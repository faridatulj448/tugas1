import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'theme_provider.dart';
import 'themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Todo List',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
