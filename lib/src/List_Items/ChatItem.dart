import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String sTexto;
  final String sMensaje;
  final Function(int Index) onShortClick;
  final int index;

  ChatItem({
    Key? key,
    this.sTexto = "Title",
    this.sMensaje="ultimo mensaje",
    required this.onShortClick,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.lightBlue.shade600,
        child: ListTile(
          title: Text(sTexto),
          subtitle: Text(sMensaje),
          leading: Icon(Icons.chat_bubble),
          onTap: () {
            onShortClick(index);
          },
          textColor: Colors.white,
        ));
  }
/*

              Container(
                height: 50,
                color: Colors.green[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );

 */

}
