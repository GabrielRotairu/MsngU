import 'package:betamsngu/src/Custom_Objects//C_InputText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

C_InputText input1 = C_InputText(
  sTitulo: "Email",
  tLength: 50,
);
C_InputText input2 = C_InputText(
  sTitulo: "Password",
  blIsPassword: true,
  tLength: 8,
);

void btnlog(BuildContext context) async {
  print("--------------->" + input1.getText());
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: input1.getText(),
      password: input2.getText(),
    );
    Navigator.of(context).popAndPushNamed("/Home");
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
  print("USUARIO LOGEADO CORRECTAMENTE");
}

class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log  in"),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.all(20)),
          Container(
            child: input1,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          Container(
            child: input2,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    btnlog(context);
                  },
                  child: Text('Log In'),
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/Register');
                  },
                  child: Text('Sign In'),
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
