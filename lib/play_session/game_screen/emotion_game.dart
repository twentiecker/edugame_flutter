import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class EmotionGame extends StatelessWidget {
  final int level;

  const EmotionGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = [
      'bahagia',
      'bingung',
      'marah',
      'senyum',
      'takut',
      'terkejut'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: "Mencocokkan bentuk bayangan!",
            images: List.generate(data.length,
                (index) => 'assets/images/emotion/${data[index]}.png'),
            isColor: false,
            scale: 3.5,
          );
        case 2:
          return CompletePatternGame(
            images: List.generate(data.length,
                (index) => 'assets/images/emotion/${data[index]}.png'),
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan gambar!',
            images: List.generate(data.length,
                (index) => 'assets/images/emotion/slices/${data[index]}'),
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
            images: List.generate(data.length,
                (index) => 'assets/images/emotion/${data[index]}.png'),
          );
        case 7:
          return MatchSoundGame(
            title: 'Pilihlah gambar panca indera sesuai dengan intruksi!',
            category: 'emotion',
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
