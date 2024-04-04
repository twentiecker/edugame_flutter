import 'package:basic/firebase/firestore_service.dart';
import 'package:basic/level_selection/levels.dart';
import 'package:basic/style/responsive_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 40),
            StreamBuilder(
                stream: firestoreService.readLogDoc(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<Map<String, dynamic>> leaderboard = [];
                  if (snapshot.hasData) {
                    snapshot.data.docs
                        .map(
                            (e) => leaderboard.add({e.id.toString(): e.data()}))
                        .toString();
                    leaderboard.sort((a, b) =>
                        int.parse('${b.values.toList()[0]['score']}').compareTo(
                            int.parse('${a.values.toList()[0]['score']}')));
                    return ListView.separated(
                      itemCount: leaderboard.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        int score() {
                          int point = 0;
                          for (var game in games) {
                            point += int.parse(
                                '${leaderboard[index].values.toList()[0][game.game]}');
                          }
                          return point;
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Player name',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  leaderboard[index].keys.toList()[0],
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Score',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  score().toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        );
                        // return Text(leaderboard[index].toString());
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 15);
                      },
                    );
                  }
                  return Container();
                }),
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}
