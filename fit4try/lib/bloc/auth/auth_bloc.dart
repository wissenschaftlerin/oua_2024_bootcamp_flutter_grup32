import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/bloc/auth/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final GoogleSignIn _googleSignIn;

  AuthBloc()
      : _firebaseAuth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance,
        _storage = FirebaseStorage.instance,
        _googleSignIn = GoogleSignIn(),
        super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<AuthUserInfoSubmitted>(_onAuthUserInfoSubmitted);
    on<LogoutEvent>(_onLogoutEvent);
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);

    // on<AuthVerificationCodeSubmitted>(_onAuthVerificationCodeSubmitted);
    on<AuthPhotoUploaded>(_onAuthPhotoUploaded);
    on<UploadFileEvent>(_onUploadFileEvent);
    on<UpdateUserInformation>(_onUpdateUserInformation);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        bool newUser = userDoc['new_user'] ?? false;
        bool newStylest = userDoc['new_stylest'] ?? false;

        emit(Authenticated(newUser: newUser, newStylest: newStylest));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
    SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      User? user = userCredential.user;

      if (user != null) {
        emit(AuthFailure('User not found'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthUserInfoSubmitted(
    AuthUserInfoSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      User? user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();

        await _firestore.collection('users').doc(user.uid).set({
          'displayName': event.name,
          'username': event.username,
          'uid': userCredential.user?.uid,
          'profilePhoto': "",
          'phoneNumber': '',
          'educationLevel': '',
          'address': '',
          "fcmToken": "",
          'followers': 0,
          'following': 0,
          'email': event.email,
          "aiChats": [],
          "deneyim": event.deneyim,
          "emailVerified": false,
          "new_user": event.methodsType == 0 ? true : false,
          "new_stylest": event.methodsType == 0 ? false : true,
          'userType': event.methodsType == 0 ? 'kullanici' : 'stilist',
          'updatedUser': DateTime.now(),
          'createdAt': DateTime.now(),
        });

        emit(Authenticated(newUser: true, newStylest: false));
      } else {
        emit(AuthFailure('User creation failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Future<void> _onAuthVerificationCodeSubmitted(
  //   AuthVerificationCodeSubmitted event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());
  //   try {
  //     User? user = _firebaseAuth.currentUser;

  //     if (user != null) {
  //       DocumentSnapshot userDoc =
  //           await _firestore.collection('users').doc(user.uid).get();
  //       String? storedCode = userDoc['verificationCode'];

  //       if (storedCode == event.verificationCode) {
  //         await _firestore.collection('users').doc(user.uid).update({
  //           'emailVerified': true, // E-posta doğrulama durumunu güncelle
  //           'verificationCode': FieldValue.delete(), // Kodun silinmesi
  //         });
  //         emit(Authenticated(newUser: true, newStylest: false));
  //       } else {
  //         emit(AuthFailure('Invalid verification code'));
  //       }
  //     } else {
  //       emit(AuthFailure('User not found'));
  //     }
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  Future<void> _onAuthPhotoUploaded(
    AuthPhotoUploaded event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        Reference ref =
            _storage.ref().child('user_photos').child(user.uid + '.jpg');
        await ref.putFile(File(event.photoUrl));
        String downloadUrl = await ref.getDownloadURL();

        await _firestore.collection('users').doc(user.uid).update({
          'photoUrl': downloadUrl,
          'new_user': false, // Fotoğraf yüklendikten sonra false
        });

        emit(Authenticated(newUser: false, newStylest: false));
      } else {
        emit(AuthFailure('Photo upload failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).set({
            'displayName': user.displayName ?? '',
            'uid': user.uid,
            'username': user.uid,
            'profilePhoto': user.photoURL ?? '',
            'phoneNumber': user.phoneNumber ?? '',
            'educationLevel': '',
            'address': '',
            'followers': 0,
            'following': 0,
            'fcmToken': '',
            'email': user.email ?? '',
            'aiChats': [],
            'emailVerified': user.emailVerified,
            'new_user': true,
            'userType': 'kullanici',
            'updatedUser': DateTime.now(),
            'createdAt': DateTime.now(),
          });
        }

        emit(Authenticated(newUser: true, newStylest: false));
      } else {
        emit(AuthFailure('Google sign-in failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onUploadFileEvent(
    UploadFileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        Reference ref = _storage
            .ref()
            .child('user_files')
            .child(user.uid + '/' + event.file.path.split('/').last);
        await ref.putFile(event.file);
        String downloadUrl = await ref.getDownloadURL();

        emit(AuthFileUploadSuccess(downloadUrl));
      } else {
        emit(AuthFileUploadFailure('User not authenticated'));
      }
    } catch (e) {
      emit(AuthFileUploadFailure(e.toString()));
    }
  }

  Future<void> _onUpdateUserInformation(
    UpdateUserInformation event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'fileUrl': event.fileUrl,
        });

        emit(AuthUpdateSuccess());
      } else {
        emit(AuthUpdateFailure('User not authenticated'));
      }
    } catch (e) {
      emit(AuthUpdateFailure(e.toString()));
    }
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
