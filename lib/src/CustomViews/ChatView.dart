

import 'dart:io';

import 'package:betamsngu/src/Firebase_Objects/ChatText.dart';
import 'package:betamsngu/src/List_Items/ChatTextItem.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatView();
  }
}

class _ChatView extends State<ChatView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<ChatText> chatTexts = [];
  final ImagePicker _picker = ImagePicker();
  bool bImageLoaded = false;
  late File imageFile;
  double dListHeightPercentage = 0.8;

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
    setState(() {
      bImageLoaded = false;
      dListHeightPercentage = 0.8;
    });
  }

  void ItemShortClick(int index) {}

  void selectImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
        bImageLoaded=true;
        dListHeightPercentage=0.5;
      });
    }
  }

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
              height:DataHolder().platformAdmin.getScreenHeight(context)*dListHeightPercentage,
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
                if(bImageLoaded)Container(height: DataHolder().platformAdmin.getScreenHeight(context)*0.3,
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.fitHeight,
                  ),
                ),
            MessageBar(
              onSend: (txt) => SendBtnPressed(txt),
              actions: [
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.blueAccent,
                      size: DataHolder().platformAdmin.getScreenWidth(context)*0.065,
                    ),
                    onTap: () {
                      selectImage();
                    },
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
