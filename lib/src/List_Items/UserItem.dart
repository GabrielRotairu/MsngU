import 'package:betamsngu/main.dart';
import 'package:betamsngu/src/Firebase_Objects/Firebase_Services/Notifications.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

class UserItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final Function(int index) onShortClick;
  final int index;
  final Usuario usuario;

  //Método que nos permite añadir una petición a la lista del usuario que queremos tener como amigo
  void BtnEnviar() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("Usuarios")
        .doc(usuario.uid)
        .set(usuario.toFirestore())
        .onError((e, _) => print("Error on writing document : $e"));

  }

  const UserItem(
      {Key? key,
      required this.sName,
      required this.sDesc,
      required this.iAge,
      required this.onShortClick,
      required this.index,
      required this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Esta clase nos permitirá ver los usuarios que hay en nuestra base de datos y meterlos en una lista
    //En este caso descargará la información de todos los usuarios y nos permitirá enviar solicitudes de amistad
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          FluttermojiCircleAvatar(),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text(""),
          ),
          ListTile(
            title: Text(
              sName + "," + iAge.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            subtitle: Text(sDesc),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text(""),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (usuario.petitions!.contains(DataHolder().usuario.uid)) {
                      usuario.petitions!.remove(DataHolder().usuario.uid);
                    } else {
                      usuario.petitions!.add(DataHolder().usuario.uid);
                    }
                    BtnEnviar();
                  },
                  child: Text("Send Petition ")),
            ],
          )
        ],
      ),
      color: Colors.grey.shade100,
    );
  }
}
