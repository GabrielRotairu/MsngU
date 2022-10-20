import 'package:betamsngu/src/CustomViews/ChatView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade400,
      appBar: AppBar(
        title: Text('Msng U'),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: Center(
        child: <Widget>[
          Container(
            color: Colors.lightBlueAccent.shade400,
            alignment: Alignment.center,
            child: Text('Friends'),

          ),
          Container(
            color: Colors.lightBlueAccent.shade400,
            alignment: Alignment.center,
            child: Text('Msng U'),
          ),
          ChatView(),
        ]
        [currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations:  <Widget>[
          NavigationDestination(

            selectedIcon: Icon(Icons.person_rounded),
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle),
            icon: Icon(Icons.add_circle_outline),
            label: 'MSNG U',
          ),
          NavigationDestination (
            // Navigator.of(context).popAndPushNamed("/Chat"),
            selectedIcon: Icon(Icons.chat_bubble),
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chats',

          ),
        ],
      ),
    );
  }
}
