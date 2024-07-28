import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/text_field.dart';
import 'package:flutter/material.dart';

class NameChangedScreen extends StatefulWidget {
  const NameChangedScreen({super.key});

  @override
  State<NameChangedScreen> createState() => _NameChangedScreenState();
}

class _NameChangedScreenState extends State<NameChangedScreen> {
  TextEditingController controller = TextEditingController();
  bool isButtonEnabled = false;

  void _validateInput(String value) {
    setState(() {
      isButtonEnabled = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'İsim Soyisim',
          style: fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "İsim Soyisim",
                  style: fontStyle(
                      20, AppColors.secondaryColor2, FontWeight.normal),
                ),
                const SizedBox(height: 5),
                MyTextField(
                  controller: controller,
                  hintText: 'İsim Soyisim',
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  enabled: true,
                  onChanged: _validateInput,
                ),
              ],
            ),
            MyButton(
              text: "Kaydet",
              buttonColor:
                  isButtonEnabled ? AppColors.primaryColor4 : Colors.grey,
              buttonTextColor: Colors.white,
              buttonTextSize: 20,
              buttonTextWeight: FontWeight.normal,
              onPressed: isButtonEnabled
                  ? () {
                      print("basıldı");
                    }
                  : () {},
              buttonWidth: ButtonWidth.xxLarge,
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
      ),
    );
  }
}
