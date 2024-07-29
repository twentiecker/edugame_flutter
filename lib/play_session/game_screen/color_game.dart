import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/group_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_color_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

class ColorGame extends StatelessWidget {
  final int level;

  const ColorGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'color';
    final data = [
      'abu-abu',
      'biru',
      'coklat',
      'hijau',
      'hitam',
      'jingga',
      'kuning',
      'merah muda',
      'merah',
      'ungu'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchColorGame();
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah warna yang sesuai dengan pola kumpulan warna di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan warna yang sesuai!',
            category: '$category/slices',
            images: data,
            // isColor: true,
            isSymmetric: false,
          );
        case 4:
          return JigsawGame(
            images: List.generate(
                12, (index) => 'assets/images/jigsaw/${index + 1}c.png'),
          );
        case 5:
          return MemoryGame(
            title: 'Mengingat pasangan warna yang sama!',
            category: category,
            images: data,
          );
        case 6:
          return MatchSoundGame(
            title: 'Pilihlah warna sesuai dengan petunjuk permainan!',
            category: 'color',
            images: data,
          );
        case 7:
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
