import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final Function(int index) onShortClick;
  final int index;

  const FriendItem(
      {Key? key,
      required this.sName,
      required this.sDesc,
      required this.iAge,
      required this.onShortClick,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user.png'),
            radius: 80,
          ),
          ListTile(
            title: Text(
              sName,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            subtitle: Text(iAge.toString()),
          /*  onTap: () {
              onShortClick(index);
            },*/
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(sDesc,
                style: TextStyle(color: Colors.black.withOpacity(0.6))),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(shape: MaterialStatePropertyAll(StadiumBorder())),
                onPressed: () {


                },
                child:  Text('Agregar Amigo'),
              ),
            ],
          )
        ],
      ),
    );

    /*ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          "assets/user.png",
        ),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(sName),
      subtitle: Text(
        sDesc,
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
      onTap: () {
        onShortClick(index);
      },
    );*/
  }
}
