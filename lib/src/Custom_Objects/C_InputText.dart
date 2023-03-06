import 'package:flutter/material.dart';
//Clase para poder usar TextFields en los LogIn
class C_InputText extends StatelessWidget {

  //Parámetros de nuestro InputText
  final String sTitulo;
  final bool blIsPassword;
  final Icon iIcon;
  final int tLength;
  final Color Tcolor;
  final TextEditingController myController = TextEditingController();

  C_InputText(
      {Key? key,
      this.sTitulo = "",
      this.blIsPassword = false,
      this.iIcon = const Icon(Icons.abc),
      this.tLength = 10,
      this.Tcolor=Colors.black})
      : super(key: key);
//Metodo para poder recoger lo que se haya escrito
  String getText() {
    return myController.text;


  }
  //Método para borrar lo que se haya escrito
  void clear(){
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: blIsPassword,
      controller: myController,
      cursorColor: Colors.white,
      style: TextStyle(color: Tcolor),
      //resizeToAvoidBottomInset:true,
      maxLength: tLength,
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
