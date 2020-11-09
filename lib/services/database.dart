import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userdataCollection =
      FirebaseFirestore.instance.collection("userdataCollection");

  Future updateUserData(String sugars, String name, int strength) async {
    return await userdataCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'] ?? "",
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? "0");
    }).toList();
  }

  //userdata from snapshot

  UserDataa _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataa(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength']);
  }

  //get userdatacollection stream
  Stream<List<Brew>> get usersDoc {
    return userdataCollection.snapshots().map(_brewListFromSnapshot);
  }

//get userdoc stream
  Stream<UserDataa> get userData {
    return userdataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
