import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String displayName;
  String uid;
  String profilePhoto;
  String phoneNumber;
  String educationLevel;
  String address;
  String fcmToken;
  String email;
  List<dynamic> aiChats;
  String userType;
  bool newUser;
  bool newStylest;
  DateTime updatedUser;
  DateTime createdAt;

  UserModel({
    required this.displayName,
    required this.uid,
    required this.profilePhoto,
    required this.phoneNumber,
    required this.educationLevel,
    required this.address,
    required this.fcmToken,
    required this.email,
    required this.aiChats,
    required this.userType,
    required this.newUser,
    required this.newStylest,
    required this.updatedUser,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      displayName: data['displayName'] ?? '',
      uid: data['uid'] ?? '',
      profilePhoto: data['profilePhoto'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      educationLevel: data['educationLevel'] ?? '',
      address: data['address'] ?? '',
      fcmToken: data['fcmToken'] ?? '',
      email: data['email'] ?? '',
      aiChats: List.from(data['aiChats'] ?? []),
      userType: data['userType'] ?? 'kullanici',
      newUser: data['new_user'] ?? true,
      newStylest: data['new_stylest'] ?? true,
      updatedUser: (data['updatedUser'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'uid': uid,
      'profilePhoto': profilePhoto,
      'phoneNumber': phoneNumber,
      'educationLevel': educationLevel,
      'address': address,
      'fcmToken': fcmToken,
      'email': email,
      'aiChats': aiChats,
      'userType': userType,
      'new_user': newUser,
      'new_stylest': newStylest,
      'updatedUser': Timestamp.fromDate(updatedUser),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
