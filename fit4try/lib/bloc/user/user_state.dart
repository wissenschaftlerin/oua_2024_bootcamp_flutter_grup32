import 'package:equatable/equatable.dart';
import 'package:fit4try/models/post_model.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final String displayName;
  final String profilePhotoUrl;
  final String email;

  const UserLoaded({
    required this.displayName,
    required this.profilePhotoUrl,
    required this.email,
  });

  @override
  List<Object?> get props => [displayName, profilePhotoUrl, email];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String error;

  PostError(this.error);

  @override
  List<Object> get props => [error];
}
