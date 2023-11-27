import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/authField.dart';
import '../components/authButton.dart';
import '../screens/resetPassword.dart';

class Login extends StatefulWidget {
  final Function() onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
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

  login()async{
    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator());}
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Get.back();
      final snackBar = SnackBar(
        content: const Text('Logged In Successfully!',style: TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        dismissDirection: DismissDirection.down,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch(e){
      Get.back();
      if(e.code=="user-not-found"){
        showAlert('No User Found');
      } else if(e.code=="wrong-password"){
        showAlert('Wrong password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        title: Text('Login',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24
          )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Happy to see you again!', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                AuthField(
                  controller: emailController,
                  hint: 'E-mail',
                  icon: const Icon(Icons.email_outlined),
                  password: false,
                  textType: TextInputType.emailAddress
                ),
                AuthField(
                  controller: passwordController,
                  hint: 'Password',
                  icon: const Icon(Icons.lock_outline_rounded),
                  password: true,
                  textType: TextInputType.visiblePassword
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Get.to(()=>const ResetPassword());
                      },
                      child: const Text('Forgot Password?')
                    )
                  ],
                ),
                const SizedBox(height: 40),
                AuthButton(onTap:login, name: 'Login'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(onPressed:widget.onTap, child: const Text('Sign Up'))
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
