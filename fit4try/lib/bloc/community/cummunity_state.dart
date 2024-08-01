import 'package:equatable/equatable.dart';
import 'package:fit4try/models/post_model.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class PostsLoaded extends CommunityState {
  final List<Post> posts;

  PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostAdded extends CommunityState {}

class CommentAdded extends CommunityState {}

class PostLiked extends CommunityState {}

class PostViewed extends CommunityState {}

class PostShared extends CommunityState {}

class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);

  @override
  List<Object> get props => [message];
}
