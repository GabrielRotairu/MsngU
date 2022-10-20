import 'package:betamsngu/src/Custom_Objects//C_InputText.dart';
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
  //List<FBText> chatTexts = [];
  C_InputText inputMsg = C_InputText();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  descargarTextos();
  }

  /*void descargarTextos() async {
    final String path = DataHolder().sCOLLETCTIONS_ROOMS_NAME +
        "/" +
        DataHolder().selectedChatRoom.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_TEXTS_NAME;
    final docRef = db.collection(path).withConverter(
        fromFirestore: FBText.fromFirestore,
        toFirestore: (FBText text, _) => text.toFirestore());
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
  }*/

 /* void SendBtnPressed() async {
    final String path = DataHolder().sCOLLETCTIONS_ROOMS_NAME +
        "/" +
        DataHolder().selectedChatRoom.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_TEXTS_NAME;
    final docRef = db.collection(path);
    FBText texto = FBText(
        text: inputMsg.getText(),
        time: Timestamp.now(),
        author: DataHolder().perfil.UID);
    await docRef.add(texto.toFirestore());
    //descargarTextos();
  }*/

  void ItemShortClick(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade400,
      body: ListView(



      ),

    );
  }
}
