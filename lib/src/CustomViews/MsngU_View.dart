import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class MsngU_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MsngU_View();
  }
}

class _MsngU_View extends State<MsngU_View> {
  List<Usuario> Friends = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

//En este método vamos a descargar nuestros amigos a los que les mandaremos un mensaje especial
  void getUsers() async {
    final ref = db
        .collection(DataHolder().sCOLLETCTIONS_USERS)
        .where("uid", whereIn: DataHolder().usuario.friends)
        .withConverter(
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
    //Vamos a hacer un input text para mandar un mensaje especial
    //Un boton para acceder a la cámara en caso de que queramoso enviar una foto del momento
    //Otro botón para acceder a nuestra galería y enviar una foto desde ahí
    //Un último botón para enviar mensajes de voz
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomSlidingSegmentedControl<int>(
          initialValue: 2,
          children: {
            1: Icon(Icons.keyboard_voice),
            2: Icon(Icons.camera_alt_rounded),
            3: Icon(Icons.textsms_rounded),
          },
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          thumbDecoration: BoxDecoration(
            color: Colors.lightBlueAccent.shade700,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.3),
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0.0,
                  2.0,
                ),
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInToLinear,
          onValueChanged: (v) {
            print(v);
          },
        ),
      ]),
    ));
  }
}
