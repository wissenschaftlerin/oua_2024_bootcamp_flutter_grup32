import 'dart:async';
import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:fit4try/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  late StreamController<bool> _buttonStateController;
  final AuthBloc _authBloc = AuthBloc();
  Map<int, Color> _stepColors = {
    // 0: AppColors.primaryColor1,
    0: AppColors.primaryColor2,
    1: AppColors.primaryColor3,
    2: AppColors.primaryColor4,
    3: AppColors.primaryColor5,
  };

  @override
  void initState() {
    super.initState();
    _buttonStateController = StreamController<bool>.broadcast();
    for (var controller in _controllers) {
      controller.addListener(_updateNextButtonState);
    }
  }

  @override
  void dispose() {
    _buttonStateController.close();
    for (var controller in _controllers) {
      controller.removeListener(_updateNextButtonState);
      controller.dispose();
    }
    super.dispose();
  }

  void _updateNextButtonState() {
    bool isFilled = _controllers[_currentStep].text.isNotEmpty;
    _buttonStateController.add(isFilled);
  }

  void _nextPage() {
    if (_currentStep < 4) {
      if (_currentStep == 0) {
        try {
          if (_controllers[3] != _controllers[4]) {
            print("sayfa 1 in next geçmeden hali");
            _authBloc.add(AuthUserInfoSubmitted(
              _controllers[0].text,
              _controllers[1].text,
              _controllers[2].text,
              _controllers[3].text, "",
              0, // methodsType değişkenini burada belirleyin
            ));
            print("tamamlandı");
            setState(() {
              _currentStep++;
            });
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          } else {
            showErrorSnackBar(context, "Şifreler eşleşmiyor");
          }
        } catch (e) {
          print("hata var");
        }
      } else if (_currentStep == 1) {
        print("asdasd");
        _authBloc.add(AuthUserInfoSubmitted(
          _controllers[0].text,
          _controllers[1].text,
          _controllers[2].text,
          _controllers[3].text, "",
          0, // methodsType değişkenini burada belirleyin
        ));
        print("tamamlandı");
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else if (_currentStep == 2) {
        setState(() {
          _currentStep++;
        });
      } else if (_currentStep == 3) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
      setState(() {
        _currentStep++;
      });
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

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
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
    return BlocProvider(
      create: (context) => _authBloc,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor1,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 75),
            _buildProgressBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return UserInfoStep(
                          nameController: _controllers[0],
                          usernameController: _controllers[1],
                          emailController: _controllers[2],
                          passwordController: _controllers[3],
                          passwordControlleragain: _controllers[4]
                          // onNext: () async {
                          //   try {
                          //     // print("asdasd");
                          //     // _authBloc.add(AuthUserInfoSubmitted(
                          //     //   _controllers[0].text,
                          //     //   _controllers[1].text,
                          //     //   _controllers[2].text,
                          //     //   _controllers[3].text,
                          //     //   0, // methodsType değişkenini burada belirleyin
                          //     // ));
                          //     // print("tamamlandı");
                          //     // _nextPage();
                          //   } catch (e) {
                          //     print("$e");
                          //   }
                          // },
                          );
                    case 1:
                      return VerificationStep(
                        verificationController: _controllers[4],
                        // onNext: () {
                        //   // _authBloc.add(AuthVerificationCodeSubmitted(
                        //   //     _controllers[4].text));
                        //   // _nextPage();
                        // },
                      );
                    case 2:
                      return PhotoUploadStep(
                        onNext: (photoUrl) {
                          _authBloc.add(AuthPhotoUploaded(photoUrl));
                          _nextPage();
                        },
                      );

                    case 3:
                      return WelcomeStep(onNext: _nextPage);
                    default:
                      return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    MyButton(
                      text: "Geri",
                      buttonColor: AppColors.secondaryColor2,
                      buttonTextColor: Colors.white,
                      buttonTextSize: 15,
                      buttonTextWeight: FontWeight.normal,
                      borderRadius: BorderRadius.circular(16),
                      onPressed: _previousPage,
                      buttonWidth: ButtonWidth.small,
                    ),
                  StreamBuilder<bool>(
                    stream: _buttonStateController.stream,
                    initialData: false,
                    builder: (context, snapshot) {
                      return MyButton(
                          text: "İleri",
                          buttonColor: AppColors.primaryColor2,
                          buttonTextColor: Colors.white,
                          buttonTextSize: 20,
                          buttonTextWeight: FontWeight.normal,
                          borderRadius: BorderRadius.circular(16),
                          onPressed: snapshot.data! ? _nextPage : () {},
                          buttonWidth: ButtonWidth.large);
                      // ElevatedButton(
                      //   onPressed: snapshot.data! ? _nextPage : null,
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
      ),
    );
  }
}

class UserInfoStep extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordControlleragain;
  // final VoidCallback onNext;

  UserInfoStep({
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordControlleragain,
    // required this.onNext,
  });

  @override
  _UserInfoStepState createState() => _UserInfoStepState();
}

