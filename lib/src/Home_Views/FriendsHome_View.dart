import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:betamsngu/src/List_Items//FriendItem.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("DEBUG------> FRIENDS:"+DataHolder().usuario.friends.toString());
    getUsers();

  }

  void getUsers() async {
    final ref = db.collection(DataHolder().sCOLLETCTIONS_USERS).
    where("uid", whereIn: DataHolder().usuario.friends).
    withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario u, _) => u.toFirestore(),
        );
    final docSnap = await ref.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        friendList.add(docSnap.docs[i].data());
      }
    });
  }

  void listItemShortClicked(int index) {
    print("DEBUG: " + index.toString());
    print("DEBUG: " + friendList[index].name!);
    DataHolder().usuario = friendList[index];
    //Navigator.of(context).pushNamed("/Users");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            padding: EdgeInsets.all(8),
            itemCount: friendList.length,
            itemBuilder: (BuildContext context, int index) {
              return FriendItem(
                  sName: friendList[index].name!,
                  iAge: friendList[index].age!,
                  sDesc: friendList[index].description!,
                  onShortClick: listItemShortClicked,
                  index: index);
            }),
      ),

    );
  }
}
