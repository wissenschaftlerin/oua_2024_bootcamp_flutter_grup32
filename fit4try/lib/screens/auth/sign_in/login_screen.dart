
// login ekranının main kısmı

import 'package:flutter/material.dart';
import 'package:fit4try/screens/auth/sign_in/login.dart'; // SignInScreen sınıfının olduğu dosya import edildi

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SignInScreen(),
    );
  }
}