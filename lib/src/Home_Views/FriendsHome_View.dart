import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendsHome_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FriendsHome_View();
  }
}

class _FriendsHome_View extends State<FriendsHome_View> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String sNombre = "AQUI IRA EL NOMBRE";
  List<Usuario> friendList = [];

  void getFriends() async {
    final docsRef = db
        .collection("Usuarios")
        .withConverter(
            fromFirestore: Usuario.fromFirestore,
            toFirestore: (Usuario usuario, _) => usuario.toFirestore());

    final docsSnap = await docsRef.get();

    setState(() {
      for (int i = 0; i < docsSnap.docs.length; i++) {
        friendList.add(docsSnap.docs[i].data());
      }
    });
  }

  void listItemShortClicked(int index) {
    print("DEBUG: " + index.toString());
    print("DEBUG: " + friendList[index].name!);
    Navigator.of(context).pushNamed("/Friends");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: friendList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.amber,
              child: Center(
                  child: Text(friendList[index].friends.toString().toUpperCase())),
            );
          }),
    );
  }
}
