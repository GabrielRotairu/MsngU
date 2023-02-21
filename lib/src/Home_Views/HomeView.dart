import 'package:betamsngu/src/CustomViews/MsngU_View.dart';
import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:betamsngu/src/Home_Views/UsersHome_View.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  int currentPageIndex = 1;
  ChatHomeView chats = ChatHomeView();
  MsngU_View home= MsngU_View();
  UsersHome_View users= UsersHome_View();

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
            ListTile(title: Text(DataHolder().usuario.name.toString()),),
            Padding(
                padding: EdgeInsets.only(
                    top: DataHolder().platformAdmin.dSCREEN_HEIGHT + 45)),
            ListTile(
              title: Text('Editar Perfil'),
              onTap: () {
                // Navigator.of(context).pushNamed('/onBoarding');
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/LogIn');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Msng U'),
        backgroundColor: Colors.lightBlueAccent.shade700,
      ),
      body: Center(
        child: <Widget>[
          users,

          home,
          chats,
        ][currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.lightBlue.shade700,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.group_rounded),
            icon: Icon(Icons.group_outlined),
            label: 'Users',
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
