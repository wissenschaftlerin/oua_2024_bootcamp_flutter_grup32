import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'messages_event.dart';
import 'messages_state.dart';
import 'package:fit4try/models/message_model.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  MessagesBloc() : super(MessagesInitial()) {
    on<SendMessage>(_onSendMessage);
    on<FetchMessages>(_onFetchMessages);
    on<MarkMessageAsRead>(_onMarkMessageAsRead);
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<MessagesState> emit) async {
    try {
      String? imageUrl;
      if (event.imageFile != null) {
        final filePath =
            'message_images/${DateTime.now().millisecondsSinceEpoch}_${event.imageFile!.path.split('/').last}';
        final storageRef = _storage.ref().child(filePath);

        await storageRef.putFile(event.imageFile!);

        imageUrl = await storageRef.getDownloadURL();
      }

      final messageRef = _firestore.collection('messages').doc();
      await messageRef.set({
        'recipientId': event.recipientId,
        'content': event.content,
        'imageUrl': imageUrl ?? '',
        'sentAt': Timestamp.now(),
        'isRead': false,
      });
      emit(MessageSent());
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  Future<void> _onFetchMessages(
      FetchMessages event, Emitter<MessagesState> emit) async {
    try {
      emit(MessagesLoading());
      final snapshot = await _firestore
          .collection('messages')
          .where('chatId', isEqualTo: event.chatId)
          .orderBy('sentAt', descending: true)
          .get();
      final messages =
          snapshot.docs.map((doc) => Message.fromDocument(doc)).toList();
      emit(MessagesLoaded(messages));
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }

  Future<void> _onMarkMessageAsRead(
      MarkMessageAsRead event, Emitter<MessagesState> emit) async {
    try {
      final messageRef = _firestore.collection('messages').doc(event.messageId);
      await messageRef.update({
        'isRead': true,
      });
      emit(MessageRead());
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }
}
