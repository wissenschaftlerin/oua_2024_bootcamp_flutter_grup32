import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit4try/bloc/auth/auth_bloc.dart';
import 'package:fit4try/bloc/auth/auth_event.dart';
import 'package:fit4try/bloc/auth/auth_state.dart';
import 'package:fit4try/bloc/community/community_bloc.dart';
import 'package:fit4try/bloc/messages/messages_bloc.dart';
import 'package:fit4try/bloc/user/user_bloc.dart';
import 'package:fit4try/firebase_options.dart';
import 'package:fit4try/screens/auth/intro_screen.dart';
import 'package:fit4try/screens/auth/sign_in/login.dart';
import 'package:fit4try/screens/auth/styles/styles_screen.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:fit4try/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  // addSampleData();
  // addSampleData()
  runApp(MyApp());
}

// void addSampleData() async {
//   CollectionReference posts = FirebaseFirestore.instance.collection('posts');

//   List<Map<String, dynamic>> samplePosts = [
//     {
//       'id': 'post1',
//       'imageUrl':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'username': 'user1',
//       'userImage':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'description': 'This is the first post',
//       'views': 100,
//       'likes': 50,
//       'shares': 10,
//       'tags': ['tag1', 'tag2'],
//       'saved': false,
//       'isFavorited': false,
//       'createdAt': Timestamp.now(),
//     },
//     {
//       'id': 'post2',
//       'imageUrl':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'username': 'user2',
//       'userImage':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'description': 'This is the second post',
//       'views': 200,
//       'likes': 150,
//       'shares': 20,
//       'tags': ['tag3', 'tag4'],
//       'saved': true,
//       'isFavorited': true,
//       'createdAt': Timestamp.now(),
//     },
//     {
//       'id': 'post3',
//       'imageUrl':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'username': 'user3',
//       'userImage':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'description': 'This is the third post',
//       'views': 300,
//       'likes': 250,
//       'shares': 30,
//       'tags': ['tag5', 'tag6'],
//       'saved': false,
//       'isFavorited': false,
//       'createdAt': Timestamp.now(),
//     },
//     {
//       'id': 'post4',
//       'imageUrl':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'username': 'user4',
//       'userImage':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'description': 'This is the fourth post',
//       'views': 400,
//       'likes': 350,
//       'shares': 40,
//       'tags': ['tag7', 'tag8'],
//       'saved': true,
//       'isFavorited': true,
//       'createdAt': Timestamp.now(),
//     },
//     {
//       'id': 'post5',
//       'imageUrl':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'username': 'user5',
//       'userImage':
//           'https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png',
//       'description': 'This is the fifth post',
//       'views': 500,
//       'likes': 450,
//       'shares': 50,
//       'tags': ['tag9', 'tag10'],
//       'saved': false,
//       'isFavorited': false,
//       'createdAt': Timestamp.now(),
//     },
//   ];

//   for (var post in samplePosts) {
//     await posts.doc(post['id']).set(post);
//   }
// }

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addSampleData() async {
  CollectionReference communityPosts = _firestore.collection('community_posts');

  List<Map<String, dynamic>> sampleData = [
    {
      "avatar":
          "https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png",
      "username": "ege.yildirim",
      "time": "1 dk.",
      "content":
          "Bu sezonun en popüler renklerinden biri olan lavanta, gardırobuma mükemmel bir ekleme oldu!",
      "likes": 11400,
      "comments": 154,
      "views": 1200
    },
    {
      "avatar":
          "https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png",
      "username": "estarhoward",
      "time": "3 sa",
      "content":
          "Yüksek bel pantolonlar geri döndü! Sizce bu trend ne kadar kalıcı olacak?",
      "likes": 1048,
      "comments": 128,
      "views": 1300
    },
    {
      "avatar":
          "https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png",
      "username": "estarhoward",
      "time": "4 sa",
      "content":
          "Bu hafta sonu moda fuarına katıldım ve inanılmaz tasarımlar gördüm. Sizler de böyle etkinliklere katılıyor musunuz?",
      "likes": 1088,
      "comments": 158,
      "views": 1100
    },
    {
      "avatar":
          "https://klasiksanatlar.com/img/sayfalar/b/1_1598452306_resim.png",
      "username": "yasinkaan.ygt",
      "time": "4 sa",
      "content":
          "Bir iş görüşmesi için ne giymeliyim? Profesyonel ama rahat bir görünüm arıyorum.",
      "likes": 0,
      "comments": 0,
      "views": 0
    }
  ];

  for (Map<String, dynamic> postData in sampleData) {
    await communityPosts.add(postData);
  }

  print('Sample data added successfully');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommunityBloc>(
          create: (context) => CommunityBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
        BlocProvider<MessagesBloc>(
          create: (context) => MessagesBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        home: AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: LoadingWidget()));
        }

        if (snapshot.hasData && snapshot.data == true) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print('Current Auth State: ${state}');
              if (state is AuthLoading) {
                return Scaffold(body: Center(child: LoadingWidget()));
              } else if (state is Authenticated) {
                if (state.newUser || state.newStylest) {
                  return Home();
                } else {
                  return Home();
                }
              } else if (state is Unauthenticated) {
                return SignInScreen();
              } else {
                return Scaffold(
                  body: Center(child: Text('Something went wrong!')),
                );
              }
            },
          );
        } else {
          return MyHomePage(
            title: "Fit4Try",
          );
        }
      },
    );
  }

  Future<bool> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    if (isFirstLaunch == null || isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      return false; // First launch
    }
    return true; // Not the first launch
  }
}
