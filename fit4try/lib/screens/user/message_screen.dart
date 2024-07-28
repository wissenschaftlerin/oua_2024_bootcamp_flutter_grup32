import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/widgets/text_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool obscureText = false;
  TextInputType keyboardType = TextInputType.text;
  bool enabled = true;

  List<Map<String, String>> messages = [
    {"from": "me", "message": "Hello!"},
    {"from": "you", "message": "Hi there!"},
  ];

  File? _selectedImage;

  void _sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add({"from": "me", "message": controller.text});
        controller.clear();
        _selectedImage = null;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeri'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Kamera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'ahmet.ege',
          style: fontStyle(20, AppColors.secondaryColor2, FontWeight.normal),
          textAlign: TextAlign.left,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                if (messages[index]["from"] == "me") {
                  return messageBoxMe(messages[index]["message"]!);
                } else {
                  return messageBoxYou(messages[index]["message"]!);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showImagePickerOptions(context),
                ),
                Expanded(
                  child: MyTextField(
                    prefixIcon: _selectedImage != null
                        ? Icon(Icons.image, color: AppColors.primaryColor5)
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                    controller: controller,
                    hintText: 'Mesajınızı yazın...',
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    enabled: enabled,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container messageBoxYou(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                AssetImage('assets/images/placeholder_profile.jpg'),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor3,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message,
                style:
                    fontStyle(15, AppColors.secondaryColor2, FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container messageBoxMe(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message,
                style: fontStyle(
                    15, AppColors.backgroundColor1, FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundImage:
                AssetImage('assets/images/placeholder_profile.jpg'),
          ),
        ],
      ),
    );
  }
}
