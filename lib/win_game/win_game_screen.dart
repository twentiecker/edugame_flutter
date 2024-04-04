// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/firebase/firestore_service.dart';
import 'package:basic/level_selection/levels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../game_internals/score.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;
  final int index;

  const WinGameScreen({
    super.key,
    required this.score,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final userEmail = FirebaseAuth.instance.currentUser!.email!;
    final FirestoreService firestoreService = FirestoreService();

    const gap = SizedBox(height: 10);

    final docRef = firestoreService.db.collection("log").doc(userEmail);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.data() == null) {
          final Map<String, dynamic> docData = {};
          for (var game in games) {
            docData[game.game] = 0;
          }
          docData['score'] = 0;
          firestoreService.addLogDoc(userEmail, docData);
        }

        firestoreService.db
            .collection('log')
            .doc(userEmail)
            .get()
            .then((value) {
          final Map<String, dynamic> docGameData = {
            games[index].game:
                score.score + int.parse('${value.data()?[games[index].game]}'),
          };
          firestoreService.addLogDoc(userEmail, docGameData);
          docRef.get().then((value) {
            int total = 0;
            for (var point in value.data()!.values.toList()) {
              total = total + int.parse('$point');
            }
            firestoreService.addLogDoc(userEmail, {
              'score': total - int.parse(value.data()!['score'].toString())
            });
          });
        });
      },
      onError: (e) => debugPrint("Error getting document: $e"),
    );

    final Map<String, dynamic> gameData = {
      'level': score.level,
      'score': score.score,
      'time': score.formattedTime,
    };
    firestoreService.addLogGame(
      userEmail,
      games[index].game,
      gameData,
    );

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gap,
            const Center(
              child: Text(
                'You won!',
                style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50),
              ),
            ),
            gap,
            Center(
              child: Text(
                'Score: ${score.score}\n'
                'Time: ${score.formattedTime}',
                style: const TextStyle(
                    fontFamily: 'Permanent Marker', fontSize: 20),
              ),
            ),
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/play/$index');
          },
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
