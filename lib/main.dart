import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:betamsngu/App.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resources://drawable/logo_app', [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'MSNG U Notifications',
      channelDescription: '',
      defaultColor: Colors.blueAccent,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    )
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}
