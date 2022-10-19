import 'package:betamsngu/src/Custom_Views/C_InputText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  void btnRegister(
      String emailAddres, String password, BuildContext context) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddres,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("------->>>>   ERROR DE CREACION DE USUARIO " + e.code);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    print("Usuario creado correctamente :) ");
  }

  @override
  Widget build(BuildContext context) {
    C_InputText input1 = C_InputText(
      sTitulo: "Ususario",
      tLength: 50,
    );
    C_InputText input2 = C_InputText(
      sTitulo: "Password",
      blIsPassword: true,
      tLength: 8,
    );
    C_InputText input3 = C_InputText(
      sTitulo: "Password",
      blIsPassword: true,
      tLength: 8,

    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: Center(
        child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          input1,
          input2,
          input3,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (input2.getText() == input3.getText()) {
                    btnRegister(input1.getText(), input2.getText(), context);
                  }
                },
                child: Text('Registrarse'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/LogIn');
                },
                child: Text('Volver a Iniciar Sesión'),
              ),
            ],
          )
        ],
        ),
      ),
      backgroundColor: Colors.lightBlueAccent.shade400,
    );
  }
}
