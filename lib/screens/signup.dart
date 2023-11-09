import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/authButton.dart';
import '../components/authField.dart';

class SignUp extends StatefulWidget {
  final Function() onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  showAlert(String msg){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(msg),
            actions: [
              FilledButton(onPressed: (){Get.back();}, child: const Text('Okay'))
            ],
          );
        }
    );
  }

  signUp()async{
    try{
      showDialog(context: context, builder: (context) {
        return const Center(child: CircularProgressIndicator());}
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      await FirebaseFirestore.instance.collection("users").doc().set({
        'name':fnameController.text,
        'email':emailController.text,
        'phone':int.parse(phoneController.text)
      });
      Get.back();
      final snackBar = SnackBar(
        content: const Text('Signed In Successfully!',style: TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        dismissDirection: DismissDirection.down,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    on FirebaseAuthException catch(e){
      Get.back();
      if(e.code=='weak-password'){
        showAlert('Password is Too Weak');
      }
      if(e.code=="email-already-in-use"){
        showAlert('E-mail is already signed in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text('Signup',
          style: TextStyle(
              color: theme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 24
          )
        ),
      ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text('Happy to see you!', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  AuthField(
                      controller: fnameController,
                      hint: 'Full Name',
                      icon: const Icon(Icons.person),
                      password: false,
                      textType: TextInputType.name
                  ),
                  AuthField(
                      controller: emailController,
                      hint: 'E-mail',
                      icon: const Icon(Icons.email_outlined),
                      password: false,
                      textType: TextInputType.emailAddress
                  ),
                  AuthField(
                      controller: phoneController,
                      hint: 'Contact No.',
                      icon: const Icon(Icons.phone_android_rounded),
                      password: false,
                      textType: TextInputType.phone
                  ),
                  AuthField(
                      controller: passwordController,
                      hint: 'Password',
                      icon: const Icon(Icons.lock_outline_rounded),
                      password: true,
                      textType: TextInputType.visiblePassword
                  ),
                  const SizedBox(height: 20),
                  AuthButton(onTap:signUp, name: 'Sign Up'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(onPressed:widget.onTap, child: const Text('Login'))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
