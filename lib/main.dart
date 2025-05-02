import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import package provider
import 'task_model.dart'; // Import model Task
import 'task_provider.dart'; // Import ChangeNotifier (TaskProvider)
import 'task_list_screen.dart'; // Import UI Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider menyediakan instance TaskProvider
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Buat instance TaskProvider
      child: MaterialApp(
        title: 'State Management Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TaskListScreen(), // Gunakan screen utama
      ),
    );
  }
}
