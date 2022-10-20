import 'package:betamsngu/src/Custom_Objects//C_InputText.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class onBoardingView extends StatelessWidget {
  onBoardingView({Key? key}) : super(key: key);
  FirebaseFirestore db = FirebaseFirestore.instance;
  C_InputText input1 = C_InputText(
    sTitulo: "Name",
    iIcon: Icon(Icons.text_fields_rounded),
  );
  C_InputText input2 = C_InputText(
    sTitulo: "Age",
    iIcon: Icon(Icons.calendar_month_rounded),
  );
  C_InputText input3 = C_InputText(
    sTitulo: "email",
    iIcon: Icon(Icons.email_rounded),
  );
  C_InputText input4 = C_InputText(
    sTitulo: "Address",
    iIcon: Icon(Icons.location_city_rounded),
  );

  void btnAceptar() async {
    Usuario usuario = new Usuario(
        name: input1.getText(),
        email: input4.getText(),
        address: input3.getText(),
        age: int.parse(input2.getText()));

    db
        .collection("perfiles")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(usuario.toFirestore())
        .onError((e, _) => print("Error on writing document : $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Boarding'),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            input3,
            input2,
            input4,
            input1,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    btnAceptar();
                  },
                  child: Text('Crear Usuario'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade200,
    );
  }
}
