import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/count_number_game.dart';
import '../game_widget/greater_number_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_shape_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';
import '../game_widget/spell_game.dart';

class NumberGame extends StatelessWidget {
  final int level;

  const NumberGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return CountNumberGame(level: level);
        case 2:
          return MemoryGame(
            images: List.generate(
                20, (index) => 'assets/images/number/${index + 1}.png'),
          );
        case 3:
          return MatchSoundGame(
            category: 'number',
            images: List.generate(10, (index) => '${index + 1}'),
          );
        case 4:
          return CompletePatternGame(
            images: List.generate(
                15, (index) => 'assets/images/shape2d/${index + 1}.png'),
          );
        case 5:
          return GreaterNumberGame();
        case 6:
          return JigsawGame(
            images: List.generate(
                12, (index) => 'assets/images/jigsaw/${index + 1}.png'),
          );
        case 7:
          return MatchSliceGame(
            images: List.generate(
                6, (index) => 'assets/images/slice/${index + 1}.png'),
          );
        case 8:
          return PuzzleGame(
            imageKey: 'n',
            imageNum: 10,
          );
        case 9:
          return SpellGame();
        case 10:
          return MatchShapeGame(
            level: level,
            images: List.generate(
                15, (index) => 'assets/images/shape2d/${index + 1}.png'),
          );
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
