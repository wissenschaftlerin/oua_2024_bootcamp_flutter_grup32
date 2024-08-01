import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/bloc/auth/auth_state.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_stylest.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_user.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:fit4try/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class SignUpStylest extends StatefulWidget {
  const SignUpStylest({super.key});

  @override
  State<SignUpStylest> createState() => _SignUpStylestState();
}

class _SignUpStylestState extends State<SignUpStylest> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final List<TextEditingController> _controllers =
      List.generate(7, (_) => TextEditingController());
  late StreamController<bool> _buttonStateController;
  final AuthBloc _authBloc = AuthBloc();
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
              _controllers[3].text, _controllers[6].text,
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
          _controllers[3].text,
          _controllers[6].text,
          1, // methodsType değişkenini burada belirleyin
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
      } else if (_currentStep == 4) {
        setState(() {
          _currentStep++;
        });
      }
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return StylestInfoStep(
                          nameController: _controllers[0],
                          usernameController: _controllers[1],
                          emailController: _controllers[2],
                          passwordController: _controllers[3],
                          passwordControlleragain: _controllers[4]);
                    case 1:
                      return VerificationStep(
                        verificationController: _controllers[5],
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
                      return DeneyimStep(
                          onNext: _nextPage,
                          bahsetmeController: _controllers[6]);
                    case 4:
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

class StylestInfoStep extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordControlleragain;
  // final VoidCallback onNext;

  StylestInfoStep({
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordControlleragain,
    // required this.onNext,
  });

  @override
  _StylestInfoStepState createState() => _StylestInfoStepState();
}

class _StylestInfoStepState extends State<StylestInfoStep> {
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

class DeneyimStep extends StatefulWidget {
  final VoidCallback onNext;
  final TextEditingController bahsetmeController;

  DeneyimStep({required this.onNext, required this.bahsetmeController});

  @override
  _DeneyimStepState createState() => _DeneyimStepState();
}

class _DeneyimStepState extends State<DeneyimStep> {
  bool _fileSelected = false;
  File? _file;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _fileSelected = true;
      });
    }
  }

  void _uploadFileAndSaveLink() {
    if (_file != null) {
      BlocProvider.of<AuthBloc>(context).add(UploadFileEvent(_file!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen bir dosya seçin.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFileUploadSuccess) {
            BlocProvider.of<AuthBloc>(context)
                .add(UpdateUserInformation(state.fileUrl));
          } else if (state is AuthUpdateSuccess) {
            widget.onNext();
          } else if (state is AuthFileUploadFailure ||
              state is AuthUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Error: ${state is AuthFileUploadFailure ? state.error : (state as AuthUpdateFailure).error}'),
            ));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Deneyimlerinden Bahseder Misin?',
              style: fontStyle(28, Colors.black, FontWeight.bold),
              overflow: TextOverflow.visible,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'İçeride sana danışabilecek bir çok insan var. Bu sebeple seni daha yakından tanımak istiyoruz. İster kendini anlatabilir veya portföyünü koyabilirsin?',
              style: fontStyle(15, Colors.black, FontWeight.normal),
            ),
            SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: widget.bahsetmeController,
              hintText: "Kısaca kendinden bahseder misin?",
              obscureText: false,
              keyboardType: TextInputType.text,
              enabled: true,
              maxLines: 5,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: _fileSelected ? Icon(Icons.check) : Icon(Icons.attach_file),
              label: Text(
                "Dosya Ekle",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: _pickFile,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _uploadFileAndSaveLink,
              child: Text('Başla'),
            ),
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
            'Seni Biraz Bekleteceğiz',
            style: fontStyle(28, Colors.black, FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Bizimle paylaştığın bilgileri ekibimiz inceliyor. İnceleme bitene kadar uygulamada gezebilirsin. İnceleme bittiğinde herhangi bir sorun olması durumunda seninle iletişime geçeceğiz. Herhangi bir sorun olmaması durumunda Fit4Try hesabın onaylı olmuş olacak. En iyi dileklerimizle...',
            style: fontStyle(28, Colors.black, FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset("undraw_Chat_bot_re_e2gj.png", height: 100, width: 100),
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
