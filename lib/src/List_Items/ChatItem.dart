import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String sTexto;
  final String sMensaje;
  final Function(int Index) onShortClick;
  final int index;
  final String aImage;

  ChatItem({
    Key? key,
    this.sTexto = "Title",
    this.sMensaje = "ultimo mensaje",
    this.aImage = "",
    required this.onShortClick,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.black12,
        child: ListTile(
          leading: Image(
            image: AssetImage(aImage),
          ),
          title: Text(sTexto),
          subtitle: Text(sMensaje),
          onTap: () {
            onShortClick(index);
          },
          textColor: Colors.black,
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
