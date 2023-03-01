import 'package:betamsngu/src/Firebase_Objects/Chat.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:flutter/material.dart';

class ChatFriendItem extends StatefulWidget {
  final int index;
  final Usuario usuario;
  //final Chat chat;

  const ChatFriendItem({Key? key,

    required this.index, required this.usuario,})
      : super(key: key);

  @override
  State<ChatFriendItem> createState() => _ChatFriendItemState();
}

class _ChatFriendItemState extends State<ChatFriendItem> {
  bool? isChecked= false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //bool enabled;
    return Container(
      child:Column(children: [
      CheckboxListTile(
        title: Text(widget.usuario.name!.toString()),
        subtitle: Text(widget.usuario.description.toString()),
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value;
            widget.usuario.isChecked=value!;
          });
        },
        selectedTileColor: Colors.lightBlueAccent,
        checkboxShape: CircleBorder(side: BorderSide()),
      ),
      ]
    ),);
  }
}
