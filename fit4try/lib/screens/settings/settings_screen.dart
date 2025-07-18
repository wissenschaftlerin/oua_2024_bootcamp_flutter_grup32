import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/settings/application_details/application_details_screen.dart';
import 'package:fit4try/screens/settings/help_center/help_center_page.dart';
import 'package:fit4try/screens/settings/language_options/language_selection_page_screen.dart';
import 'package:fit4try/screens/settings/profile_settings/profile_settings_screen.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/screens/user/home_page_screen.dart';
import 'package:fit4try/screens/user/message_screen.dart';
import 'package:fit4try/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? profilePhotoUrl = 'assets/images/placeholder_profile.jpg';

    final List<Widget> pages = [
      HomeTab(),
      CommunityScreen(),
      GuardScreen(),
      AiScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
        title: Text(
          'Ayarlar',
          style: fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePagess(
                        initialIndex: 4,
                      )),
            );
            // Navigator.pop(context);
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
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileSettingsScreen()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.primaryColor3,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Profil Ayarları",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.public,
                            color: AppColors.primaryColor3,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Dil Ayarları",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileSettingsScreen()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.primaryColor4,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Stil Ayarları",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HelpCenterScreen()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: AppColors.primaryColor4,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Yardım Merkezi",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ApplicationDetailsScreen()));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.backgroundColor1,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Uygulama Hakkında",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    _showLogoutConfirmation(context);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Çıkış Yap",
                            style: fontStyle(15, AppColors.secondaryColor2,
                                FontWeight.normal),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor1,
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePagess(
                      initialIndex: index,
                    )),
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor5,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/home2.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/community.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/picture.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon/aı.png',
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/icon/foto.png'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.backgroundColor1,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Çıkış Yapmak Üzeresiniz',
                style:
                    fontStyle(20, AppColors.secondaryColor2, FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Çıkış yapmak istediğinizden emin misiniz?',
                style:
                    fontStyle(16, AppColors.secondaryColor2, FontWeight.normal),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text('İptal',
                        style: fontStyle(16, Colors.white, FontWeight.normal)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Çıkış Yap',
                        style: fontStyle(16, Colors.white, FontWeight.normal)),
                    onPressed: () {
                      // Çıkış yapma işlemi burada yapılır
                      Navigator.pop(context);
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
