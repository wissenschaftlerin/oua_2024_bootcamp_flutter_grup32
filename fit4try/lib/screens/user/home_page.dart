import 'package:flutter/material.dart';
import 'package:fit4try/screens/user/home_page_screen.dart';
//anasayfanın görüntüsü eklendi

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}