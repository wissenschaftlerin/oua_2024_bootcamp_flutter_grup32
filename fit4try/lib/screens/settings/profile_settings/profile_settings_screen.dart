import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/settings/profile_settings/email_changed/email_changed_screen.dart';
import 'package:fit4try/screens/settings/profile_settings/name_changed/name_changed_screen.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home_screen.dart';
import 'package:fit4try/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  String? profilePhotoUrl = 'assets/images/placeholder_profile.jpg';

  final List<Widget> pages = [
    HomeScreen(),
    CommunityScreen(),
    GuardScreen(),
    AiScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'Profil Ayarları',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSettingsItem(
              context,
              "İsim Soyisim",
              "Kaan Yiğit",
              NameChangedScreen(),
            ),
            _buildSettingsItem(
              context,
              "Email Adresi",
              "test_user@gmail.com",
              EmailChangedScreen(),
            ),
            _buildSettingsItem(
              context,
              "Şifre",
              "*******************",
              NameChangedScreen(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: AppColors.backgroundColor1,
        currentIndex: 4,
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
          );
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            selectedColor: AppColors.primaryColor5,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.group),
            title: Text('Community'),
            selectedColor: AppColors.primaryColor5,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.lock),
            title: Text('Guard'),
            selectedColor: AppColors.primaryColor5,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.star),
            title: Text('AI'),
            selectedColor: AppColors.primaryColor5,
            unselectedColor: Colors.grey,
          ),
          SalomonBottomBarItem(
            icon: profilePhotoUrl != null
                ? CircleAvatar(
                    backgroundImage: AssetImage(profilePhotoUrl!),
                  )
                : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            title: Text('Profile'),
            selectedColor: AppColors.primaryColor5,
            unselectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context, String title, String subtitle, Widget screen) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.2, color: Colors.grey),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: fontStyle(
                        15, AppColors.secondaryColor2, FontWeight.normal),
                  ),
                  Text(
                    subtitle,
                    style: fontStyle(15, Colors.grey, FontWeight.normal),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
