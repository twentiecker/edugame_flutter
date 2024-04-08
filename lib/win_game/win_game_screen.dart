// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/firebase/auth_service.dart';
import 'package:basic/firebase/firestore_service.dart';
import 'package:basic/level_selection/levels.dart';
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
    final FirestoreService firestoreService = FirestoreService();
    final AuthService authService = AuthService();

    const gap = SizedBox(height: 10);

    final docRef =
        firestoreService.db.collection("log").doc(authService.userEmail);
    docRef.get().then(
      (doc) {
        if (doc.data() == null) {
          debugPrint('Adding initial summary data');
          final Map<String, dynamic> docData = {};
          for (var game in games) {
            docData[game.game] = 0;
          }
          docData['score'] = 0;
          firestoreService.addLogDoc(authService.userEmail!, docData);
        }

        if (doc.data()?[games[index].game] == null) {
          debugPrint('Adding new summary data');
          final Map<String, dynamic> docData = {};
          docData[games[index].game] = 0;
          firestoreService.addLogDoc(authService.userEmail!, docData);
        }

        firestoreService.db
            .collection('log')
            .doc(authService.userEmail)
            .get()
            .then((value) {
          final Map<String, dynamic> docGameData = {
            games[index].game:
                score.score + int.parse('${value.data()?[games[index].game]}'),
          };
          firestoreService.addLogDoc(authService.userEmail!, docGameData);
          docRef.get().then((value) {
            int total = 0;
            for (var point in value.data()!.values.toList()) {
              total = total + int.parse('$point');
            }
            firestoreService.addLogDoc(authService.userEmail!, {
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
      authService.userEmail!,
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
