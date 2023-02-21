import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MsngU_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MsngU_View();
  }
}

class _MsngU_View extends State<MsngU_View> {
  List<Usuario> Friends= [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getUsers() async {
    final ref = db.collection(DataHolder().sCOLLETCTIONS_USERS).withConverter(
      fromFirestore: Usuario.fromFirestore,
      toFirestore: (Usuario u, _) => u.toFirestore(),
    );
    final docSnap = await ref.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        Friends.add(docSnap.docs[i].data());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Text("HOLAAAAA")
      ],
    )));
  }
}
