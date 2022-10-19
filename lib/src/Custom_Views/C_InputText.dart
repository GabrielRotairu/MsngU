import 'package:flutter/material.dart';

class C_InputText extends StatelessWidget {
  final String sTitulo;
  final bool blIsPassword;
  final Icon iIcon;
  final int tLength;
  final TextEditingController myController = TextEditingController(text: "");

  C_InputText({Key? key, this.sTitulo = "", this.blIsPassword=false, this.iIcon= const Icon(Icons.abc),this.tLength=0})
      : super(key: key);


  String getText() {
    return myController.text;
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: blIsPassword,
      controller: myController,
      cursorColor: Colors.white,
      maxLength: tLength,
      decoration: InputDecoration(
        icon: iIcon,
        labelText: sTitulo,
        labelStyle: TextStyle(color: Colors.black12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
