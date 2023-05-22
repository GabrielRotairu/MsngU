import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future initialize() async {
    // Solicitar permisos para recibir notificaciones
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    );

    // Obtener el token de registro para el dispositivo
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Configurar el manejador de mensajes
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.body}');
    });
  }

  Future createCampaign(String title, String body) async {
    // Crear una nueva campaña en Cloud Firestore
    await _firestore.collection('campaigns').add({
      'title': title,
      'body': body,
    });
  }


}

class MyApp extends StatefulWidget {
  // ...

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

// ...
}







