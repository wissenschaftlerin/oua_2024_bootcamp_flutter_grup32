import 'package:equatable/equatable.dart';

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
