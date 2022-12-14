import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FB_Admin {
  FB_Admin() {

  }

  Future<Usuario?> DescargarPerfil(String ? idUser) async {
    FirebaseFirestore db= FirebaseFirestore.instance;
    final docRef = db
        .collection("Usuarios")
        .doc(idUser)
        .withConverter(
      fromFirestore: Usuario.fromFirestore,
      toFirestore: (Usuario usuario, _) => usuario.toFirestore(),
    );

    final docSnap = await docRef.get();
    return docSnap.data();
  }

}