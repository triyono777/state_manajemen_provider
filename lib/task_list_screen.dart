import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_model.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengakses TaskProvider menggunakan Provider.of
    // listen: true (default) karena kita perlu membangun ulang UI saat state berubah
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks; // Mengambil daftar tugas dari state

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('Belum ada tugas.'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough // Coret jika selesai
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) {
                      // Memanggil metode dari TaskProvider
                      taskProvider.toggleTaskStatus(task.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Memanggil metode dari TaskProvider
                      taskProvider.removeTask(task.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddTaskDialog(context), // Tampilkan dialog tambah tugas
        tooltip: 'Tambah Tugas',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog tambah tugas
  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController _taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Mengakses TaskProvider menggunakan Provider.of dengan listen: false
        // karena kita hanya perlu memanggil metode addTask, bukan membangun ulang UI dialog
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);

        return AlertDialog(
          title: const Text('Tambah Tugas Baru'),
          content: TextField(
            controller: _taskController,
            decoration: const InputDecoration(hintText: 'Masukkan nama tugas'),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tambah'),
              onPressed: () {
                taskProvider.addTask(_taskController.text); // Panggil addTask
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
