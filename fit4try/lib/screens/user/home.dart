import 'package:flutter/material.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home_page_screen.dart';
import 'package:fit4try/screens/user/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String? profilePhotoUrl;

  final List<Widget> _pages = [
    HomeTab(),
    CommunityScreen(),
    AiScreen(),
    GuardScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _fetchProfilePhotoUrl();
  }

  Future<void> _fetchProfilePhotoUrl() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            profilePhotoUrl = userDoc.get('photoUrl');
          });
        }
      }
    } catch (e) {
      print('Error fetching profile photo URL: $e');
    }
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
              _currentIndex == 0
                  ? 'assets/icon/home2.png' // Selected icon
                  : 'assets/icon/home.png', // Unselected icon
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 1
                  ? 'assets/icon/community2.png' // Selected icon
                  : 'assets/icon/community.png', // Unselected icon
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 2
                  ? 'assets/icon/picture.png' // Selected icon
                  : 'assets/icon/picture.png', // Unselected icon
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 3
                  ? 'assets/icon/yıldız2.png' // Selected icon
                  : 'assets/icon/yıldız.png', // Unselected icon
              width: 36,
              height: 36,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: profilePhotoUrl != null
                  ? NetworkImage(profilePhotoUrl!)
                  : AssetImage('assets/images/placeholder_profile.jpg')
                      as ImageProvider,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
