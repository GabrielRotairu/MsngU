import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final int index;


  const FriendItem(
      {Key? key,
      required this.sName,
      required this.sDesc,
      required this.iAge,

        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Clase que nos permite descargar todos los usuarios para que luego se puedan introducir en una lista
    //En este caso solo descargará los datos de los usuarios que estén en nuestra lista de amigos
    // TODO: implement build
    return Container(
      child: ListTile(
        leading: Image(
          image: AssetImage("assets/user.png"),
        ),
        title: Text(sName!.toString() ),
        subtitle: Text(sDesc.toString()),
      ),
    );
  }
}
