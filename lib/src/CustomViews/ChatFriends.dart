import 'package:betamsngu/App.dart';
import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/List_Items/ChatFriendITem.dart';
import 'package:betamsngu/src/List_Items/FriendItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ChatFriends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatFriends();
  }
}

class _ChatFriends extends State<ChatFriends> {
  List<Usuario> friendList = [];
List<String> uidChats=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriends();
  }
/*
  void iniciarChat() async{
    FirebaseFirestore db= FirebaseFirestore.instance;
    final docRef = db.collection("Chats").
    where("members",arrayContainsAny: uidChats).
    withConverter(
        fromFirestore: Chat.fromFirestore,
        toFirestore: (Chat chat, _) => chat.toFirestore());
    final docSnap = await docRef.get();
    print(docRef.toString());
    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        //ChatList.add(docSnap.docs[i].data());
        print("CHATS CON MIEMBROS ELEGIDOS");
      }
    });

  }*/
//Este método nos va a permitir saber si el chat con el Usuario seleccionado existe y si no que cree uno
  void iniciarChat() async{
bool existeChat=false;
    Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
Chat chatelegido=Chat();
    for(int i=0; i <DataHolder().ChatList.length;i++){

     print(DataHolder().ChatList[i].members.toString()+"    "+uidChats.toString());
      if(unOrdDeepEq(DataHolder().ChatList[i].members,uidChats)){
      existeChat=true;
        print("existe");
        chatelegido=DataHolder().ChatList[i];

      }

    }
if(existeChat=true){
  DataHolder().chat=chatelegido;
  Navigator.pushNamed(context, "/Chats");

}
else{


  FirebaseFirestore db = FirebaseFirestore.instance;
  await db
      .collection("Chats")
      .doc()
      .set(DataHolder().chat.toFirestore())
      .onError((e, _) => print("Error on writing document : $e"));
}
Chat nuevoChat=Chat(
   chatname:"ac",
    members: uidChats




);


  }
//En este método vamos a descargarnos las lista de amigos que tiene el usuario
  void getFriends() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        //Hacemos una lista para ver los amigos del usuario
          child: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: friendList.length,
        itemBuilder: (BuildContext context, int index) {
          //Devolvemos los datos del amigo con el que chatearr
          return ChatFriendItem(
            index: index,
            usuario: friendList[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      )),
      //Hacemos un botón para la función del iniciarChat()
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          uidChats=[DataHolder().usuario.uid];
          for(int i =0;i<friendList.length;i++) {
                if(friendList[i].isChecked==true){

                  uidChats.add(friendList[i].uid);

                }
            print("USUSARIOS CHECKED:       "+friendList[i].isChecked.toString());

          }
          iniciarChat();
         // print(uidChats);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
