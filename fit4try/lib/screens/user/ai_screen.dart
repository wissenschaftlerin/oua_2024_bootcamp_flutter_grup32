// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:fit4try/screens/user/messages_screen.dart';
// import 'package:fit4try/screens/user/notifications_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class AiScreen extends StatefulWidget {
//   @override
//   _AiScreenState createState() => _AiScreenState();
// }

// class _AiScreenState extends State<AiScreen> {
//   String? vtonImgUrl;
//   String? garmImgUrl;
//   String apiUrl = "";
//   String text = "";
//   Uint8List imageData = Uint8List(0);
//   final ImagePicker _picker = ImagePicker();

//   Future<String> uploadImageToFirebase(
//       File imageFile, String folderPath) async {
//     try {
//       final User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         String userId = user.uid;
//         String imageName = DateTime.now().millisecondsSinceEpoch.toString();
//         Reference ref = FirebaseStorage.instance
//             .ref()
//             .child('$folderPath/$userId/$imageName.png');

//         UploadTask uploadTask = ref.putFile(imageFile);
//         TaskSnapshot taskSnapshot = await uploadTask;
//         String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//         print("Uploaded VTON Image URL: $downloadUrl");

//         return downloadUrl;
//       } else {
//         throw Exception('User not logged in');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw e;
//     }
//   }

//   Future<void> processImages() async {
//     try {
//       if (vtonImgUrl != null && garmImgUrl != null) {
//         // Resim dosyalarını al
//         File vtonFile = File(vtonImgUrl!);
//         File garmFile = File(garmImgUrl!);

//         // Resimleri Firebase Storage'a yükle
//         String uploadedVtonImgUrl =
//             await uploadImageToFirebase(vtonFile, 'temp');
//         String uploadedGarmImgUrl =
//             await uploadImageToFirebase(garmFile, 'temp');

//         print("Uploaded VTON Image URL: $uploadedVtonImgUrl");
//         print("Uploaded GARM Image URL: $uploadedGarmImgUrl");
//         // API'ye istek gönder
//         print("istek yolluyorum");
//         var response = await http.post(
//           Uri.parse(apiUrl),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: jsonEncode({
//             'vton_img': uploadedVtonImgUrl,
//             'garm_img': uploadedGarmImgUrl,
//           }),
//         );
//         print("istek yollandı");

//         if (response.statusCode == 200) {
//           // API'den dönen veriyi işle
//           setState(() {
//             imageData = response.bodyBytes;
//           });

//           // İşlenmiş resmi Firebase'e kaydet
//           File processedImageFile = await saveImageLocally(response.bodyBytes);
//           await uploadImageToFirebase(processedImageFile, 'processed');
//         } else {
//           throw Exception(
//               'Failed to load image. Status code: ${response.statusCode}');
//         }
//       } else {
//         throw Exception('Image URLs are not set.');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<File> saveImageLocally(Uint8List bytes) async {
//     final directory = await getTemporaryDirectory();
//     final imagePath = '${directory.path}/processed_image.png';
//     final imageFile = File(imagePath);
//     await imageFile.writeAsBytes(bytes);
//     return imageFile;
//   }

//   void pickVtonImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         vtonImgUrl = image.path;
//       });
//     }
//   }

//   void pickGarmImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         garmImgUrl = image.path;
//       });
//     }
//   }

