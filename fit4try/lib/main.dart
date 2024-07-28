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
import 'package:fit4try/screens/auth/sign_up/sign_up_screen.dart';
import 'package:fit4try/screens/auth/styles/styles_screen.dart';
import 'package:fit4try/screens/user/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(MyApp());
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
        ));
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is Authenticated) {
          if (state.newUser || state.newStylest) {
            return StylesScreen();
          } else {
            return SignInScreen();
          }
        } else if (state is Unauthenticated) {
          return MyHomePage(
            title: "test",
          );
        } else {
          return Scaffold(
            body: Center(child: Text('Something went wrong!')),
          );
        }
      },
    );
  }
}
