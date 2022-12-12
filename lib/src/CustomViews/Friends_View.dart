import 'package:betamsngu/src/CustomViews/Friends_View.dart';
import 'package:flutter/material.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';

class Friends_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Friends_View();
  }
}

class _Friends_View extends State<Friends_View> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        title: Text(DataHolder().usuario.name!),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink.image(image: AssetImage("assets/user.png")),
            Container(child: Text(DataHolder().usuario.description!)),
            Container(child: Text(DataHolder().usuario.age.toString()!)),


          ],
        ),
      ),

    );
  }
}
