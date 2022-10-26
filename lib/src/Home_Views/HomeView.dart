import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:betamsngu/src/Home_Views/FriendsHome_View.dart';
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
FriendsHome_View friends= FriendsHome_View();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DrawerHeader(

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("assets/user1.png")),
              ),
              child: Text(""),
            ),
            ListTile(title: Text("Aquí vendrá tu nombre"),),

            ListTile(
              title: Text('Editar Perfil'),
              onTap: () {
               // Navigator.of(context).pushNamed('/onBoarding');
              },

            ),
            ListTile(
              title: Text('Cerrar Sesión',style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/LogIn');
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
