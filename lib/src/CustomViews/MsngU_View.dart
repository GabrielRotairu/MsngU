import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/tau.dart';

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
  void startRecording() async {

  }
  @override
  Widget build(BuildContext context) {
    //Vamos a hacer un input text para mandar un mensaje especial
    //Un boton para acceder a la cámara en caso de que queramoso enviar una foto del momento
    //Otro botón para acceder a nuestra galería y enviar una foto desde ahí
    //Un último botón para enviar mensajes de voz
    // TODO: implement build
   return  DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          flexibleSpace: TabBar(

            padding: EdgeInsets.all(3),
            indicatorColor: Colors.lightBlueAccent.shade100,
            //Dividimos la pantalla en 3 partes, Usuarios totales donde podremos ver y solicitar amistad,
            //la pantalla Peticiones donde vamos a poder ver nuestras peticiones y aceptarlas o rechazarlas
            //La pantalla amigos para ver nuestros amigos
            tabs: [
              Tab(

                  icon: Icon(Icons.camera_alt_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  icon: Icon(Icons.message_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  icon: Icon(Icons.keyboard_voice_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
            ],
          ),
        ),
        body: TabBarView(

          children: [
            Container(
            child: ElevatedButton(onPressed: () {  },child: Text(""),)
            ),
            Container(),
            Container(

    )

          ],
        ),
      ),

    );
  }
}
