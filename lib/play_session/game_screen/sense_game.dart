import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class SenseGame extends StatelessWidget {
  final int level;

  const SenseGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'sense';
    final data = [
      'telinga',
      'hidung',
      'mata',
      'lidah',
      'kulit',
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: "Mencocokkan bentuk bayangan!",
            images: data,
            category: category,
            isColor: false,
            scale: 1.3,
          );
        case 2:
          return CompletePatternGame(
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan gambar!',
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
            title: 'Pilihlah gambar panca indera sesuai dengan intruksi!',
            category: 'sense',
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
