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

      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/user.png'),
                radius: 100,
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            Text(
              'User Name : ',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            Flexible(child:
            Text(
              DataHolder().usuario.name!,
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ) ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            Flexible(child:
            Text(
              'Age',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            )),

            SizedBox(height: 10),
            Text(
              DataHolder().usuario.age!.toString(),
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    DataHolder().usuario.description!,
                    style: TextStyle(
                        color: Colors.grey, fontSize: 15, letterSpacing: 1),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
