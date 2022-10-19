import 'package:betamsngu/Home_Views/HomeView.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return MaterialApp(

initialRoute: '/home',

routes: {
'/home' : (context)=> HomeView(),


},


);


  }}