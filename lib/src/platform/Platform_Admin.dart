import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Platform_Admin {
  double dSCREEN_WIDTH = 0;
  double dSCREEN_HEIGHT = 0;
  late BuildContext context;

  Platform_Admin();



  double getScreenWidth(BuildContext context) {
    dSCREEN_WIDTH = MediaQuery.of(context).size.width;
    return dSCREEN_WIDTH;
  }

  double getScreenHeight(BuildContext context) {
    dSCREEN_HEIGHT = MediaQuery.of(context).size.height;
    return dSCREEN_HEIGHT;
  }

  bool isAndroidPlatform(){
    return defaultTargetPlatform == TargetPlatform.android;
  }

  bool isIOSPlatform(){
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool isWebPlatform(){
    return defaultTargetPlatform != TargetPlatform.android
        && defaultTargetPlatform != TargetPlatform.iOS

        ;
  }
}
