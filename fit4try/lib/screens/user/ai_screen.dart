import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:fit4try/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart'; // Make sure to include Firestore package

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

  Future<void> saveToCloset() async {
    if (imageData != null) {
      try {
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.png';
        final storageRef = FirebaseStorage.instance.ref().child(fileName);
        final uploadTask = storageRef.putData(imageData!);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Assuming you have user's UID available as `userId`
        String userId = 'YOUR_USER_ID_HERE'; // Replace with actual user ID

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('dolap')
            .add({'imageUrl': downloadUrl});

        showSuccessSnackBar(context, "Resim başarıyla kaydedildi!");
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Widget categoryContainer(String label, String imagePath, String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
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
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "$imagePath",
                width: 100,
                height: 100,
              ),
            ),
            Text(
              "$label",
              style:
                  fontStyle(18, AppColors.secondaryColor2, FontWeight.normal),
            ),
          ],
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
            child: imageData == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!showImageButtons) ...[
                        Container(
                          padding: EdgeInsets.all(28),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Kıyafet Denemek Hiç Bu Kadar Kolay Olmamıştı!",
                                textAlign: TextAlign.center,
                                style: fontStyle(20, AppColors.secondaryColor2,
                                    FontWeight.bold),
                              ),
                              categoryContainer('Üst Giyim',
                                  'assets/images/ai_ust.png', 'upper'),
                              categoryContainer('Alt Giyim',
                                  'assets/images/ai_alt.png', 'lower'),
                              categoryContainer('Elbise',
                                  'assets/images/ai_elbise.png', 'dress'),
                            ],
                          ),
                        ),
                      ] else if (selectedCategory != null) ...[
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "$selectedCategory",
                                style: fontStyle(28, AppColors.secondaryColor2,
                                    FontWeight.bold),
                              ),
                              SizedBox(height: 40),
                              InkWell(
                                onTap: () => pickImage('personal'),
                                child: DottedBorder(
                                  color: AppColors.secondaryColor2,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 25),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.upload,
                                          size: 25,
                                          color: AppColors.secondaryColor2,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Resmini Yüklemek İçin Tıkla",
                                          textAlign: TextAlign.center,
                                          style: fontStyle(
                                              18,
                                              AppColors.secondaryColor2,
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () => pickImage('clothing'),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryColor2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.camera,
                                        size: 25,
                                        color: AppColors.secondaryColor2,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Ürünün Resmini Yüklemek İçin Tıkla",
                                        textAlign: TextAlign.center,
                                        style: fontStyle(
                                            18,
                                            AppColors.secondaryColor2,
                                            FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              if (showProcessButton)
                                MyButton(
                                  text: 'Resimleri İşle',
                                  buttonColor: AppColors.primaryColor5,
                                  buttonTextColor: Colors.white,
                                  buttonTextSize: 16,
                                  buttonTextWeight: FontWeight.bold,
                                  borderRadius: BorderRadius.circular(16),
                                  onPressed: processImages,
                                  buttonWidth: ButtonWidth.large,
                                ),
                            ],
                          ),
                        )
                      ],
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.memory(
                        imageData!,
                        width: 300,
                        height: 400,
                        // fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        text: 'Dolaba Kaydet',
                        buttonColor: AppColors.primaryColor5,
                        buttonTextColor: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        buttonTextSize: 16,
                        buttonTextWeight: FontWeight.bold,
                        onPressed: saveToCloset,
                        buttonWidth: ButtonWidth.large,
                      ),
                    ],
                  ),
          ),
          if (isProcessing)
            Container(
              color: Colors.black54,
              child: Center(
                child: LoadingWidget(),
              ),
            ),
        ],
      ),
    );
  }
}
