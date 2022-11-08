import 'package:betamsngu/src/Custom_Objects/C_ChatInput.dart';
import 'package:betamsngu/src/Firebase_Objects/ChatText.dart';
import 'package:betamsngu/src/List_Items/ChatTextItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatView();
  }
}

class _ChatView extends State<ChatView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<ChatText> chatTexts = [];
  C_ChatInput mensaje = C_ChatInput(
    Tcolor: Colors.white,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descargarTextos();
  }

  void descargarTextos() async {
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
          chatTexts.clear();

          for (int i = 0; i < event.docs.length; i++) {
            chatTexts.add(event.docs[i].data());
          }
        });
      },
      onError: (error) => print("listen falied $error"),
    );
  }

  void SendBtnPressed(String txt) async {
    final String path = DataHolder().sCOLLETCTIONS_CHATS_NAME +
        "/" +
        DataHolder().chat.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_CHAT_TEXTS_NAME;
    final docRef = db.collection(path);
    ChatText texto = ChatText(
        text: txt,
        time: Timestamp.now(),
        author: FirebaseAuth.instance.currentUser?.uid);
    await docRef.add(texto.toFirestore());
    mensaje.clear();
  }

  void ItemShortClick(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Image(image: AssetImage("assets/user.png")),
          title: Text(DataHolder().chat.userName!),
          backgroundColor: Colors.lightBlueAccent.shade700,
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 662,
                    child: ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: chatTexts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatTextItem(
                          sTexto: chatTexts[index].text!,
                          onShortClick: ItemShortClick,
                          index: index,
                          sAuthor: chatTexts[index].author!,
                        );
                      },
                    ),
                  ),
                  MessageBar(
                    onSend: (txt) =>SendBtnPressed(txt),
                    actions: [

                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: InkWell(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.blueAccent,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  /*  Flexible(child: mensaje),
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              SendBtnPressed();
                            },
                            child: Icon(
                              Icons.send,
                              size: 30,
                            ),
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(StadiumBorder()),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue)),
                          ),
                          margin: EdgeInsets.all(10),
                        ),*/
                ])),


    );
  }
}
