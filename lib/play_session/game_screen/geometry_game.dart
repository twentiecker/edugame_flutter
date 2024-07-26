import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/group_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class GeometryGame extends StatelessWidget {
  final int level;

  const GeometryGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
              images: List.generate(
                  15, (index) => 'assets/images/shape2d/${index + 1}.png'));
        case 2:
          return CompletePatternGame(
            images: List.generate(
                15, (index) => 'assets/images/shape2d/${index + 1}.png'),
            isColor: true,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan bentuk!',
            images: List.generate(
                10, (index) => 'assets/images/slice/${index + 1}c.png'),
            isColor: true,
          );
        case 4:
          return PuzzleGame(
            title: 'Menyusun 3 potongan bentuk!',
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
            images: List.generate(
                14, (index) => 'assets/images/memory/${index + 1}c.png'),
          );
        case 7:
          return MatchSoundGame(
            title: 'Memilih bentuk!',
            category: 'color',
            images: [
              'merah',
              'hijau',
              'biru',
              'jingga',
              'hitam',
              'putih',
              'kuning',
              'merah muda',
              'ungu',
              'coklat',
              'abu-abu',
            ],
          );
        case 8:
          return GroupGame(
            images: List.generate(
                16, (index) => 'assets/images/group/${index + 1}.png'),
          );
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
