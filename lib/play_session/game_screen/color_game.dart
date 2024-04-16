import 'package:basic/play_session/game_widget/match_color_game.dart';
import 'package:flutter/cupertino.dart';

class ColorGame extends StatelessWidget {
  final int level;

  const ColorGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        default:
          return MatchColorGame(level: level);
      }
    });
  }
}
