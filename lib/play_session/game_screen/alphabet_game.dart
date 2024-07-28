import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class AlphabetGame extends StatelessWidget {
  final int level;

  const AlphabetGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'alphabet';
    final data = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: "Mencocokkan bentuk bayangan alfabet!",
            images: data,
            category: category,
            isColor: false,
            scale: 2,
          );
        case 2:
          return CompletePatternGame(
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan gambar profesi!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return PuzzleGame(
            title: 'Menyusun 3 potongan gambar!',
            imageKey: 'c',
            imageNum: 7,
          );
        case 5:
          return JigsawGame(
            images: List.generate(
                12, (index) => 'assets/images/jigsaw/${index + 1}c.png'),
          );
        case 6:
          return MemoryGame(
            category: category,
            images: data,
          );
        case 7:
          return MatchSoundGame(
            title: 'Memilih profesi!',
            category: 'alphabet',
            images: data,
          );
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
