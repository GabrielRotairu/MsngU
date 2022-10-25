import 'package:betamsngu/src/CustomViews/ChatView.dart';
import 'package:betamsngu/src/CustomViews/Friends_View.dart';
import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  int currentPageIndex = 0;
  ChatHomeView chats = ChatHomeView();
  Friends_View friends = Friends_View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(' Aquí vendrá tu usuario'),
            ),
            ListTile(
              title:  Text('Editar Perfil'),
              onTap: () {
                Navigator.of(context).pushNamed('/onBoarding');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.of(context).pushNamed('/LogIn');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlueAccent.shade400,
      appBar: AppBar(
        title: Text('Msng U'),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: Center(
        child: <Widget>[
          friends,
          Container(
            color: Colors.lightBlueAccent.shade400,
            alignment: Alignment.center,
            child: Text('Msng U'),
          ),
          chats,
        ][currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.person_rounded),
            icon: Icon(Icons.person_outline),
            label: 'Friends',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle),
            icon: Icon(Icons.add_circle_outline),
            label: 'MSNG U',
          ),
          NavigationDestination(
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
