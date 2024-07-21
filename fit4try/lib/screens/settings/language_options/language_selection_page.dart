import 'package:flutter/material.dart';
import 'package:fit4try/screens/settings/language_options/language_selection_page_screen.dart';
//dil seçenekleri sayfasının görüntüsü eklendi

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguageSelectionPage(),
    );
  }
}