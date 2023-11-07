import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login.dart';
import '../screens/noteList.dart';
import '../screens/signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return const NoteList();
            }
            else{
              return const LoginORsignup();
            }
          }
      ),
    );
  }
}

class LoginORsignup extends StatefulWidget {
  const LoginORsignup({super.key});

  @override
  State<LoginORsignup> createState() => _LoginORsignupState();
}

class _LoginORsignupState extends State<LoginORsignup> {

  bool showLogin = true;
  toggleScreen(){
    setState(() {
      showLogin= !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return Login(onTap: toggleScreen);
    } else{
      return SignUp(onTap: toggleScreen);
    }
  }
}