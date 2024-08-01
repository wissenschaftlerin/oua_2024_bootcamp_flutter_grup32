import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GuestUserProfileScreen extends StatefulWidget {
  final String uid;

  GuestUserProfileScreen({required this.uid});

  @override
  _GuestUserProfileScreenState createState() => _GuestUserProfileScreenState();
}

class _GuestUserProfileScreenState extends State<GuestUserProfileScreen> {
  late Future<DocumentSnapshot> userDocument;

  @override
  void initState() {
    super.initState();
    userDocument =
        FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: userDocument,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User not found.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userData['photoUrl'] ??
                      'assets/images/placeholder_profile.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  userData['displayName'] ?? 'No Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  userData['username'] ?? 'No Username',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                // Add any other user information you want to display
              ],
            ),
          );
        },
      ),
    );
  }
}
