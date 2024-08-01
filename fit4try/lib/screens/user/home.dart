import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home_page_screen.dart';
import 'package:fit4try/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePagess(
        initialIndex: 0,
      ),
    );
  }
}

class MyHomePagess extends StatefulWidget {
  final int initialIndex;

  MyHomePagess({this.initialIndex = 0}); // Default index is 0

  @override
  _MyHomePageStatess createState() => _MyHomePageStatess();
}

class _MyHomePageStatess extends State<MyHomePagess> {
  late int _currentIndex;

  final List<Widget> _pages = [
    HomeTab(),
    CommunityScreen(),
    AiScreen(),
    GuardScreen(),
    ProfileScreen(),
  ];

  String? profilePhotoUrl;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Use the initialIndex
    profilePhotoUrl =
        'assets/images/placeholder_profile.jpg'; // Change this to null to simulate no profile photo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor1,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
}
