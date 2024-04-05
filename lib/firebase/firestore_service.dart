import 'package:basic/level_selection/levels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../player_progress/player_progress.dart';

class FirestoreService {
  Map<String, dynamic> level = {};

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

  Stream readLog() {
    return db.collection('log').snapshots();
  }

  void readLogDoc(BuildContext context, String docId, String game) {
    if (level.isEmpty) {
      for (var game in games) {
        level[game.game] = 0;
      }
    }
    db
        .collection('log')
        .doc(docId)
        .collection(game)
        .orderBy('level', descending: true)
        .limit(1)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          level[game] = docSnapshot.data()['level'];
        }
        final playerProgress = context.read<PlayerProgress>();
        playerProgress.setLevelProgress(
            level.values.toList().map((e) => e.toString()).toList());
        debugPrint(playerProgress.highestLevelReached.toString());
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}
