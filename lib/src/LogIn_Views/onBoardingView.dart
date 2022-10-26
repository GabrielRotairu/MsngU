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
    tLength: 100,
  );
  C_InputText input2 = C_InputText(
    sTitulo: "Age",
    tLength: 3,
  );

  C_InputText input4 = C_InputText(
    sTitulo: "Address",
    tLength: 100,
    iIcon: Icon(Icons.location_city_rounded),
  );

  void btnAceptar() async {
    Usuario usuario = new Usuario(
        name: input1.getText(),
        email: input4.getText(),
        age: int.parse(input2.getText()));

    db
        .collection("Usuarios")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(usuario.toFirestore())
        .onError((e, _) => print("Error on writing document : $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Boarding'),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
            TextButton(
              onPressed: () {},
              child: Image.asset('assets/user.png', scale: 1.25),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: input4,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: input2,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: input1,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    btnAceptar();
                    Navigator.of(context).popAndPushNamed('/Home');
                  },
                  child: Text('Crear Usuario'),
                ),
                ElevatedButton(
                  onPressed: () {
                    input1.clear();
                    input2.clear();
                    input4.clear();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            )
          ],
        ),
      ),
      //backgroundColor: Colors.teal.shade200,
    );
  }
}
