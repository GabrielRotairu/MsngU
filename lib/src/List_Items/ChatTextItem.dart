import 'package:flutter/material.dart';

class ChatTextItem extends StatelessWidget {
  final String sTexto;
  final Function(int Index) onShortClick;
  final int index;

  ChatTextItem({Key? key,
    this.sTexto = "HOLA :)",
    required this.onShortClick,
    required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      child: Column(children: <Widget>[

        Row(children: <Widget>[
          Container(
            child: Text(
              sTexto,
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(right: 5.0),

          ),
        ],mainAxisAlignment: MainAxisAlignment.end
        ),
      ],),
    );
  }




}
