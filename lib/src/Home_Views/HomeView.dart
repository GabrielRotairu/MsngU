import 'package:betamsngu/src/CustomViews/MsngU_View.dart';
import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:betamsngu/src/Home_Views/UsersHome_View.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  //Establecemos cada página que vamos a mostrar en nuestra pantalla principal
  int currentPageIndex = 1;
  ChatHomeView chats = ChatHomeView();
  MsngU_View home = MsngU_View();
  UsersHome_View users = UsersHome_View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DrawerHeader(
              //Información sobre nuestro usuario.
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("assets/user1.png")),
                color: Colors.black12,
              ),
              child: Text(""),
            ),
            ListTile(
              title: Text(DataHolder().usuario.name.toString()),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: DataHolder().platformAdmin.dSCREEN_HEIGHT + 45)),
            ListTile(
              //En este apartado vamos a poder editar la información del perfil
              title: Text('Editar Perfil'),
              onTap: () {
                // Navigator.of(context).pushNamed('/onBoarding');
              },
            ),
            ListTile(
              //En esta nos permitirá cerrar la sesión del usuario
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
        centerTitle: true,
        elevation: double.minPositive,

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
        //Vamos a darle valores a cada apartado de nuestro menú de desplazamiento.
        destinations: const <Widget>[
          //Este apartado nos va a llevar a los usuarios que tenga nuestra base de datos
          NavigationDestination(
            selectedIcon: Icon(Icons.group_rounded),
            icon: Icon(Icons.group_outlined),
            label: 'Users',
          ),
          //Este apartado nos va a llevar a la función especial de nuestra app
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle),
            icon: Icon(Icons.add_circle_outline),
            label: 'MSNG U',
          ),
          //Este apartado nos va a llevar a los chats de nuestro Usuario Loggeado
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
