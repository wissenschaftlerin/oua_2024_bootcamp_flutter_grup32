import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final bool newUser;
  final bool newStylest;

  const Authenticated({required this.newUser, required this.newStylest});

  @override
  List<Object> get props => [newUser, newStylest];
}

class Unauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthSignedIn extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError({required this.errorMessage});
}

class AuthFileUploadSuccess extends AuthState {
  final String fileUrl;

  AuthFileUploadSuccess(this.fileUrl);

  @override
  List<Object> get props => [fileUrl];
}

class AuthFileUploadFailure extends AuthState {
  final String error;

  AuthFileUploadFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthUpdateSuccess extends AuthState {}

class AuthUpdateFailure extends AuthState {
  final String error;

  AuthUpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}
