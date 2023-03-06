import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatTextItem extends StatelessWidget {
  final String sTexto;
  final Function(int Index) onShortClick;
  final int index;
  final String sAuthor;
  final String? imgUrl;

  ChatTextItem(
      {Key? key,
      this.sTexto = "HOLA :)",
      required this.onShortClick,
      required this.index, required this.sAuthor,required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Clase en la que se van a descargar los mensajes de un chat (tanto del usuario con el que se está chateando
    //como del usuario que esté loggeado).
    // TODO: implement build
    //print(""+imgUrl);
    if(imgUrl!=null && imgUrl!.isNotEmpty){
      return Image.network(imgUrl!);}
    if(sAuthor==FirebaseAuth.instance.currentUser?.uid) {
      return BubbleNormal(
        text: sTexto,
        isSender: true,
        color: Colors.blue.shade200,
        tail: true,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),

      );
    }
    else{
      return BubbleNormal(
        text: sTexto,
        isSender: false,
        color: Colors.red.shade200,
        tail: true,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      );
    }



  }
}
