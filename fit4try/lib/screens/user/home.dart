import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home_screen.dart';
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
    HomeScreen(),
    CommunityScreen(),
    GuardScreen(),
    AiScreen(),
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
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: AppColors.backgroundColor1,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
}