//   void navigateToCategory(String category) {
//     setState(() {
//       switch (category) {
//         case 'upper':
//           apiUrl =
//               "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";
//           break;
//         case 'lower':
//           apiUrl =
//               "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_lower_body";
//           break;
//         case 'dress':
//           apiUrl =
//               "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_dress";
//           break;
//       }
//     });

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImageUploadScreen(
//             apiUrl: apiUrl,
//             onProcessImages: processImages,
//             onSaveImage: uploadImageToFirebase,
//             text: text),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => NotificationScreen()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => MessagesScreen()));
//             },
//           ),
//         ],
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(
//               'assets/images/fit4try_logo.png'), // Logonuzu buraya ekleyin
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Kıyafet Denemek Hiç Bu Kadar Kolay Olmamıştı!',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               InkWell(
//                   onTap: () {
//                     navigateToCategory('upper');
//                     setState(() {
//                       text = " Üst Giyim";
//                     });
//                   },
//                   child: Container(
//                     child: Column(
//                       children: [
//                         Image.asset("assets/images/ai_ust.png",
//                             width: 100, height: 100),
//                         Text("Üst Giyim")
//                       ],
//                     ),
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                   onTap: () {
//                     navigateToCategory('lower');
//                     setState(() {
//                       text = " Alt Giyim";
//                     });
//                   },
//                   child: Container(
//                     child: Column(
//                       children: [
//                         Image.asset("assets/images/ai_alt.png",
//                             width: 100, height: 100),
//                         Text("Alt Giyim")
//                       ],
//                     ),
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                   onTap: () {
//                     navigateToCategory('dress');
//                     setState(() {
//                       text = " Elbise";
//                     });
//                   },
//                   child: Container(
//                     child: Column(
//                       children: [
//                         Image.asset("assets/images/ai_elbise.png",
//                             width: 100, height: 100),
//                         Text("Elbise")
//                       ],
//                     ),
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ImageUploadScreen extends StatefulWidget {
//   final String apiUrl;
//   final Future<void> Function() onProcessImages;
//   final Future<String> Function(File, String) onSaveImage;
//   final String text;

//   ImageUploadScreen(
//       {required this.apiUrl,
//       required this.onProcessImages,
//       required this.onSaveImage,
//       required this.text});

//   @override
//   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// }

// class _ImageUploadScreenState extends State<ImageUploadScreen> {
//   String? vtonImgUrl;
//   String? garmImgUrl;
//   Uint8List imageData = Uint8List(0);
//   bool isLoading = false;

//   void pickVtonImage() async {
//     final XFile? image =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         vtonImgUrl = image.path;
//       });
//     }
//   }

//   void pickGarmImage() async {
//     final XFile? image =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         garmImgUrl = image.path;
//       });
//     }
//   }

//   Future<void> processAndSaveImages() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       if (vtonImgUrl != null && garmImgUrl != null) {
//         // Resimleri işleyin ve kaydedin
//         await widget.onProcessImages();
//         // Resimleri Firebase'e yükleyin
//         File vtonFile = File(vtonImgUrl!);
//         File garmFile = File(garmImgUrl!);
//         await widget.onSaveImage(vtonFile, 'temp');
//         await widget.onSaveImage(garmFile, 'temp');
//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Image URLs are not set.');
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload'),
//       ),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     widget.text,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   // Yüklenen resimler
//                   if (vtonImgUrl != null)
//                     Image.file(
//                       File(vtonImgUrl!),
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   SizedBox(height: 10),
//                   if (garmImgUrl != null)
//                     Image.file(
//                       File(garmImgUrl!),
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   SizedBox(height: 20),
//                   // Butonlar
//                   if (vtonImgUrl == null || garmImgUrl == null)
//                     Column(
//                       children: [
//                         ElevatedButton(
//                           onPressed: pickVtonImage,
//                           child: Text("Resminizi Yükleyin"),
//                         ),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: pickGarmImage,
//                           child: Text("Ürünün resmini yükleyin"),
//                         ),
//                       ],
//                     ),
//                   if (vtonImgUrl != null && garmImgUrl != null)
//                     ElevatedButton(
//                       onPressed: processAndSaveImages,
//                       child: Text("İşle"),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io'; // Import dart:io to use File
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class AiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedCategory;
  String? vtonImgUrl;
  String? garmImgUrl;
  String apiUrl = "";
  Uint8List? imageData;
  final ImagePicker _picker = ImagePicker();
  bool showImageButtons = false;
  bool showProcessButton = false;
  bool isProcessing = false;
  String? personalImageUrl;
  String? clothingImageUrl;

  Future<void> pickImage(String imageType) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      String fileName = path.basename(imageFile.path);

      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        if (imageType == 'personal') {
          personalImageUrl = downloadUrl;
        } else if (imageType == 'clothing') {
          clothingImageUrl = downloadUrl;
        }

        showProcessButton =
            personalImageUrl != null && clothingImageUrl != null;
      });
    }
  }

  Future<void> processImages() async {
    if (personalImageUrl != null && clothingImageUrl != null) {
      setState(() {
        isProcessing = true;
      });

      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'vton_img': personalImageUrl!,
            'garm_img': clothingImageUrl!,
          }),
        );
        print("response geldi : ${response.body}");
        if (response.statusCode == 200) {
          setState(() {
            imageData = response.bodyBytes;
          });
        } else {
          throw Exception(
              'Failed to load image. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      } finally {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  Widget categoryContainer(String label, String imagePath, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
          showImageButtons = true;
          // Set the API URL based on the selected category
          apiUrl = category == 'upper'
              ? "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body"
              : category == 'lower'
                  ? "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_lower_body"
                  : "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_dress";
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/fit4try_logo2.png",
            width: 120,
            height: 120,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icon/bildirim.png'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: Image.asset('assets/icon/send.png'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MessagesScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor3,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!showImageButtons) ...[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      categoryContainer(
                          'Üst Giyim', 'assets/images/ai_ust.png', 'upper'),
                      categoryContainer(
                          'Alt Giyim', 'assets/images/ai_alt.png', 'lower'),
                      categoryContainer(
                          'Elbise', 'assets/images/ai_elbise.png', 'dress'),
                    ],
                  ),
                ] else if (selectedCategory != null) ...[
                  SizedBox(height: 20),
                  MyButton(
                    text: 'Kendi Resmini Seç',
                    buttonColor: AppColors.primaryColor3,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 16,
                    buttonTextWeight: FontWeight.bold,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () => pickImage('personal'),
                    buttonWidth: ButtonWidth.medium,
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    text: 'Kıyafetin Resmini Seç',
                    buttonColor: AppColors.secondaryColor2,
                    buttonTextColor: Colors.white,
                    buttonTextSize: 16,
                    buttonTextWeight: FontWeight.bold,
                    borderRadius: BorderRadius.circular(16),
                    onPressed: () => pickImage('clothing'),
                    buttonWidth: ButtonWidth.medium,
                  ),
                  SizedBox(height: 20),
                  if (showProcessButton)
                    MyButton(
                      text: 'Resimleri İşle',
                      buttonColor: Colors.orange,
                      buttonTextColor: Colors.white,
                      buttonTextSize: 16,
                      buttonTextWeight: FontWeight.bold,
                      borderRadius: BorderRadius.circular(16),
                      onPressed: processImages,
                      buttonWidth: ButtonWidth.large,
                    ),
                ],
                SizedBox(height: 20),
                if (imageData != null)
                  Image.memory(
                    imageData!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                else
                  Container(),
                SizedBox(height: 20),
                if (imageData != null)
                  MyButton(
                    text: 'Dolaba Kaydet',
                    buttonColor: Colors.red,
                    buttonTextColor: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    buttonTextSize: 16,
                    buttonTextWeight: FontWeight.bold,
                    onPressed: () {
                      // Save to closet functionality here
                    },
                    buttonWidth: ButtonWidth.large,
                  ),
              ],
            ),
          ),
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
