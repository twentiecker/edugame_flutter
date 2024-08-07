import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

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
            title: 'Mencocokkan panca indera dengan bentuk bayangannya!',
            images: data,
            category: category,
            isColor: false,
            scale: 1.3,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah panca indera yang sesuai dengan pola kumpulan panca indera di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan panca indera yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return MemoryGame(
            title: 'Mengingat pasangan panca indera yang sama!',
            category: category,
            images: data,
          );
        case 5:
          return MatchSoundGame(
            title: 'Pilihlah panca indera sesuai dengan petunjuk permainan!',
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
