import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserData extends UserEvent {
  final String userId;

  const FetchUserData(this.userId);

  @override
  List<Object?> get props => [userId];
}
