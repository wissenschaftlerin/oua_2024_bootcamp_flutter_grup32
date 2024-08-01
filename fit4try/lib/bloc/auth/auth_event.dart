import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthUserInfoSubmitted extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final String deneyim;
  final int methodsType;

  const AuthUserInfoSubmitted(this.name, this.username, this.email,
      this.password, this.deneyim, this.methodsType);

  @override
  List<Object> get props =>
      [name, username, email, password, deneyim, methodsType];
}

class AuthVerificationCodeSubmitted extends AuthEvent {
  final String verificationCode;

  const AuthVerificationCodeSubmitted(this.verificationCode);

  @override
  List<Object> get props => [verificationCode];
}

class AuthPhotoUploaded extends AuthEvent {
  final String photoUrl;

  const AuthPhotoUploaded(this.photoUrl);

  @override
  List<Object> get props => [photoUrl];
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({required this.email, required this.password});
}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignInWithGoogleEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class UploadFile extends AuthEvent {
  final File file;

  UploadFile(this.file);
}

// class UpdateUserInformation extends AuthEvent {
//   final String fileUrl;

//   UpdateUserInformation(this.fileUrl);
// }

class UploadFileEvent extends AuthEvent {
  final File file;

  const UploadFileEvent(this.file);

  @override
  List<Object> get props => [file];
}

class UpdateUserInformation extends AuthEvent {
  final String fileUrl;

  UpdateUserInformation(this.fileUrl);

  @override
  List<Object> get props => [fileUrl];
}
