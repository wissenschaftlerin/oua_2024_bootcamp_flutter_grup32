import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit4try/screens/auth/sign_up/sign_up_screen.dart';
import 'package:fit4try/widgets/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

class FirebaseOperations {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      showSuccessSnackBar(
          context, "Tekrar hoşgeldiniz ${_auth.currentUser?.displayName}");

      int profileType = await getProfileType(context);
      switch (profileType) {
        case 0:
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const SignUpScreen()),
          );
          break;

        case 1:
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const SignUpScreen()),
          );
          break;
        default:
          showErrorSnackBar(context, "Giriş başarısız oldu");
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const SignUpScreen()),
          );
          break;
      }
    } catch (e) {
      showErrorSnackBar(context, "Hatalı Giriş : $e");
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(BuildContext context,
      String email, String password, String name, int methodsType) async {
    try {
      var existingUser = await _auth.fetchSignInMethodsForEmail(email);
      if (existingUser.isNotEmpty) {
        print("Hata: Bu e-posta zaten kullanımda.");
        return null;
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      try {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'displayName': name,
          'uid': userCredential.user?.uid,
          'profilePhoto': "",
          'phoneNumber': '',
          'educationLevel': '',
          'address': '',
          "fcmToken": "",
          'email': email,
          "aiChats": [],
          "new_user": true,
          "new_stylest": true,
          'userType': methodsType == 0 ? 'kullanici' : 'stilist',
          'updatedUser': DateTime.now(),
          'createdAt': DateTime.now(),
        });
        print('Firestore\'a veri başarıyla kaydedildi.');

        int profileType = await getProfileType(context);

        switch (profileType) {
          case 0:
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const SignUpScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const SignUpScreen()),
            );
            break;
          default:
            print("Unknown profile type: $profileType");
            showErrorSnackBar(context, "Tanımsız kullanıcı tipi: $profileType");
            break;
        }
      } catch (e) {
        print('Firestore\'a veri kaydederken hata oluştu: $e');
      }

      return userCredential;
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Can not SignOut as :$e');
    }
  }

  Future<bool> signInWithGoogle() async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'displayName': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
            'phoneNumber': '',
            'educationLevel': '',
            'address': '',
            "fcmToken": "",
            'email': user.email,
            "aiChats": [],
            'userType': 'kullanici',
            "new_user": true,
            "new_stylest": true,
            'updatedUser': DateTime.now(),
            'createdAt': DateTime.now(),
          });
        }
        result = true;
      }
      return result;
    } catch (e) {
      print("Error Google Sign In : $e");
    }
    return result;
  }

  Future<int> getProfileType(BuildContext context) async {
    try {
      String uid = _auth.currentUser?.uid ?? "";
      if (uid.isEmpty) {
        return 2;
      }
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection("users").doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        if (data.containsKey("userType")) {
          if (data["userType"] == "kullanici") {
            return 0;
          } else if (data['userType'] == "stilist") {
            return 1;
          } else {
            return 2;
          }
        } else {
          return 2;
        }
      } else {
        return 2;
      }
    } catch (e) {
      showErrorSnackBar(context, "Hatalı profil tipi : $e");
      return 2;
    }
  }
}
