import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String sTitulo;
  final Function(int Index) onShortClick;
  final int index;

  ChatItem({
    Key? key,
    this.sTitulo = "Title",
    required this.onShortClick,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(sTitulo),
      subtitle: Text(':)'),
      leading: Icon(Icons.chat_bubble),
      onTap: () {
        onShortClick(index);
      },
    );
  }
/*

              Container(
                height: 50,
                color: Colors.green[colorCodes[index]],
                child: Center(child: Text('Entry ${entries[index]}')),
              );

 */

}
