import 'package:appwrite/appwrite.dart';
import 'package:cas/controllers/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key, required this.title});

   final AccountController controller = Get.find();

  final String title;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: const Text('C.A.S')),
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
            'Welcome to C.A.S',
            style: TextStyle(
              fontSize: 20,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              //TODO: logout
              controller.logout();
              
            },
            child: const Text('Logout'),
          ),
            ],
          )
        ),
    );
  }
}
