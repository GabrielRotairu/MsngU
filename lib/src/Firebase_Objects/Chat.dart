import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String uid;
  late final String? chatname;
  final List<String>? members;



  Chat({
    this.uid="",
    this.chatname = "",
this.members= const []

  });

  factory Chat.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Chat(
      uid: snapshot.id,
      chatname: data?['chatname'],
members: data?['members'] is Iterable ? List.from(data?['members']) : null,


    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if(uid!=null) uid :uid,
      if (chatname != null) "chatname": chatname,
if (members!.isNotEmpty) "members": members,


    };
  }
}
