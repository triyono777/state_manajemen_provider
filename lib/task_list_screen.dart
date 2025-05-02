import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'task_model.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
      ),
      // Menggunakan Consumer untuk mendengarkan perubahan TaskProvider
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          // Builder function menerima context, instance provider (taskProvider),
          // dan child (opsional, widget yang tidak perlu dibangun ulang)
          final tasks = taskProvider.tasks; // Mengambil daftar tugas dari state

          if (tasks.isEmpty) {
            return const Center(
              child: Text('Belum ada tugas.'),
            );
          } else {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) {
                      // Memanggil metode dari TaskProvider yang diakses di builder Consumer
                      taskProvider.toggleTaskStatus(task.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Memanggil metode dari TaskProvider yang diakses di builder Consumer
                      taskProvider.removeTask(task.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Mengakses TaskProvider menggunakan Provider.of dengan listen: false
        // karena tombol ini hanya perlu memanggil metode, bukan membangun ulang UI-nya sendiri
        onPressed: () => _showAddTaskDialog(context),
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
        // di sini juga hanya perlu memanggil metode, bukan membangun ulang UI dialog
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
                taskProvider.addTask(_taskController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
