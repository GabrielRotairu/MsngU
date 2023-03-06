import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Platform_Admin {
  double dSCREEN_WIDTH = 0;
  double dSCREEN_HEIGHT = 0;
  late BuildContext context;

  Platform_Admin();


//Método para conseguir el ancho de la pantalla
  double getScreenWidth(BuildContext context) {
    dSCREEN_WIDTH = MediaQuery.of(context).size.width;
    return dSCREEN_WIDTH;
  }
//Método para conseguir el alto de la pantalla
  double getScreenHeight(BuildContext context) {
    dSCREEN_HEIGHT = MediaQuery.of(context).size.height;
    return dSCREEN_HEIGHT;
  }
//Metodo para ver si la plataforma en la que se ejecuta es Android
  bool isAndroidPlatform(){
    return defaultTargetPlatform == TargetPlatform.android;
  }
//Metodo para ver si la plataforma en la que se ejecuta es IOS

  bool isIOSPlatform(){
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
//Metodo para ver si la plataforma en la que se ejecuta es Web

  bool isWebPlatform(){
    return defaultTargetPlatform != TargetPlatform.android
        && defaultTargetPlatform != TargetPlatform.iOS

        ;
  }
}
