import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final Function(int index) onShortClick;
  final int index;

  const UserItem(
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
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text(""),
          ),
          ListTile(
            title: Text(
              sName+","+iAge.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            subtitle: Text(sDesc),

          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Text(""),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [

              ElevatedButton(onPressed: (){


              }, child: Text("Send Petition ")),
            ],
          )
        ],

      ),
      color: Colors.grey.shade100,
    );
  }
}
