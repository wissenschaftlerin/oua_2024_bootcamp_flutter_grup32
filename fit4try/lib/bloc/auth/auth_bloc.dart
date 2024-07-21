// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fit4try/bloc/auth/auth_event.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   AuthBloc() : super(AuthInitial()) {
//     on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
//     on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
//     on<SignOut>(_onSignOut);
//     on<SignInWithGoogle>(_onSignInWithGoogle);
//   }

//   Future<void> _onSignInWithEmailAndPassword(
//       SignInWithEmailAndPassword event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: event.email, password: event.password);

//       var profileData = await _getProfileData();
//       emit(Authenticated(_auth.currentUser?.displayName ?? "User",
//           profileData['new_user'], profileData['new_stylest']));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onSignUpWithEmailAndPassword(
//       SignUpWithEmailAndPassword event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       var existingUser = await _auth.fetchSignInMethodsForEmail(event.email);
//       if (existingUser.isNotEmpty) {
//         emit(AuthError("Bu e-posta zaten kullanımda."));
//         return;
//       }

//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//               email: event.email, password: event.password);

//       await _firestore.collection('users').doc(userCredential.user!.uid).set({
//         'displayName': event.name,
//         'uid': userCredential.user?.uid,
//         'profilePhoto': "",
//         'phoneNumber': '',
//         'educationLevel': '',
//         'address': '',
//         "fcmToken": "",
//         'email': event.email,
//         "aiChats": [],
//         "new_user": true,
//         "new_stylest": true,
//         'userType': event.methodsType == 0 ? 'kullanici' : 'stilist',
//         'updatedUser': DateTime.now(),
//         'createdAt': DateTime.now(),
//       });

//       var profileData = await _getProfileData();
//       emit(Authenticated(_auth.currentUser?.displayName ?? "User",
//           profileData['new_user'], profileData['new_stylest']));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
//     await _auth.signOut();
//     emit(Unauthenticated());
//   }

//   Future<void> _onSignInWithGoogle(
//       SignInWithGoogle event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser!.authentication;
//       final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

//       UserCredential userCredential =
//           await _auth.signInWithCredential(credential);
//       User? user = userCredential.user;

//       if (user != null) {
//         if (userCredential.additionalUserInfo!.isNewUser) {
//           await _firestore.collection('users').doc(user.uid).set({
//             'displayName': user.displayName,
//             'uid': user.uid,
//             'profilePhoto': user.photoURL,
//             'phoneNumber': '',
//             'educationLevel': '',
//             'address': '',
//             "fcmToken": "",
//             'email': user.email,
//             "aiChats": [],
//             'userType': 'kullanici',
//             "new_user": true,
//             "new_stylest": true,
//             'updatedUser': DateTime.now(),
//             'createdAt': DateTime.now(),
//           });
//         }
//         var profileData = await _getProfileData();
//         emit(Authenticated(user.displayName ?? "User", profileData['new_user'],
//             profileData['new_stylest']));
//       } else {
//         emit(Unauthenticated());
//       }
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<Map<String, dynamic>> _getProfileData() async {
//     String uid = _auth.currentUser?.uid ?? "";
//     if (uid.isEmpty) {
//       return {"new_user": false, "new_stylest": false};
//     }
//     DocumentSnapshot<Map<String, dynamic>> snapshot =
//         await _firestore.collection("users").doc(uid).get();

//     if (snapshot.exists) {
//       Map<String, dynamic> data = snapshot.data()!;
//       return {
//         "new_user": data["new_user"] ?? false,
//         "new_stylest": data["new_stylest"] ?? false,
//       };
//     } else {
//       return {"new_user": false, "new_stylest": false};
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        bool newUser = data['new_user'] ?? false;
        bool newStylest = data['new_stylest'] ?? false;
        emit(Authenticated(
            user: user, newUser: newUser, newStylest: newStylest));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'displayName': event.name,
        'uid': userCredential.user?.uid,
        'profilePhoto': "",
        'phoneNumber': '',
        'educationLevel': '',
        'address': '',
        "fcmToken": "",
        'email': event.email,
        "aiChats": [],
        "new_user": true,
        "new_stylest": true,
        'userType': event.methodsType == 0 ? 'kullanici' : 'stilist',
        'updatedUser': DateTime.now(),
        'createdAt': DateTime.now(),
      });
      emit(Authenticated(
          user: userCredential.user!, newUser: true, newStylest: true));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        bool newUser = data['new_user'] ?? false;
        bool newStylest = data['new_stylest'] ?? false;
        emit(Authenticated(
            user: userCredential.user!,
            newUser: newUser,
            newStylest: newStylest));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    await _auth.signOut();
    emit(Unauthenticated());
  }
}
