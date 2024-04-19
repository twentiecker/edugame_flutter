import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_color_game.dart';
import '../game_widget/match_shape_game.dart';

class ColorGame extends StatelessWidget {
  final int level;

  const ColorGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchColorGame(
            level: level,
          );
        case 2:
          return MatchShapeGame(
            level: level,
          );
        case 3:
          return CompletePatternGame(
            level: level,
          );
        case 4:
          return CompletePatternGame(
            level: level,
          );
        default:
          return MatchColorGame(
            level: level,
          );
      }
    });
  }
}
