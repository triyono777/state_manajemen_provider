import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import package provider
import 'splash_screen.dart';
import 'task_model.dart'; // Import model Task
import 'task_provider.dart'; // Import ChangeNotifier (TaskProvider)
import 'task_list_screen.dart'; // Import UI Screen
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider menyediakan instance TaskProvider
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Buat instance TaskProvider
      child: GetMaterialApp(
        title: 'State Management Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(), // Gunakan screen utama
      ),
    );
  }
}
