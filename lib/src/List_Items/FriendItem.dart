import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String sName;
  final int iAge;

  final Function(int index) onShortClick;
  final int index;

  const FriendItem(
      {Key? key,
      required this.sName,
      required this.iAge,
      required this.onShortClick,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(sName),
      subtitle: Text(iAge.toString()),
      tileColor: Colors.lightBlueAccent,
      onTap: () {
        onShortClick(index);
      },
      textColor: Colors.black,
    );
  }
}