class _UserInfoStepState extends State<UserInfoStep> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

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
            MyTextField(
                controller: widget.nameController,
                hintText: 'İsim Soyisim',
                obscureText: false,
                showBorder: true,
                keyboardType: TextInputType.multiline,
                enabled: true),
            SizedBox(height: 16),
            MyTextField(
                controller: widget.usernameController,
                hintText: 'Kullanıcı Adı',
                obscureText: false,
                showBorder: true,
                keyboardType: TextInputType.multiline,
                enabled: true),
            SizedBox(height: 16),
            MyTextField(
                controller: widget.emailController,
                hintText: 'Email',
                obscureText: false,
                showBorder: true,
                keyboardType: TextInputType.emailAddress,
                enabled: true),
            SizedBox(height: 16),
            MyTextField(
              controller: widget.passwordController,
              hintText: "Şifre",
              obscureText: _isPasswordVisible ? true : false,
              keyboardType: TextInputType.text,
              enabled: true,
              showBorder: true,
              onTap: _togglePasswordVisibility,
              maxLines: 1,
              suffixIcon: Icon(
                !_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            SizedBox(height: 16),
            MyTextField(
              controller: widget.passwordControlleragain,
              hintText: "Şifre Tekrar",
              obscureText: _isPasswordVisible ? true : false,
              keyboardType: TextInputType.text,
              enabled: true,
              showBorder: true,
              onTap: _togglePasswordVisibility,
              maxLines: 1,
              suffixIcon: Icon(
                !_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationStep extends StatelessWidget {
  final TextEditingController verificationController;
  // final VoidCallback onNext;

  VerificationStep({
    required this.verificationController,
    // required this.onNext,
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
              'Mailini Kontrol Et 📩',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
                "Doğrulama kodunu e-posta adresinize gönderdik. Lütfen e-postanızı kontrol edin ve e-postanızı doğrulamayı unutmayınız",
                style: fontStyle(15, Colors.black, FontWeight.normal)),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: onNext,
            //   child: Text('İleri'),
            // ),
          ],
        ),
      ),
    );
  }
}

class PhotoUploadStep extends StatelessWidget {
  final ValueChanged<String> onNext;

  PhotoUploadStep({required this.onNext});

  Future<void> _selectPhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String photoUrl = image.path;

      onNext(photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seni görmek harika! 💜",
              style: fontStyle(28, Colors.black, FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Buralar alev aldı. Seni görmek bir harika aramıza katılmana çok az kaldı. Hadi hemen fotoğrafını yükle ve aramıza katıl.",
              style: fontStyle(15, Colors.black, FontWeight.normal),
            ),
            SizedBox(
              height: 50,
            ),
            MyButton(
                text: "Galeriden Seç",
                buttonColor: AppColors.primaryColor3,
                buttonTextColor: Colors.white,
                buttonTextSize: 20,
                borderRadius: BorderRadius.circular(16),
                buttonTextWeight: FontWeight.normal,
                onPressed: () => _selectPhoto(ImageSource.gallery),
                buttonWidth: ButtonWidth.large),
            SizedBox(height: 16),
            MyButton(
                text: "Fotoğraf Çek",
                borderRadius: BorderRadius.circular(16),
                buttonColor: AppColors.primaryColor3,
                buttonTextColor: Colors.white,
                buttonTextSize: 20,
                buttonTextWeight: FontWeight.normal,
                onPressed: () => _selectPhoto(ImageSource.camera),
                buttonWidth: ButtonWidth.large),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class WelcomeStep extends StatelessWidget {
  final VoidCallback onNext;

  WelcomeStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Aramıza Hoş Geldin 🎉',
            style: fontStyle(28, Colors.black, FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/images/confetti.png'),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: onNext,
            child: Text('Başla'),
          ),
        ],
      ),
    );
  }
}
