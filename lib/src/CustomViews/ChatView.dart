import 'package:betamsngu/src/Custom_Objects/C_InputText.dart';
import 'package:betamsngu/src/Firebase_Objects/ChatText.dart';
import 'package:betamsngu/src/List_Items/ChatTextItem.dart';
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
  List<ChatText> chatTexts = [];
  C_InputText inputMsg = C_InputText();

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
  }

  void ItemShortClick(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade700,
      appBar: AppBar(
        title: Text(DataHolder().chat.userName!),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.lightBlueAccent.shade200,
              height: 650.0,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: chatTexts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatTextItem(
                    sTexto: chatTexts[index].text!,
                    onShortClick: ItemShortClick,
                    index: index,
                  );
                },
              ),
            ),
            SingleChildScrollView(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    child: OutlinedButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                )),
                Flexible(
                  child: inputMsg,
                ),
                Flexible(
                  child: OutlinedButton(
                    onPressed: SendBtnPressed,
                    child: Icon(Icons.send),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
