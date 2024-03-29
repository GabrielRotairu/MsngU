import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/FB_Admin.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/platform/Platform_Admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal();
  List<Chat> ChatList = [];
  String sMensaje = "";
  Usuario usuario = Usuario();
  Chat chat = Chat();
  String sCOLLETCTIONS_CHATS_NAME = "Chats";
  String sCOLLETCTIONS_USERS = "Usuarios";
  String sCOLLETCTIONS_CHAT_TEXTS_NAME = "Texts";
  late Platform_Admin platformAdmin;
  Function usuarioListener=(Usuario usuario){print("");};

  DataHolder._internal() {
    //sMensaje="Lorem Ipsum ";
    platformAdmin=Platform_Admin();
  }

  factory DataHolder() {
    return _dataHolder;
  }


  void setUsuarioDatosListener(void perfilActualizado(Usuario usuario)){
    usuarioListener=perfilActualizado;
  }
//Descargamos nuestro perfil actual
  Future<void> DescargarMiPerfil() async {

    await FB_Admin().DescargarPerfil(FirebaseAuth.instance.currentUser?.uid,(event) {
      usuario=event.data()!;
      print("USUSARIO LISTENER:"+usuario.toString());
      usuarioListener(usuario);
      //
    },);
  }
//Descargamos los perfiles restantes
  Future<void> DescargarPerfil(String? idPerfil) async {
    await FB_Admin().DescargarPerfil(idPerfil,(event) {

    },) as Usuario;
  }
//Comprobamos que nuestro perfil está descargado
  bool isMiPerfilDownloaded() {
   if(FirebaseAuth.instance.currentUser== null){
     return false;
   }
   else{
     return true;
   }
  }
}
