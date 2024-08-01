//burada intro için oluşturduğum 5 sayfanın görüntüsü var

import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/auth/sign_in/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: Image.asset("assets/images/image1.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Sanal Kıyafet Deneme",
                      style: TextStyle(
                        color: AppColors.backgroundColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      "Kullanıcılar, stilistlerin önerdiği kıyafetleri veya kendi seçtikleri kıyafetleri mobil uygulama üzerinden sanal olarak deneyebilirler.",
                      style: TextStyle(
                        color: AppColors.backgroundColor2.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: Image.asset("assets/images/image2.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Kendi Kıyafetlerini Tasarla",
                      style: TextStyle(
                        color: AppColors.backgroundColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      "Kullanıcılar, kendi kıyafetlerini çizerek veya tasarlayarak dolabına ekleyebilir hatta tasarımlarını paylaşabilir.",
                      style: TextStyle(
                        color: AppColors.backgroundColor2.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: Image.asset("assets/images/image3.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 60, right: 40),
                    child: Text(
                      "Tarzını Stil Danışmanına veya Yapay Zeka’ya Danış",
                      style: TextStyle(
                        color: AppColors.backgroundColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      "Kullanıcılar, kendi kıyafetlerini çizerek veya tasarlayarak dolabına ekleyebilir hatta tasarımlarını paylaşabilirsin",
                      style: TextStyle(
                        color: AppColors.backgroundColor2.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: Image.asset("assets/images/image4.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Topluluk ve Sosyal Paylaşım",
                      style: TextStyle(
                        color: AppColors.backgroundColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      "Kullanıcılar, tasarımlarını toplulukla paylaşabilir, beğeni ve geri bildirim alabilirler.",
                      style: TextStyle(
                        color: AppColors.backgroundColor2.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

class Screen5 extends StatelessWidget {
  const Screen5({super.key});

  Future<void> _setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 260),
            child: Center(
              child: Image.asset("assets/images/image5.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor5,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Ödül Sistemi",
                      style: TextStyle(
                        color: AppColors.backgroundColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      "En çok kıyafet tarzı sunan kullanıcıların yanısıra uygulama içerisinde sende stilist olabilir hatta çeşitli ödüller kazanabilirsin.",
                      style: TextStyle(
                        color: AppColors.backgroundColor2.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _setOnboardingCompleted();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignInScreen()), // Replace NextScreen with your next screen's class
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.white, // button color
                        backgroundColor:
                            AppColors.backgroundColor2, // text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Devam Et",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor5,
                        ),
                      ),
                    ),
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
