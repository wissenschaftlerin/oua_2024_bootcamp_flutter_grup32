import 'dart:async';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/text_field.dart';

class EmailChangedScreen extends StatefulWidget {
  const EmailChangedScreen({super.key});

  @override
  State<EmailChangedScreen> createState() => _EmailChangedScreenState();
}

class _EmailChangedScreenState extends State<EmailChangedScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController emailConfirmController = TextEditingController();
  bool isButtonEnabled = false;

  void _validateInput() {
    setState(() {
      isButtonEnabled = emailController.text.isNotEmpty &&
          emailConfirmController.text.isNotEmpty &&
          emailController.text == emailConfirmController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'Mail Adresi',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mail Adresi",
                      style: fontStyle(
                          20, AppColors.secondaryColor2, FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Mail Adresi',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      enabled: true,
                      onChanged: (value) {
                        _validateInput();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mail Adresi Tekrar",
                      style: fontStyle(
                          20, AppColors.secondaryColor2, FontWeight.normal),
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      controller: emailConfirmController,
                      hintText: 'Mail Adresi Tekrar',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      enabled: true,
                      onChanged: (value) {
                        _validateInput();
                      },
                    ),
                  ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailVerificationScreen(
                            email: emailController.text,
                          ),
                        ),
                      );
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

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  bool isButtonEnabled = false;
  Timer? _timer;
  int _start = 1500;

  void _validateInput() {
    setState(() {
      isButtonEnabled =
          _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        Navigator.pop(context); // Süre dolunca geri git
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    for (var controller in _controllers) {
      controller.addListener(_validateInput);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String getCode() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      // appBar: AppBar(
      //   backgroundColor: AppColors.backgroundColor1,
      //   title: Text(
      //     'Mail Doğrulama',
      //     style: fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
      //   ),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mailini Kontrol Et 📩",
                    style: fontStyle(25, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Doğrulama kodunu e-posta adresinize gönderdik. Lütfen e-postaızı kontrol edin ve aşağıya kodu girin",
                    style: fontStyle(
                        15, AppColors.secondaryColor2, FontWeight.normal),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 40,
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          onChanged: (_) {
                            _validateInput();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (_start == 1500) {
                              showErrorSnackBar(context,
                                  "Lütfen sürenin dolmasını bekleyiniz.");
                            } else {
                              _timer?.cancel();
                              startTimer();
                              showSuccessSnackBar(context,
                                  "Adresinize yeni bir kod gönderildi");
                            }
                          },
                          child: Text(
                            'Kodu Resetle',
                            style: fontStyle(
                                15, AppColors.primaryColor5, FontWeight.normal),
                          )),
                      Text(
                        '$_start saniye kaldı',
                        style: fontStyle(
                            15, AppColors.secondaryColor2, FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: MyButton(
              text: "Doğrula",
              buttonColor:
                  isButtonEnabled ? AppColors.primaryColor4 : Colors.grey,
              buttonTextColor: Colors.white,
              buttonTextSize: 20,
              buttonTextWeight: FontWeight.normal,
              onPressed: isButtonEnabled
                  ? () {
                      // Doğrulama işlemini burada yap
                      String code = getCode();
                      // Doğrulama başarılı olursa geri git
                      Navigator.pop(context);
                    }
                  : () {},
              buttonWidth: ButtonWidth.xxLarge,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
