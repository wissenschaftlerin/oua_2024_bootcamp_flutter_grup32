import 'package:flutter/material.dart';
import 'package:fit4try/screens/user/community_screen.dart';
//Arama sayfası görüntüsü eklendi

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CommunityScreen(),
    );
  }
}
