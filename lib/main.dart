import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'helper/authHelper.dart';
import 'helper/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickNote',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        fontFamily: GoogleFonts.oxygen().fontFamily,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        fontFamily: GoogleFonts.oxygen().fontFamily,
        useMaterial3: true
      ),
      themeMode: ThemeMode.system,
      home: const AuthPage(),
    );
  }
}
