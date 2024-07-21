import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SignUpWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final int methodsType;

  SignUpWithEmailAndPassword(
      this.email, this.password, this.name, this.methodsType);

  @override
  List<Object> get props => [email, password, name, methodsType];
}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {}
