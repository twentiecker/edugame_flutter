import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  void addLogGame(String docId, String game, Map<String, dynamic> data) {
    db.collection('log').doc(docId).collection(game).add(data).then(
        (documentSnapshot) =>
            debugPrint("Added Data with ID: ${documentSnapshot.id}"));
  }

  void addLogDoc(String docId, Map<String, dynamic> data) {
    db.collection('log').doc(docId).set(data, SetOptions(merge: true)).onError(
        (error, stackTrace) => debugPrint("Error writing document: $error"));
  }

  Stream readLogDoc() {
    return db.collection('log').snapshots();
  }
}
