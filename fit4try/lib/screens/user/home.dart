import 'package:fit4try/bloc/user/user_bloc.dart';
import 'package:fit4try/bloc/user/user_event.dart';
import 'package:fit4try/bloc/user/user_state.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/ai_screen.dart';
import 'package:fit4try/screens/user/community_screen.dart';
import 'package:fit4try/screens/user/guard_screen.dart';
import 'package:fit4try/screens/user/home_screen.dart';
import 'package:fit4try/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => UserBloc()
          ..add(FetchUserData(
              'user-id')), // Replace 'user-id' with actual user ID
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CommunityScreen(),
    GuardScreen(),
    AiScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return SalomonBottomBar(
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
                icon: userState is UserLoaded
                    ? CircleAvatar(
                        backgroundImage:
                            // Image(userState.profilePhotoUrl),
                            AssetImage('assets/images/placeholder_profile.jpg'))
                    : CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text('Profile'),
                selectedColor: AppColors.primaryColor5,
                unselectedColor: Colors.grey,
              ),
            ],
          );
        },
      ),
    );
  }
}
