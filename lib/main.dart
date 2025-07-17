import 'package:app1/controllers/user_controller.dart';
import 'package:app1/screens/screen1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstScreen(),
    );
  }
}

