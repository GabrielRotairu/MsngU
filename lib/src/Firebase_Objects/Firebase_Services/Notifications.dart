import 'package:awesome_notifications/awesome_notifications.dart';

int createUID() {
  return DateTime.now().microsecondsSinceEpoch.remainder(100000);
}

Future<void> createPetitionNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUID(),
          channelKey: 'basic_channel',
          title: 'MSNG U!',
          body: 'Hey! Somebody wants to be your friend!',
      notificationLayout: NotificationLayout.Default));
}
