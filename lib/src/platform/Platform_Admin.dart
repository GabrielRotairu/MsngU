import 'package:flutter/material.dart';

class Platform_Admin {
  double dSCREEN_WIDTH=0;
  double dSCREEN_HEIGHT=0;
  late BuildContext context;

  Platform_Admin();
}
void initDisplayData(BuildContext context) {
//this.context=context;
}
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}