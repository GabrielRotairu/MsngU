import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/FB_Admin.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/platform/Platform_Admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();

  String sMensaje = "";
  Usuario usuario = Usuario();
  Chat chat = Chat();
  String sCOLLETCTIONS_CHATS_NAME = "Chats";
  String sCOLLETCTIONS_USERS = "Usuarios";
  String sCOLLETCTIONS_CHAT_TEXTS_NAME = "Texts";
  late Platform_Admin platformAdmin;


  DataHolder._internal() {
    //sMensaje="Lorem Ipsum ";
    platformAdmin=Platform_Admin();
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
   if(FirebaseAuth.instance.currentUser== null){
     return false;
   }
   else{
     return true;
   }
  }
}
