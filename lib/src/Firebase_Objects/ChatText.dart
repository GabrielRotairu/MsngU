import 'package:cloud_firestore/cloud_firestore.dart';

class ChatText {
  late final String? text;
  late final Timestamp? time;
  late final String? author;
  final String? imgUrl;

  ChatText({
    this.text = "",
    this.time,
    this.author="",
    this.imgUrl="",

  });

  factory ChatText.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return ChatText(
      text: data?['text'],
      time: data?['time'],
      author: data?['author'],
      imgUrl: data?['imgUrl'],


    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (text != null) "text": text,
      if (time != null) "time": time,
      if (author != null) "author": author,
      if (imgUrl != null) "imgUrl": imgUrl,

    };
  }
}
