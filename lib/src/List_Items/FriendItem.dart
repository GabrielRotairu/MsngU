import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final int index;


  const FriendItem(
      {Key? key,
      required this.sName,
      required this.sDesc,
      required this.iAge,

        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListTile(
        leading: Image(
          image: AssetImage("assets/user.png"),
        ),
        title: Text(sName!.toString() ),
        subtitle: Text(sDesc.toString()),
      ),
    );
  }
}
