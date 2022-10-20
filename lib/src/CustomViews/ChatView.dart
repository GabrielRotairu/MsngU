import 'package:betamsngu/src/Custom_Objects//C_InputText.dart';
import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/ChatText.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/List_Items/ChatItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatView();
  }
}

class _ChatView extends State<ChatView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Chat> ChatList = [];
  List<ChatText> chatTexts = [];
  C_InputText inputMsg = C_InputText();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actualizarListas();
  }
  void actualizarListas() async {
    final docRef = db.collection("Chats").withConverter(
        fromFirestore: Chat.fromFirestore,
        toFirestore: (Chat chat, _) => chat.toFirestore());
    final docSnap = await docRef.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        ChatList.add(docSnap.docs[i].data());
      }
    });
  }

  void descargarTextos() async {
    final String path = DataHolder().sCOLLETCTIONS_CHATS_NAME +
        "/" +
        DataHolder().chat.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_CHAT_TEXTS_NAME;
    final docRef = db.collection(path).withConverter(
        fromFirestore: ChatText.fromFirestore,
        toFirestore: (ChatText text, _) => text.toFirestore());
    final docSnap = await docRef.snapshots().listen(
          (event) {
        setState(() {
          chatTexts.clear();

          for (int i = 0; i < event.docs.length; i++) {
            chatTexts.add(event.docs[i].data());
          }
        });
      },
      onError: (error) => print("listen falied $error"),
    );
  }

   void SendBtnPressed() async {
    final String path = DataHolder().sCOLLETCTIONS_CHATS_NAME +
        "/" +
        DataHolder().chat.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_CHAT_TEXTS_NAME;
    final docRef = db.collection(path);
    ChatText texto = ChatText(
        text: inputMsg.getText(),
        time: Timestamp.now(),
        author: DataHolder().usuario.UID);
    await docRef.add(texto.toFirestore());
    descargarTextos();
  }

  void ItemShortClick(int index) {
    print("DEBUG:   " + index.toString());
    print("DEBUG:   " + ChatList[index].userName!);
    DataHolder().chat = ChatList[index];
    Navigator.pushNamed(context, "/Chat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade400,
      body: Center(
        child:  ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: ChatList.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatItem(
              sTitulo: ChatList[index].userName!,
              onShortClick: ItemShortClick,
              index: index,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
          ),


    );
  }
}
