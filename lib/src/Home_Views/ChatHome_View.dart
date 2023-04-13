import 'package:betamsngu/src/Custom_Objects//C_InputText.dart';
import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/ChatText.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/List_Items/ChatItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatHomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatHomeView();
  }
}

class _ChatHomeView extends State<ChatHomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
String lastMessage="";
  List<ChatText> chatTexts = [];
  C_InputText inputMsg = C_InputText();
  List<Usuario> friendList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actualizarListas();
    getFriends();
  }
//Vamos a descargar los chats que corresponden a nuestro usuario y a enseñarlos en una lista:
  void actualizarListas() async {
    final docRef = db.collection("Chats").
    where("members",arrayContains: DataHolder().usuario.uid).
    withConverter(
        fromFirestore: Chat.fromFirestore,
        toFirestore: (Chat chat, _) => chat.toFirestore());
    final docSnap = await docRef.get();
print(docRef.toString());
    setState(() {
      DataHolder().ChatList.clear();
      for (int i = 0; i < docSnap.docs.length; i++) {
        DataHolder().ChatList.add(docSnap.docs[i].data());
      }
    });
  }
//Vamos a descargar los usuarios que estén en nuestra lista de amigos para chatear con ellos.
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
void getLastMessage() async{

  final String path = DataHolder().sCOLLETCTIONS_CHATS_NAME +
      "/" +
      DataHolder().chat.uid +
      "/" +
      DataHolder().sCOLLETCTIONS_CHAT_TEXTS_NAME;
  final docRef = db.collection(path).orderBy('time').withConverter(
      fromFirestore: ChatText.fromFirestore,
      toFirestore: (ChatText text, _) => text.toFirestore());
  final docSnap = await docRef.snapshots().listen(
        (event) {
      setState(() {
      //lastMessage=docSnap.data();
      });
    },
    onError: (error) => print("listen falied $error"),
  );

}
//Método que nos manda al chat que se haya pulsado.
  void ItemShortClick(int index) {
    print("DEBUG:   " + index.toString());
    DataHolder().chat = DataHolder().ChatList[index];
    Navigator.pushNamed(context, "/Chats");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: DataHolder().ChatList.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatItem(
              sTexto:DataHolder().ChatList[index].chatname!,
              sMensaje: "hola :)",
              onShortClick: ItemShortClick,
              index: index,
              aImage: "assets/user.png",
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
      //Este botón nos permitirá ir a la lista de amigos para iniciar un chat nuevo
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/Friends');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
