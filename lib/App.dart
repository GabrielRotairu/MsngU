import 'package:betamsngu/src/Home_Views/HomeView.dart';
import 'package:betamsngu/src/Home_Views/onBoardingView.dart';
import 'package:betamsngu/src/LogIn_Views/LogInView.dart';
import 'package:betamsngu/src/LogIn_Views/RegisterView.dart';
import 'package:betamsngu/src/LogIn_Views/SplashView.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/Splash',
      routes: {
        '/Home': (context) => HomeView(),
        '/LogIn': (context) => LogInView(),
        '/Register': (context) => RegisterView(),
        '/onBoarding': (context)=> onBoardingView(),
        '/Splash': (context) => SplashView(),
      },
    );
  }
}
