// login ekranının görüntüsü

import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_screen.dart';
import 'package:fit4try/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// pubspec.yaml dosyasına eklenenler
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String selectedUserType = 'Bireysel'; // Varsayılan seçim
  List<bool> isSelected = [true, false]; // ToggleButtons durumu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
              child: Column(
                children: [
                  selectedUserType == 'Bireysel'
                      ? const SignInForm(
                          formType: 'B',
                        )
                      : const SignInForm(
                          formType: 'S',
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 100,
            child: Container(
              width: 300,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                    selectedUserType = index == 0 ? 'Bireysel' : 'Stilist';
                  });
                },
                borderRadius: BorderRadius.circular(24.0),
                borderWidth: 0,
                fillColor: Color(0xFF8819DC),
                selectedColor: Colors.white,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 53.0),
                    child: Text('Bireysel'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 52.0),
                    child: Text('Stilist'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final String formType;

  const SignInForm({super.key, required this.formType});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isFormValid = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      isFormValid = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthBloc(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/fit4try_logo.png",
                  width: 200,
                  height: 200,
                ),
              ),
              MyTextField(
                  controller: usernameController,
                  hintText: "E-Mail",
                  obscureText: false,
                  showBorder: true,
                  keyboardType: TextInputType.emailAddress,
                  enabled: true),
              const SizedBox(height: 16),
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: !isPasswordVisible,
                  maxLines: 1,
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  showBorder: true,
                  keyboardType: TextInputType.emailAddress,
                  enabled: true),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: isFormValid
                    ? () {
                        if (formKey.currentState!.validate()) {
                          // Perform login action
                          print("Giriş yaps");
                          if (formKey.currentState!.validate()) {
                            print(usernameController.text);
                            print(passwordController.text);
                            context.read<AuthBloc>().add(
                                SignInWithEmailAndPassword(
                                    email: usernameController.text,
                                    password: passwordController.text));
                          }
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid
                      ? const Color(0xFF8819DC)
                      : const Color(0xFFC1AFCF),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Giriş Yap',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Perform Google login action
                  context.read<AuthBloc>().add(GoogleSignInEvent());
                },
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFFCCCCCC),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFCCCCCC),
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Color(0xFFCCCCCC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                label: const Text('Google ile Giriş Yap'),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hesabınız yok mu?',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Kayıt Ol',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password screen
                      },
                      child: Text(
                        'Şifremi Unuttum',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
