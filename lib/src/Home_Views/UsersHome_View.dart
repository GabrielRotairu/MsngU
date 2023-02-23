import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/List_Items/PetitionItem.dart';
import 'package:betamsngu/src/List_Items/UserItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:betamsngu/src/List_Items//FriendItem.dart';

class UsersHome_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UsersHome_View();
  }
}

class _UsersHome_View extends State<UsersHome_View> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String sNombre = "AQUI IRA EL NOMBRE";
  List<Usuario> friendList = [];
  List<Usuario> userList = [];
  List<Usuario> petitionsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetitions();
    getUsers();
    getFriends();
    print("DEBUG------> FRIENDS:" + DataHolder().usuario.friends.toString());
  }

  void getFriends() async {
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
        friendList.add(docSnap.docs[i].data());
      }
    });
  }

  void getPetitions() async {
    final ref = db
        .collection(DataHolder().sCOLLETCTIONS_USERS)
        .where("uid", whereIn: DataHolder().usuario.petitions)
        .withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario u, _) => u.toFirestore(),
        );
    final docSnap = await ref.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        petitionsList.add(docSnap.docs[i].data());
      }
    });
  }

  void getUsers() async {
    final ref = db.collection(DataHolder().sCOLLETCTIONS_USERS).withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario u, _) => u.toFirestore(),
        );
    final docSnap = await ref.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        userList.add(docSnap.docs[i].data());
      }
    });
  }

  void listItemShortClicked(int index) {
    print("DEBUG: " + index.toString());
    print("DEBUG: " + friendList[index].name!);
    DataHolder().usuario = friendList[index];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TabBar(
            padding: EdgeInsets.all(3),
            indicatorColor: Colors.lightBlueAccent.shade100,
            tabs: [
              Tab(
                  text: 'Users',
                  icon: Icon(Icons.person_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  text: 'Requests',
                  icon: Icon(Icons.person_add_alt_1_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  text: 'Friends',
                  icon: Icon(Icons.group_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                padding: EdgeInsets.all(8),
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserItem(
                    sName: userList[index].name!,
                    iAge: userList[index].age!,
                    sDesc: userList[index].description!,
                    onShortClick: listItemShortClicked,
                    index: index,
                    usuario: userList[index],
                  );
                }),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                padding: EdgeInsets.all(8),
                itemCount: petitionsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return PetitionItem(
                    sName: petitionsList[index].name!,
                    iAge: petitionsList[index].age!,
                    sDesc: petitionsList[index].description!,
                    onShortClick: listItemShortClicked,
                    index: index,
                    usuario: petitionsList[index],
                  );
                }),
            ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: friendList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FriendItem(
                      sName: friendList[index].name!,
                      iAge: friendList[index].age!,
                      sDesc: friendList[index].description!,
                      index: index);
                }),
          ],
        ),
      ),
    );
  }
}
