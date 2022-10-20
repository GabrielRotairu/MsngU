import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String uid;
  late final String? userName;



  Chat({
    this.uid="",
    this.userName = "",


  });

  factory Chat.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Chat(
      uid: snapshot.id,
      userName: data?['userName'],



    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if(uid!=null) uid :uid,
      if (userName != null) "userName": userName,



    };
  }
}
