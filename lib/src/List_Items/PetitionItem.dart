import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetitionItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final Function(int index) onShortClick;
  final int index;
  final Usuario usuario;
//Este método nos permite añadir el amigo tanto a nuestro usuario como al usuario que nos ha
  //solicitado ser amigo nuestro a la base de datos
  void btnAcept() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection("Usuarios")
        .doc(DataHolder().usuario.uid)
        .set(DataHolder().usuario.toFirestore())
        .onError((e, _) => print("Error on writing document : $e"));
    await db
        .collection("Usuarios")
        .doc(usuario.uid)
        .set(usuario.toFirestore())
        .onError((e, _) => print("Error on writing document : $e"));
  }

  //btnDeny(){}


  const PetitionItem(
      {Key? key,
      required this.sName,
      required this.sDesc,
      required this.iAge,
      required this.onShortClick,
      required this.index,
      required this.usuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user.png'),
            radius: 80,
          ),
          ListTile(
            title: Text(
              sName + ", " + iAge.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            subtitle: Text(sDesc.toString()),
            /*  onTap: () {
              onShortClick(index);
            },*/
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(""),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                //en el onPressed vamos a comprobar que el id del usuario no esta en nuestra lista de amigos
                //En caso de que no esté lo añada y en caso de que esté le diga que el usuario ya es amigo nuestro
                  onPressed: () {
                    if(usuario.friends!.contains(DataHolder().usuario.uid)){
                    print("ya sois amigos xd");
                    }
                    else{
                      usuario.friends!.add(DataHolder().usuario.uid);
                      DataHolder().usuario.friends!.add(usuario.uid);
                      DataHolder().usuario.petitions!.remove(usuario.uid);

                    }
                    btnAcept();
                  },
                  child: Text("Accept"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStatePropertyAll(StadiumBorder()))),
              ElevatedButton(
                //Hacemos otro boton para borrar la peticion de nuestra lista en caso de que no queramos que el
                // usuario esté en nuestra lista de amigos.
                onPressed: () {

                  DataHolder().usuario.petitions!.remove(usuario.uid);
                    usuario.petitions!.remove(DataHolder().usuario.uid);

                 // btnDeny();
                },
                child: Text("Deny"),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    shape: MaterialStatePropertyAll(StadiumBorder())),
              )
            ],
          )
        ],
      ),
    );
  }
}
