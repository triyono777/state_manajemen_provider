// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:state_manajemen_provider/login_screen.dart';
import 'task_list_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      final box = GetStorage();
      bool isLogin = box.read("isLogin"); // Ambil status login
      if (isLogin == null) {
        Get.off(() => LoginScreen()); // Pindah ke halaman login
      } else {
        Get.off(() => TaskListScreen()); // Pindah ke halaman utama
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("Logo aplikasi"),
          CircularProgressIndicator(),
        ],
      )),
    );
  }
}
