import 'package:appwrite/appwrite.dart';
import 'package:cas/controllers/account.dart';
import 'package:cas/controllers/signup_controller.dart';
import 'package:cas/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cas/pages/auth/login.dart';

void main() {
  Get.put(AccountController());
  Get.put(SignUpController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final AccountController controller = Get.find();
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
   
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(()=>controller.isLoggedin.value? MyHomePage(title: 'C.A.S') : LoginPage()),
    );
  }
}



