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

    final docsRef = db.collection("Usuario").
    orderBy("Amigos").
    withConverter(fromFirestore: Usuario.fromFirestore,
        toFirestore: (Usuario usuario, _) => usuario.toFirestore());

    final docsSnap = await docsRef.get();

    setState(() {
      for (int i = 0; i < docsSnap.docs.length; i++) {
        friendList.add(docsSnap.docs[i].data());
      }
    });
  }
  void listItemShortClicked(int index){
    print("DEBUG: "+index.toString());
    print("DEBUG: "+friendList[index].name!);
    //DataHolder().selectedChatRoom=chatRooms[index];
    Navigator.of(context).pushNamed("/Friends");
  }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
          body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[100],
                child: Text("amigo1"),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[200],
                child: Text('amigo1'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[300],
                child: Text(' amigo1'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[400],
                child: Text('amigo1'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[500],
                child: Text('amigo1'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.teal[600],
                child: Text('amigo1'),
              ),
            ],
          ));
    }
  }



