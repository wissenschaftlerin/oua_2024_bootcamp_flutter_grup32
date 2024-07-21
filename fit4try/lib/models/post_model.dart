import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String content;
  final String imageUrl;
  final int likes;
  final List<dynamic> comments;
  final int views;
  final List<dynamic> shares;
  final Timestamp createdAt;

  Post({
    required this.id,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.views,
    required this.shares,
    required this.createdAt,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      content: data['content'],
      imageUrl: data['imageUrl'],
      likes: data['likes'],
      comments: List<dynamic>.from(data['comments'] ?? []),
      views: data['views'],
      shares: List<dynamic>.from(data['shares'] ?? []),
      createdAt: data['createdAt'],
    );
  }
}
