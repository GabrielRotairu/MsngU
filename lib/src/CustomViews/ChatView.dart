import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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

// Metodo donde podemos descargar los mensajes asociados al chat
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

//Método que ira con el botón de enviar mensaje:
  void SendBtnPressed(String txt) async {
    String sUrl = "";
    if (bImageLoaded) {
      final storageRef =
          FirebaseStorage.instance.ref(); //Apunta a la / del storage
      final imagen1ImagesRef = storageRef
          .child("fotos/${DataHolder().chat.uid}/img${Timestamp.now()}.png");

      try {
        await imagen1ImagesRef.putFile(imageFile);
        sUrl = await imagen1ImagesRef.getDownloadURL();

        setState(() {
          bImageLoaded = false;
          dListHeightPercentage = 0.8;
        });
      } on FirebaseException catch (e) {
        print("HUBO UN ERROR EN EL ENVIO DE LA IMAGEN: $e");
      }
    }
    String path = DataHolder().sCOLLETCTIONS_CHATS_NAME +
        "/" +
        DataHolder().chat.uid +
        "/" +
        DataHolder().sCOLLETCTIONS_CHAT_TEXTS_NAME;

    final docRef = db.collection(path);

    ChatText nuevoMensaje = ChatText(
        text: txt,
        author: FirebaseAuth.instance.currentUser?.uid,
        time: Timestamp.now(),
        imgUrl: sUrl);

    await docRef.add(nuevoMensaje.toFirestore());
  }

  void ItemShortClick(int index) {}

//Método que nos va a permitir ver nuestra galeria para enviar una foto

  void takePhoto() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    //final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        bImageLoaded = true;
        dListHeightPercentage = 0.5;
      });
    }
  }

  void selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        bImageLoaded = true;
        dListHeightPercentage = 0.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Image(image: AssetImage("assets/user.png")),
        title: Text(DataHolder().chat.chatname!),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Container(
              height: DataHolder().platformAdmin.getScreenHeight(context) *
                  dListHeightPercentage,
              child: ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: chatTexts.length,
                itemBuilder: (BuildContext context, int index) {
                  //Devolvemos el mensaje a la lista
                  return ChatTextItem(
                    sTexto: chatTexts[index].text!,
                    onShortClick: ItemShortClick,
                    index: index,
                    sAuthor: chatTexts[index].author!,
                    imgUrl: chatTexts[index].imgUrl,
                  );
                },
              ),
            ),
            if (bImageLoaded)
              Container(
                //Enseñamos la foto antes de enviarla
                height:
                    DataHolder().platformAdmin.getScreenHeight(context) * 0.3,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.fitHeight,
                ),
                color: Colors.lightBlue,
              ),
            MessageBar(
              onSend: (txt) => SendBtnPressed(txt),
              actions: [
                Padding(
                  //Metemos los diferentes accesos tanto a cámara como a galería.
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.lightBlueAccent,
                      size: DataHolder().platformAdmin.getScreenWidth(context) *
                          0.065,
                    ),
                    onTap: () {
                      takePhoto();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.photo_outlined,
                      color: Colors.lightBlueAccent,
                      size: DataHolder().platformAdmin.getScreenWidth(context) *
                          0.065,
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
