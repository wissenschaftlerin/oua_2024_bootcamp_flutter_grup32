import 'dart:io';

abstract class CommunityEvent {}

class FetchPosts extends CommunityEvent {}

class AddPost extends CommunityEvent {
  final String content;
  final File? imageFile;

  AddPost({
    required this.content,
    this.imageFile,
  });
}

class AddComment extends CommunityEvent {
  final String postId;
  final String comment;

  AddComment({
    required this.postId,
    required this.comment,
  });
}

class LikePost extends CommunityEvent {
  final String postId;

  LikePost({
    required this.postId,
  });
}

class ViewPost extends CommunityEvent {
  final String postId;

  ViewPost({
    required this.postId,
  });
}

class SharePost extends CommunityEvent {
  final String postId;
  final String recipientId;

  SharePost({
    required this.postId,
    required this.recipientId,
  });
}
