import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? address;
  late final int? age;
  late final String? name;
  late final String? description;
  final List<String>? friends;
  final List<String>? petitions;
  final String uid;
  bool isChecked=false;

  Usuario({
    this.address = "",
    this.age = 0,
    this.name = "",
    this.uid = "",
    this.description = "",
    this.friends = const [],
    this.petitions= const[]
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usuario(
      address: data?["address"],
      age: data?['age'],
      name: data?['name'],
      description: data?['description'],
      friends: data?["friends"] is Iterable ? List.from(data?["friends"]) : null,
      petitions: data?["petitions"] is Iterable ? List.from(data?["petitions"]) : null,
      uid: data?["uid"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (address != null) "address": address,
      if (age != 0) "age": age,
      if (name != null) "name": name,
      if (description != null) "description": description,
      if(friends!.isNotEmpty) "friends" : friends,
      if(petitions!.isNotEmpty) "petitions" : petitions,
      if (uid != null) "uid": uid,
    };
  }
}
