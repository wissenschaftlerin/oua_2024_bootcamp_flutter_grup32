import 'package:fit4try/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String? profilePhotoUrl;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.profilePhotoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: onTap,
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
    );
  }
}
