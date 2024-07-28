import 'dart:async';

import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({Key? key}) : super(key: key);

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  bool _isPasswordVisible = false;
  bool _isNextButtonEnabled = false;

  late StreamController<bool> _buttonStateController;

  Map<int, Color> _stepColors = {
    0: AppColors.primaryColor1,
    1: AppColors.primaryColor2,
    2: AppColors.primaryColor3,
    3: AppColors.primaryColor4,
    4: AppColors.primaryColor5,
  };

  @override
  void initState() {
    super.initState();

    // Initialize StreamController
    _buttonStateController = StreamController<bool>.broadcast();

    // Listen to changes in text fields
    for (var controller in _controllers) {
      controller.addListener(_updateNextButtonState);
    }
  }

  @override
  void dispose() {
    _buttonStateController.close(); // Close the stream controller
    for (var controller in _controllers) {
      controller.removeListener(_updateNextButtonState);
      controller.dispose();
    }
    super.dispose();
  }

  void _updateNextButtonState() {
    bool isFilled = _areAllFieldsFilled();
    _buttonStateController.add(isFilled); // Notify stream of state change
    setState(() {
      _isNextButtonEnabled = isFilled;
    });
  }

  void _nextPage() {
    if (_currentStep < 4) {
      if (_currentStep == 0) {
        // Perform the user info submission before going to the next page
        submitUserInfo(context);
      } else if (_currentStep == 1) {
        // Send verification code
        sendVerificationCode();
      }
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  bool _areAllFieldsFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  void submitUserInfo(BuildContext context) {
    print(_controllers[0].text);
    print(_controllers[1].text);
    print(_controllers[2].text);
    print(_controllers[3].text);
    print(_controllers[4].text);
    final authBloc = context.read<AuthBloc>;

    print("User information submitted.");
  }

  void sendVerificationCode() {
    // E-posta doğrulama kodu gönderme kodu buraya gelecek.
    print("Verification code sent.");
  }

  Future<void> pickImageFromGallery() async {
    // Galeriden resim seçme kodu buraya gelecek.
    print("Image picked from gallery.");
  }

  Future<void> takePhoto() async {
    // Kameradan fotoğraf çekme kodu buraya gelecek.
    print("Photo taken.");
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return UserInfoStep(
          controllers: _controllers,
          isPasswordVisible: _isPasswordVisible,
          togglePasswordVisibility: _togglePasswordVisibility,
        );
      case 1:
        return VerificationStep(
          controllers: _controllers,
        );
      case 2:
        return PhotoUploadStep(
          pickImageFromGallery: pickImageFromGallery,
          takePhoto: takePhoto,
        );
      case 3:
        return PlaceholderStep(
          color: _stepColors[3]!,
          text: 'Step 4', // Replace with actual step content
        );
      case 4:
        return WelcomeStep();
      default:
        return Container();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 40.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: index <= _currentStep ? _stepColors[index] : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 75),
          _buildProgressBar(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildStepContent(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousPage,
                    child: Text('Geri'),
                  ),
                StreamBuilder<bool>(
                  stream: _buttonStateController.stream,
                  initialData: _isNextButtonEnabled,
                  builder: (context, snapshot) {
                    return MyButton(
                        text: "İleri",
                        borderRadius: BorderRadius.circular(16),
                        buttonColor: Colors.black,
                        buttonTextColor: AppColors.backgroundColor1,
                        buttonTextSize: 20,
                        buttonTextWeight: FontWeight.normal,
                        onPressed: snapshot.data ?? false ? _nextPage : () {},
                        buttonWidth: ButtonWidth.xLarge);
                    // ElevatedButton(
                    //   onPressed: snapshot.data ?? false ? _nextPage : null,
                    //   style: ButtonStyle(
                    //     backgroundColor:

                    //   ),
                    //   child: Text('İleri'),
                    // );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UserInfoStep extends StatelessWidget {
  final List<TextEditingController> controllers;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;

  UserInfoStep({
    required this.controllers,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kullanıcı Bilgileri 👤',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[0],
              decoration: InputDecoration(
                labelText: 'İsim Soyisim',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[1],
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(
                labelText: 'E-mail Adresi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[3],
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[4],
              decoration: InputDecoration(
                labelText: 'Şifre Tekrar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationStep extends StatelessWidget {
  final List<TextEditingController> controllers;

  VerificationStep({required this.controllers});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E-posta Doğrulama 📧',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Lütfen e-posta adresinize gönderilen doğrulama kodunu girin.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(
                labelText: 'Doğrulama Kodu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoUploadStep extends StatelessWidget {
  final VoidCallback pickImageFromGallery;
  final VoidCallback takePhoto;

  PhotoUploadStep({
    required this.pickImageFromGallery,
    required this.takePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fotoğraf Yükle 📷',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: Text('Galeriden Seç'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: takePhoto,
              child: Text('Kamera ile Çek'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hoş Geldiniz 🎉',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Konfeti efekti buraya eklenecek.
          Text(
            'Tebrikler! Kaydınız başarıyla tamamlandı.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PlaceholderStep extends StatelessWidget {
  final Color color;
  final String text;

  const PlaceholderStep({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
