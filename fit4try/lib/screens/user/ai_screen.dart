import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AiScreen extends StatefulWidget {
  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  String? vtonImgUrl;
  String? garmImgUrl;
  String apiUrl = "";
  String text = "";
  Uint8List imageData = Uint8List(0);
  final ImagePicker _picker = ImagePicker();

  Future<String> uploadImageToFirebase(
      File imageFile, String folderPath) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('$folderPath/$userId/$imageName.png');

        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        return downloadUrl;
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> processImages() async {
    try {
      if (vtonImgUrl != null && garmImgUrl != null) {
        // Resim dosyalarını al
        File vtonFile = File(vtonImgUrl!);
        File garmFile = File(garmImgUrl!);

        // Resimleri Firebase Storage'a yükle
        String uploadedVtonImgUrl =
            await uploadImageToFirebase(vtonFile, 'temp');
        String uploadedGarmImgUrl =
            await uploadImageToFirebase(garmFile, 'temp');

        // API'ye istek gönder
        var response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'vton_img': uploadedVtonImgUrl,
            'garm_img': uploadedGarmImgUrl,
          }),
        );

        if (response.statusCode == 200) {
          // API'den dönen veriyi işle
          setState(() {
            imageData = response.bodyBytes;
          });

          // İşlenmiş resmi Firebase'e kaydet
          File processedImageFile = await saveImageLocally(response.bodyBytes);
          await uploadImageToFirebase(processedImageFile, 'processed');
        } else {
          throw Exception(
              'Failed to load image. Status code: ${response.statusCode}');
        }
      } else {
        throw Exception('Image URLs are not set.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<File> saveImageLocally(Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/processed_image.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(bytes);
    return imageFile;
  }

  void pickVtonImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        vtonImgUrl = image.path;
      });
    }
  }

  void pickGarmImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        garmImgUrl = image.path;
      });
    }
  }

  void navigateToCategory(String category) {
    setState(() {
      switch (category) {
        case 'upper':
          apiUrl =
              "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_upper_body";
          break;
        case 'lower':
          apiUrl =
              "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_lower_body";
          break;
        case 'dress':
          apiUrl =
              "https://fit4try-api-ilvfamkmdq-uc.a.run.app/process_image_dress";
          break;
      }
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageUploadScreen(
            apiUrl: apiUrl,
            onProcessImages: processImages,
            onSaveImage: uploadImageToFirebase,
            text: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MessagesScreen()));
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
              'assets/images/fit4try_logo.png'), // Logonuzu buraya ekleyin
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kıyafet Denemek Hiç Bu Kadar Kolay Olmamıştı!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    navigateToCategory('upper');
                    setState(() {
                      text = " Üst Giyim";
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/ai_ust.png",
                            width: 100, height: 100),
                        Text("Üst Giyim")
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    navigateToCategory('lower');
                    setState(() {
                      text = " Alt Giyim";
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/ai_alt.png",
                            width: 100, height: 100),
                        Text("Alt Giyim")
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    navigateToCategory('dress');
                    setState(() {
                      text = " Elbise";
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/ai_elbise.png",
                            width: 100, height: 100),
                        Text("Elbise")
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  final String apiUrl;
  final Future<void> Function() onProcessImages;
  final Future<String> Function(File, String) onSaveImage;
  final String text;

  ImageUploadScreen(
      {required this.apiUrl,
      required this.onProcessImages,
      required this.onSaveImage,
      required this.text});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String? vtonImgUrl;
  String? garmImgUrl;
  Uint8List imageData = Uint8List(0);
  bool isLoading = false;

  void pickVtonImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        vtonImgUrl = image.path;
      });
    }
  }

  void pickGarmImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        garmImgUrl = image.path;
      });
    }
  }

  Future<void> processAndSaveImages() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (vtonImgUrl != null && garmImgUrl != null) {
        // Resimleri işleyin ve kaydedin
        await widget.onProcessImages();
        // Resimleri Firebase'e yükleyin
        File vtonFile = File(vtonImgUrl!);
        File garmFile = File(garmImgUrl!);
        await widget.onSaveImage(vtonFile, 'temp');
        await widget.onSaveImage(garmFile, 'temp');
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Image URLs are not set.');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Yüklenen resimler
                  if (vtonImgUrl != null)
                    Image.file(
                      File(vtonImgUrl!),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 10),
                  if (garmImgUrl != null)
                    Image.file(
                      File(garmImgUrl!),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 20),
                  // Butonlar
                  if (vtonImgUrl == null || garmImgUrl == null)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: pickVtonImage,
                          child: Text("Resminizi Yükleyin"),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: pickGarmImage,
                          child: Text("Ürünün resmini yükleyin"),
                        ),
                      ],
                    ),
                  if (vtonImgUrl != null && garmImgUrl != null)
                    ElevatedButton(
                      onPressed: processAndSaveImages,
                      child: Text("İşle"),
                    ),
                ],
              ),
      ),
    );
  }
}
