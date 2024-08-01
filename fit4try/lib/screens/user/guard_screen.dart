import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/screens/user/messages_screen.dart';
import 'package:fit4try/screens/user/notifications_screen.dart';
import 'package:flutter/material.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({super.key});

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  String? _profilePhotoUrl;
  String _displayName = 'User';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _profilePhotoUrl = userDoc.get('photoUrl');
            _displayName = userDoc.get('displayName') ?? 'User';
          });
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CircleAvatar(
          backgroundImage: _profilePhotoUrl != null
              ? NetworkImage(_profilePhotoUrl!)
              : AssetImage('assets/images/placeholder_profile.jpg')
                  as ImageProvider,
        ),
        title: Text(
          _displayName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icon/bildirim.png'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationScreen()));
            },
          ),
          IconButton(
            icon: Image.asset('assets/icon/send.png'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MessagesScreen()));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.grey[300],
            height: 10,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor1,
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Danışanlar'),
                Tab(text: 'Favori Danışanlarım'),
              ],
              indicatorColor: AppColors.primaryColor5,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildEmptyTabContent('Danışanınız Yok'), // First tab content
                  _buildEmptyTabContent('Favoriniz Yok'), // Second tab content
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTabContent(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
