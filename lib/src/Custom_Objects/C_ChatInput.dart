import 'package:flutter/material.dart';

class C_ChatInput extends StatelessWidget {
  final String sTexto;
  final Icon iIcon;
  final Color Tcolor;
  final TextEditingController myController = TextEditingController();

  C_ChatInput(
      {Key? key,
        this.sTexto = "",
        this.iIcon = const Icon(Icons.abc),
        this.Tcolor=Colors.black})
      : super(key: key);

  String getText() {
    return myController.text;
  }
  void clear(){
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      cursorColor: Colors.white,
      style: TextStyle(color: Tcolor),
      //resizeToAvoidBottomInset:true,
      decoration: InputDecoration(
        //icon: iIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
        labelText: sTexto,
        labelStyle: TextStyle(color: Colors.black12),
        border: OutlineInputBorder(
          gapPadding: 20.0,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.black),

        ),
      ),
    );
  }
}
