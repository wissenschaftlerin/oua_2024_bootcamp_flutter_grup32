import 'package:flutter/material.dart';
import 'package:fit4try/screens/stilist/stilist_screen.dart';
//Stilist sayfasının görüntüsü eklendi

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StilistScreen(),
    );
  }
}