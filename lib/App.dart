import 'package:betamsngu/src/CustomViews//ChatView.dart';
import 'package:betamsngu/src/CustomViews/Friends_View.dart';
import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:betamsngu/src/Home_Views/FriendsHome_View.dart';
import 'package:betamsngu/src/Home_Views/HomeView.dart';
import 'package:betamsngu/src/LogIn_Views/onBoardingView.dart';
import 'package:betamsngu/src/LogIn_Views/LogInView.dart';
import 'package:betamsngu/src/LogIn_Views/RegisterView.dart';
import 'package:betamsngu/src/Home_Views/SplashView.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/LogIn',
      routes: {
        '/Home': (context) => HomeView(),
        '/LogIn': (context) => LogInView(),
        '/Register': (context) => RegisterView(),
        '/onBoarding': (context)=> onBoardingView(),
        '/Splash': (context) => SplashView(),
        '/ChatHome': (context) => ChatHomeView(),
        '/Chats': (context)=> ChatView(),
        '/Users' :(context) => Friends_View(),
        '/FriendsHome': (context)=> FriendsHome_View(),
      },
    );
  }
}
