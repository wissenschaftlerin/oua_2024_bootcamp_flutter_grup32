import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/constants/style.dart';
import 'package:fit4try/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = '';
  int _followersCount = 0;
  int _followingCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['displayName'] ?? 'Anonim Kullanıcı';
          _followersCount = userDoc['followers'] ?? 0;
          _followingCount = userDoc['following'] ?? 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 75),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60, // Circular Avatar'ı büyüttük
                        backgroundImage:
                            AssetImage("assets/images/placeholder_profile.jpg"),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      right: 5,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        color: AppColors.primaryColor5,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()));
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  _userName,
                  style:
                      fontStyle(23, AppColors.secondaryColor2, FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        _followersCount.toString(),
                        style: fontStyle(
                            18, AppColors.secondaryColor2, FontWeight.bold),
                      ),
                      Text(
                        "Takipçi",
                        style: fontStyle(
                            18, AppColors.secondaryColor1, FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _followingCount.toString(),
                        style: fontStyle(
                            18, AppColors.secondaryColor2, FontWeight.bold),
                      ),
                      Text(
                        "Takip Edilen",
                        style: fontStyle(
                            18, AppColors.secondaryColor1, FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(Icons.add)),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor2,
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.primaryColor5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.secondaryColor2,
                labelColor: AppColors.secondaryColor2,
                unselectedLabelColor: AppColors.secondaryColor1,
                tabs: [
                  Tab(
                    text: "Stillerim (0)",
                  ),
                  Tab(
                    text: "Favorilerim (0)",
                  ),
                ],
              ),
              Container(
                height: 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text("Stillerim içerikleri burada görünecek."),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Text("Favorilerim içerikleri burada görünecek."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
