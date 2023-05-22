import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:betamsngu/App.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');


    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 2,
            channelKey: 'basic_channel',
            title: 'MSNG U!',
            body: 'Hey! Somebody wants to be your friend!',
            notificationLayout: NotificationLayout.Default));

  });

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print(settings);
  runApp(App());
}
