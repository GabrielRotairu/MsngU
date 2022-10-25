import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? address;
  late final int? age;
  late final String? name;
  final String? email;
  final String? aImage;
  final List<String>? friends;
  final List<DocumentReference>? rooms;
  final String UID;

  Usuario(
      {this.address = "",
      this.age = 0,
      this.name = "",
      this.email = "",
        this.aImage="",
      this.friends = const [],
      this.rooms = const [],
      this.UID = ""
      });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      age: data?['age'],
      name: data?['name'],
      aImage: data?['aImage'],
      friends: data?['friends'] is Iterable ? List.from(data?['friends']) : null,
      rooms: data?['rooms'] is Iterable ? List.from(data?['rooms']) : null,
      UID: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (address != null) "address": address,
      if (age != 0) "age": age,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if(aImage!=null) "aImage":aImage,
      if (friends!.isNotEmpty) "friends": friends,
      if (rooms!.isNotEmpty) "rooms": rooms,
    };
  }
}
