import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String recipientId;
  final String content;
  final String imageUrl;
  final Timestamp sentAt;
  final bool isRead;

  Message({
    required this.id,
    required this.recipientId,
    required this.content,
    required this.imageUrl,
    required this.sentAt,
    required this.isRead,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      id: doc.id,
      recipientId: doc['recipientId'],
      content: doc['content'],
      imageUrl: doc['imageUrl'] ?? '',
      sentAt: doc['sentAt'],
      isRead: doc['isRead'],
    );
  }
}
