import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

class EmotionGame extends StatelessWidget {
  final int level;

  const EmotionGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'emotion';
    final data = ['bahagia', 'bingung', 'marah', 'senyum', 'takut', 'terkejut'];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan bentuk emosi dengan bentuk bayangannya!',
            images: data,
            category: 'emotion',
            isColor: false,
            scale: 3.5,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah emosi yang sesuai dengan pola kumpulan emosi di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan gambar emosi yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return MemoryGame(
            title: 'Mengingat pasangan gambar emosi yang sama!',
            category: category,
            images: data,
          );
        case 5:
          return MatchSoundGame(
            title: 'Pilihlah gambar emosi sesuai dengan petunjuk permainan!',
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
