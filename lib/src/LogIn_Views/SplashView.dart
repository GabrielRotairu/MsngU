import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    await Future.delayed(Duration(seconds: 5));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.of(context).popAndPushNamed("/Login");
    } else {
      DataHolder().DescargarMiPerfil();
      if (await DataHolder().isMiPerfilDownloaded() == true) {
        Navigator.of(context).popAndPushNamed("/Home");
      } else {
        Navigator.of(context).popAndPushNamed("/LogIn");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Text("Bienvenido  :)"),

      ),
    );
  }
}
