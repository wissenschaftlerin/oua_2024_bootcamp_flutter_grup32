import 'package:flutter/material.dart';
import 'package:fit4try/screens/settings/profile_settings/password_settings/change_password_page_screen.dart';
// Şifre ayarları sayfasının görüntüsü eklendi
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangePasswordPage(),
    );
  }
}