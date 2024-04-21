import 'package:basic/play_session/game_widget/count_number_game.dart';
import 'package:flutter/cupertino.dart';

class NumberGame extends StatelessWidget {
  final int level;

  const NumberGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        default:
          return CountNumberGame(
            level: level,
          );
      }
    });
  }
}
