import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit4try/bloc/user/user_event.dart';
import 'package:fit4try/bloc/user/user_state.dart';
import 'package:fit4try/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserBloc() : super(UserInitial()) {
    on<FetchUserData>(_onFetchUserData);
  }

  Future<void> _onFetchUserData(
      FetchUserData event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(event.userId).get();
      UserModel user = UserModel.fromFirestore(doc);
      emit(UserLoaded(
        displayName: user.displayName,
        profilePhotoUrl: user.profilePhoto,
        email: user.email,
      ));
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }
}
