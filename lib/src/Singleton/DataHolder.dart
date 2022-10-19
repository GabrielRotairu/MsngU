import 'package:betamsngu/src/Firebase_Objects/FB_Admin.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();

  String sMensaje = "";
  Usuario usuario = Usuario();

   DataHolder._internal() {
    //sMensaje="Lorem Ipsum ";
  }

  factory DataHolder() {
    return _dataHolder;
  }

  Future<void> DescargarMiPerfil() async {
    usuario = FB_Admin().DescargarPerfil(FirebaseAuth.instance.currentUser?.uid)
    as Usuario;
  }

  Future<void> DescargarPerfil(String? idPerfil) async {
    await FB_Admin().DescargarPerfil(idPerfil) as Usuario;
  }

  bool isMiPerfilDownloaded() {
    return usuario != null;
  }
}
