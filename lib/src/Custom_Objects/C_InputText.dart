import 'package:flutter/material.dart';

class C_InputText extends StatelessWidget {
  final String sTitulo;
  final bool blIsPassword;
  final Icon iIcon;
  final int tLength;
  final TextEditingController myController = TextEditingController();

  C_InputText(
      {Key? key,
      this.sTitulo = "",
      this.blIsPassword = false,
      this.iIcon = const Icon(Icons.abc),
      this.tLength = 0})
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
      obscureText: blIsPassword,
      controller: myController,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      //resizeToAvoidBottomInset:true,
      decoration: InputDecoration(
        //icon: iIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
        labelText: sTitulo,
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
