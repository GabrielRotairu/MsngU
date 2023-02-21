import 'package:flutter/material.dart';

class PetitionItem extends StatelessWidget {
  final String sName;
  final String sDesc;
  final int iAge;
  final Function(int index) onShortClick;
  final int index;

  const PetitionItem(
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
              sName+", "+iAge.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            subtitle: Text(sDesc.toString()),
            /*  onTap: () {
              onShortClick(index);
            },*/
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(""),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(onPressed: (){


              }, child: Text("Accept "),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green),shape: MaterialStatePropertyAll(StadiumBorder()))),
              ElevatedButton(onPressed: (){


              }, child: Text("Deny "),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red),shape: MaterialStatePropertyAll(StadiumBorder())),)
    ],
          )
        ],
      ),
    );
  }
}
