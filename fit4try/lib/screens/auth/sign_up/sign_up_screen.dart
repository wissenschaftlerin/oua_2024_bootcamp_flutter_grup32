import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_stylest.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_user.dart';
import 'package:fit4try/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
              "Hoş Geldin",
              style: fontStyle(20, Colors.black, FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
                child: Text(
              "Lütfen hesap türünüzü seçiniz",
              style: fontStyle(15, Colors.black, FontWeight.normal),
            )),
            SizedBox(
              height: 16,
            ),
            Container(
                child: Image.asset(
              "assets/images/undraw_Welcoming_re_x0qo_1.png",
              width: 300,
              height: 300,
            )),
            SizedBox(
              height: 16,
            ),
            Container(
                child: MyButton(
              text: "Bireysel",
              borderRadius: BorderRadius.circular(20),
              buttonColor: AppColors.primaryColor4,
              buttonTextColor: Colors.white,
              buttonTextSize: 20,
              buttonTextWeight: FontWeight.normal,
              onPressed: () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const SignUpUser())),
              buttonWidth: ButtonWidth.medium,
            )),
            SizedBox(
              height: 16,
            ),
            Container(
                child: Text(
              "Ya da",
              style: fontStyle(15, Colors.grey, FontWeight.normal),
            )),
            SizedBox(
              height: 16,
            ),
            Container(
                child: MyButton(
              borderRadius: BorderRadius.circular(20),
              text: "Stilist",
              buttonColor: AppColors.secondaryColor2,
              buttonTextColor: Colors.white,
              buttonTextSize: 20,
              buttonTextWeight: FontWeight.normal,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const SignUpStylest()));
              },
              buttonWidth: ButtonWidth.medium,
            )),
          ],
        ),
      ),
    );
  }
}
