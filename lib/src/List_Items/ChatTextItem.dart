import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatTextItem extends StatelessWidget {
  final String sTexto;
  final Function(int Index) onShortClick;
  final int index;
  final String sAuthor;

  ChatTextItem(
      {Key? key,
      this.sTexto = "HOLA :)",
      required this.onShortClick,
      required this.index, required this.sAuthor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        sent: true,
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
