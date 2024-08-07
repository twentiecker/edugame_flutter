import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

class FruitGame extends StatelessWidget {
  final int level;

  const FruitGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'fruit';
    final data = [
      'alpukat',
      'anggur hijau',
      'apel hijau',
      'apel merah',
      'jeruk nipis',
      'jeruk',
      'kelapa',
      'kiwi',
      'lemon',
      'mangga',
      'nanas',
      'pir',
      'pisang',
      'semangka',
      'strawberi'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan buah dengan bentuk bayangannya!',
            images: data,
            category: category,
            isColor: false,
            scale: 1.6,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah buah yang sesuai dengan pola kumpulan buah di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan buah yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return MemoryGame(
            title: 'Mengingat pasangan buah yang sama!',
            category: category,
            images: data,
          );
        case 5:
          return MatchSoundGame(
            title: 'Pilihlah buah sesuai dengan petunjuk permainan!',
            category: 'fruit',
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
