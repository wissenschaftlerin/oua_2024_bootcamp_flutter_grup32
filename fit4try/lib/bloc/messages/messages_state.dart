import 'package:fit4try/models/message_model.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  MessagesLoaded(this.messages);
}

class MessageSent extends MessagesState {}

class MessageRead extends MessagesState {}

class MessagesError extends MessagesState {
  final String error;

  MessagesError(this.error);
}
