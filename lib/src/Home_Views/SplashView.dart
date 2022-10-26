import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashView();
  }
}

class _SplashView extends State<SplashView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    isUserLogged();
  }

  void isUserLogged() async {
    await Future.delayed(Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).popAndPushNamed("/LogIn");
    } else {
      DataHolder().DescargarMiPerfil();
      if (await DataHolder().isMiPerfilDownloaded() == true) {
        Navigator.of(context).popAndPushNamed("/Home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: LoadingAnimationWidget.hexagonDots(

          color: Colors.lightBlueAccent,
          size: 70,
        ),



      ),
    );
  }
}
