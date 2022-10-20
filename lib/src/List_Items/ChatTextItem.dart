import 'package:flutter/material.dart';

class ChatTextItem extends StatelessWidget {
  final String sTexto;
  final Function(int Index) onShortClick;
  final int index;

  ChatTextItem(
      {Key? key,
        this.sTexto = "HOLA :)",
        required this.onShortClick,
        required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        height: 20,
        child: Center(child: Text(sTexto)),
      );
  }
/*

            ListTile(
      title: Text(sTexto),
      subtitle: Text('Secondary text'),
      leading: Icon(Icons.label),
      onTap: () {
        onShortClick(index);
      },
    );
 */

}
