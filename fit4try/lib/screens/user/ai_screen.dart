// import 'dart:convert';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:fit4try/firebase_options.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'dart:async';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String vtonImgUrl =
//       "https://www.aktuelajans.com/wp-content/uploads/2021/08/siyahi-erkek-manken-6.jpg";
//   String garmImgUrl =
//       "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQxPr10fJD1IGGDELcN19tZI4dQtn7aT28ny1TPKGPJgUK0Xf99uIZIZWzzM5fVHHEpURhm8j1Zq8rWUeGlJ7gAgyny8IfX439ZjY0mg0X5LauIOy99d5BEjA&usqp=CAE";
//   String apiUrl =
//       "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";

//   Uint8List imageData = Uint8List(0);

//   Future<void> processImages() async {
//     try {
//       // API'ye istek gönder
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'vton_img': vtonImgUrl,
//           'garm_img': garmImgUrl,
//         }),
//       );
//       print("response geldi : ${response.body}");
//       if (response.statusCode == 200) {
//         // API'den dönen veriyi işle
//         setState(() {
//           imageData = response.bodyBytes;
//         });
//       } else {
//         throw Exception(
//             'Failed to load image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     processImages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("API Resim İşleme"),
//       ),
//       body: Center(
//         child: imageData.isNotEmpty
//             ? Image.memory(imageData)
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
