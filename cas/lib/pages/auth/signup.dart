import 'package:appwrite/appwrite.dart';
import 'package:cas/controllers/account.dart';
import 'package:cas/controllers/signup_controller.dart';
import 'package:cas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:cas/pages/home.dart';
import 'package:toastification/toastification.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SignUpPage extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final nameController = TextEditingController();

  final SignUpController signup = Get.find();
  final AccountController acc = Get.find();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
        appBar: AppBar(
          ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [ 
              //Some Icon
              const SizedBox(height: 10,),
              const Icon(Icons.note,size: 80,),
              //Greetings
              const SizedBox(height: 15,),
              Text("Let's get you started",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
              ),
              ),
              const SizedBox(height: 15,),
          
              Padding(
                padding: const  EdgeInsets.only(left:20,right: 20),
                child: TextField(
                  controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'User Name',
                      fillColor: Colors.white,
                      filled: true,
                    )
                ),
              ),
              
              const SizedBox(height: 20,),
              Padding(
                padding: const  EdgeInsets.only(left:20,right: 20),
                child: TextField(
                  controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                    )
                ),
              ),
          
              const SizedBox(height: 20,),
               Padding(
                padding:  const EdgeInsets.only(left:20,right: 20),
                child: TextField(
                  onChanged: (value){
                    if(value=="" || passwordController.text.length<8 || passwordController.text!=confirmController.text){
                      signup.signUp.value = false;
                    }else {
                      signup.signUp.value = true;
                    }
                  
                  },
                  controller: passwordController,
                  obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.white,
                      filled: true
                    )
                ),
              ),
          
              const SizedBox(height: 20,),
               Padding(
                padding:  const EdgeInsets.only(left:20,right: 20),
                child: TextField(
                  onChanged: (value){
                    if(confirmController.text==''||confirmController.text!=passwordController.text || confirmController.text.length<8){
                      signup.signUp.value = false;
                    }else {
                      signup.signUp.value = true;
                    }
                  
                  },
                  
                  onEditingComplete: (){
                    if(passwordController.text==confirmController.text && passwordController.text.length>8){
                      signup.signUp.value = true;
                    }else {
                      signup.signUp.value = false;
                    }
                  },
                  controller: confirmController,
                  obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm password',
                      fillColor: Colors.white,
                      filled: true
                    )
                ),
              ),
          
               
              const SizedBox(height: 30,),
              GestureDetector(
                child: Obx(()=>Container(
                  decoration:BoxDecoration(
                    color:signup.signUp.value? Colors.black: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: const Center(child: Text('Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  )
                  ),
                  
                  ),
                )),
                onTap: () async{
                  bool success = false;
                  try{
                  success = await acc.createAccount(email:emailController.text,name: nameController.text , password: passwordController.text);
                  passwordController.clear();
                  confirmController.clear();
                  nameController.clear();
                  emailController.clear();

                  print(success);
                  if(scaffoldKey.currentContext!.mounted && success){
                      // Navigator.push(context , MaterialPageRoute(builder: (context)=> MyHomePage()));
                      //TODO : Navigate to the home page
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title:'cas')));
                  }
                  } on Exception catch(e){
                    print(e);

                toastification.show(
                context: context, // optional if you use ToastificationWrapper
                title: const Text('Sign up failed, please try again'),
                autoCloseDuration: const Duration(seconds: 2),
              );
                  }
                  
                },
              ),
                  
              ],
                  
            ),
          ),
        )
      
      );
  }
}