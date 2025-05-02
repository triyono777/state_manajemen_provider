import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Package untuk ID unik
import 'task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = []; // State: Daftar tugas

  List<Task> get tasks => _tasks; // Getter untuk mengakses daftar tugas

  // Metode untuk menambah tugas
  void addTask(String title) {
    if (title.isEmpty) return;
    final newTask = Task(id: const Uuid().v4(), title: title);
    _tasks.add(newTask);
    notifyListeners(); // Beri tahu Consumer/Selector bahwa state berubah
  }

  // Metode untuk menghapus tugas
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Metode untuk mengubah status selesai tugas
  void toggleTaskStatus(String id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex].isDone = !_tasks[taskIndex].isDone;
      notifyListeners();
    }
  }
}
