import 'package:flutter/material.dart';
import 'package:fit4try/screens/settings/help_center/help_center_page.dart';
//yardım merkezi sayfasının görüntüsü eklendi

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HelpCenterScreen(),
    );
  }
}