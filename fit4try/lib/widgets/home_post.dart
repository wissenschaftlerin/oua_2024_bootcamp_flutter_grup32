import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit4try/constants/fonts.dart';
import 'package:fit4try/models/discover_model.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final DiscoverPost post;

  PostWidget({required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isFavorited = false;
  bool isSaved = false;
  bool showTags = false;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    checkFavoriteAndSaveStatus();
  }

  Future<void> checkFavoriteAndSaveStatus() async {
    if (currentUser == null) return;

    final postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.post.id);

    final snapshot = await postRef.get();

    final likedUsers = List<String>.from(snapshot.data()?['liked_users'] ?? []);
    final savedUsers = List<String>.from(snapshot.data()?['saved_users'] ?? []);

    if (mounted) {
      setState(() {
        isFavorited = likedUsers.contains(currentUser!.uid);
        isSaved = savedUsers.contains(currentUser!.uid);
      });
    }
  }

  void toggleFavorite() async {
    if (currentUser == null) return;

    final postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.post.id);

    final snapshot = await postRef.get();
    final likedUsers = List<String>.from(snapshot.data()?['liked_users'] ?? []);

    if (likedUsers.contains(currentUser!.uid)) {
      setState(() {
        isFavorited = false;
      });
      await postRef.update({
        'likes': FieldValue.increment(-1),
        'liked_users': FieldValue.arrayRemove([currentUser!.uid])
      });
    } else {
      setState(() {
        isFavorited = true;
      });
      await postRef.update({
        'likes': FieldValue.increment(1),
        'liked_users': FieldValue.arrayUnion([currentUser!.uid])
      });
    }
  }

  void toggleSave() async {
    if (currentUser == null) return;

    final postRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.post.id);

    final snapshot = await postRef.get();
    final savedUsers = List<String>.from(snapshot.data()?['saved_users'] ?? []);

    if (savedUsers.contains(currentUser!.uid)) {
      setState(() {
        isSaved = false;
      });
      await postRef.update({
        'saved_users': FieldValue.arrayRemove([currentUser!.uid])
      });
    } else {
      setState(() {
        isSaved = true;
      });
      await postRef.update({
        'saved_users': FieldValue.arrayUnion([currentUser!.uid])
      });
    }

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    if (isSaved) {
      await userRef.update({
        'saved_posts': FieldValue.arrayUnion([widget.post.id])
      });
    } else {
      await userRef.update({
        'saved_posts': FieldValue.arrayRemove([widget.post.id])
      });
    }
  }

  void toggleShowTags() {
    setState(() {
      showTags = !showTags;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor1,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.post.userImage),
            ),
            title: Text(widget.post.username),
          ),
          Image.network(widget.post.imageUrl),
          // if (widget.post.description.isNotEmpty)
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(widget.post.description),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage(!isFavorited
                        ? 'assets/icon/like.png'
                        : 'assets/icon/like2.png'),
                  ),
                  onPressed: toggleFavorite,
                ),
                IconButton(
                  icon: ImageIcon(
                    AssetImage(!isSaved
                        ? 'assets/icon/plus.png'
                        : 'assets/icon/plus.png'),
                  ),
                  onPressed: toggleSave,
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: const ImageIcon(
                    AssetImage('assets/icon/yıldız.png'),
                  ),
                  onPressed: toggleShowTags,
                ),
              ],
            ),
          ),
          if (showTags)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: widget.post.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
