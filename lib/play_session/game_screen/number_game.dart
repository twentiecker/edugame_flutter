import 'package:basic/play_session/game_widget/writing_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/count_number_game.dart';
import '../game_widget/greater_number_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class NumberGame extends StatelessWidget {
  final int level;

  const NumberGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return CountNumberGame();
        case 2:
          return MemoryGame(
            images: List.generate(
                20, (index) => 'assets/images/number/${index + 1}.png'),
          );
        case 3:
          return MatchSoundGame(
            title: 'Memilih angka!',
            category: 'number',
            images: List.generate(10, (index) => '${index + 1}'),
          );
        case 4:
          return CompletePatternGame(
            images: List.generate(
                20, (index) => 'assets/images/number/${index + 1}.png'),
            isColor: false,
          );
        case 5:
          return GreaterNumberGame(
            title: 'Manakah yang paling banyak?',
            isGreater: true,
            images: List.generate(
                16, (index) => 'assets/images/group/${index + 1}.png'),
          );
        case 6:
          return GreaterNumberGame(
            title: 'Manakah yang paling sedikit?',
            isGreater: false,
            images: List.generate(
                16, (index) => 'assets/images/group/${index + 1}.png'),
          );
        case 7:
          return JigsawGame(
            images: List.generate(
                12, (index) => 'assets/images/jigsaw/${index + 1}.png'),
          );
        case 8:
          return MatchSliceGame(
            title: 'Mencocokkan potongan angka!',
            images: List.generate(
                15, (index) => 'assets/images/number/slices/${index + 1}'),
            isSymmetric: false,
          );
        case 9:
          return PuzzleGame(
            title: 'Menyusun 3 potongan angka!',
            imageKey: 'n',
            imageNum: 10,
          );
        case 10:
          return WritingGame(
              title: 'Menulis angka!',
              data: List.generate(10, (index) => '${index + 1}'));
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
