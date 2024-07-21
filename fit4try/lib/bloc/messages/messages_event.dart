import 'dart:io';

abstract class MessagesEvent {}

class SendMessage extends MessagesEvent {
  final String recipientId;
  final String content;
  final File? imageFile;

  SendMessage({
    required this.recipientId,
    required this.content,
    this.imageFile,
  });
}

class FetchMessages extends MessagesEvent {
  final String chatId;

  FetchMessages({
    required this.chatId,
  });
}

class MarkMessageAsRead extends MessagesEvent {
  final String messageId;

  MarkMessageAsRead({
    required this.messageId,
  });
}
