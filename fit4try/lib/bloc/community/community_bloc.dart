import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit4try/models/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'community_event.dart';
import 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CommunityBloc() : super(CommunityInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
    on<AddComment>(_onAddComment);
    on<LikePost>(_onLikePost);
    on<ViewPost>(_onViewPost);
    on<SharePost>(_onSharePost);
  }

  Future<void> _onFetchPosts(
      FetchPosts event, Emitter<CommunityState> emit) async {
    try {
      final snapshot = await _firestore.collection('posts').get();
      final posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<CommunityState> emit) async {
    try {
      String? imageUrl;
      if (event.imageFile != null) {
        // Yükleme işlemi için dosya referansı oluşturun
        final filePath =
            'post_images/${DateTime.now().millisecondsSinceEpoch}_${event.imageFile!.path.split('/').last}';
        final storageRef = _storage.ref().child(filePath);

        // Dosyayı Firebase Storage'a yükleyin
        await storageRef.putFile(event.imageFile!);

        // Dosyanın URL'ini alın
        imageUrl = await storageRef.getDownloadURL();
      }

      final postRef = _firestore.collection('posts').doc();
      await postRef.set({
        'content': event.content,
        'imageUrl': imageUrl ?? '',
        'likes': 0,
        'comments': [],
        'views': 0,
        'shares': [],
        'createdAt': Timestamp.now(),
      });
      emit(PostAdded());
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> _onAddComment(
      AddComment event, Emitter<CommunityState> emit) async {
    try {
      final postRef = _firestore.collection('posts').doc(event.postId);
      await postRef.update({
        'comments': FieldValue.arrayUnion([event.comment]),
      });
      emit(CommentAdded());
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<CommunityState> emit) async {
    try {
      final postRef = _firestore.collection('posts').doc(event.postId);
      await postRef.update({
        'likes': FieldValue.increment(1),
      });
      emit(PostLiked());
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> _onViewPost(ViewPost event, Emitter<CommunityState> emit) async {
    try {
      final postRef = _firestore.collection('posts').doc(event.postId);
      await postRef.update({
        'views': FieldValue.increment(1),
      });
      emit(PostViewed());
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> _onSharePost(
      SharePost event, Emitter<CommunityState> emit) async {
    try {
      final postRef = _firestore.collection('posts').doc(event.postId);
      final shareData = {
        'senderId': _firestore.collection('users').doc().id,
        'recipientId': event.recipientId,
        'postId': event.postId,
        'sharedAt': Timestamp.now(),
      };
      await _firestore.collection('shares').add(shareData);
      emit(PostShared());
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }
}
