import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

class ProfessionGame extends StatelessWidget {
  final int level;

  const ProfessionGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'profession';
    final data = [
      'atlet',
      'badut',
      'dokter',
      'guru',
      'koki',
      'pelukis',
      'petani',
      'polisi',
      'reporter'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan profesi dengan bentuk bayangannya!',
            images: data,
            category: category,
            isColor: false,
            scale: 2,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah profesi yang sesuai dengan pola kumpulan profesi di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan profesi yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return MemoryGame(
            title: 'Mengingat pasangan profesi yang sama!',
            category: category,
            images: data,
          );
        case 5:
          return MatchSoundGame(
            title: 'Pilihlah profesi sesuai dengan petunjuk permainan!',
            category: 'profession',
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
