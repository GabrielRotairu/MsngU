import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:betamsngu/src/CustomViews/MsngU_View.dart';
import 'package:betamsngu/src/Firebase_Objects/Firebase_Services/Notifications.dart';
import 'package:betamsngu/src/Home_Views/ChatHome_View.dart';
import 'package:betamsngu/src/Home_Views/UsersHome_View.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeView();
  }
}

class _HomeView extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
          if (!isAllowed)
            {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Allow Notifications'),
                  content: Text('MSNG U! would like to show you Notifications'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Do not Allow')),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((value) => Navigator.pop(context));
                          Navigator.pop(context);
                        },
                        child: Text('Allow'))
                  ],
                ),
              )
            }
        });
  }

  //Establecemos cada página que vamos a mostrar en nuestra pantalla principal
  int currentPageIndex = 1;
  ChatHomeView chats = ChatHomeView();
  MsngU_View home = MsngU_View();
  UsersHome_View users = UsersHome_View();

  void OnTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            FluttermojiCircleAvatar(),
            ListTile(
              title: Text(DataHolder().usuario.name.toString()),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: DataHolder().platformAdmin.dSCREEN_HEIGHT + 5)),
            ListTile(
              //En este apartado vamos a poder editar la información del perfil
              title: Text('Editar Perfil'),
              onTap: () {
                 Navigator.of(context).pushNamed('/Avatar');
                createPetitionNotification();
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
      bottomNavigationBar: SnakeNavigationBar.color(
         backgroundColor: Colors.grey.shade200  ,
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          shape: StadiumBorder(),
          padding: EdgeInsets.all(10),
          snakeViewColor: Colors.lightBlueAccent.shade700,
          selectedItemColor: SnakeShape.circle == SnakeShape.indicator
              ? Colors.lightBlueAccent.shade700
              : null,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: currentPageIndex,
          onTap: (index) => setState(() => currentPageIndex = index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: "Users",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: "MSNG U",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: "Chats",
            ),
          ]),
    );
  }
}
