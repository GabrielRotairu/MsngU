import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
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
    loadAllData();
  }

  void loadAllData() async {
    await Future.delayed(Duration(seconds: 2));
    //CARGAMOS TODOS LOS RECURSOS

    if (FirebaseAuth.instance.currentUser == null) {
      setState(() {
        Navigator.of(context).popAndPushNamed("/LogIn");
      });
    } else {
      bool existe = await checkExistingProfile();
      if (existe) {
        setState(() {
          Navigator.of(context).popAndPushNamed("/Home");
        });
      } else {
        setState(() {
          Navigator.of(context).popAndPushNamed("/Register");
        });
      }
    }
  }

  Future<bool> checkExistingProfile() async {
    String? idUser = FirebaseAuth.instance.currentUser?.uid;
    print (idUser.toString());
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection("Usuarios").doc(idUser).withConverter(
        fromFirestore: Usuario.fromFirestore,
        toFirestore: (Usuario perfil, _) => perfil.toFirestore());

    DocumentSnapshot docsnap = await docRef.get();
    DataHolder().usuario = docsnap.data() as Usuario;

    return docsnap.exists;
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
