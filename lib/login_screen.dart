// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'task_list_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final box = GetStorage();
            box.write("isLogin", true); // Simpan status login
            Get.off(() => TaskListScreen()); // Pindah ke halaman utama
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
