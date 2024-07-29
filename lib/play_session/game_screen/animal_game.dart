import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class AnimalGame extends StatelessWidget {
  final int level;

  const AnimalGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'animal';
    final data = [
      'anjing',
      'badak',
      'banteng',
      'buaya',
      'burung hantu',
      'burung pelikan',
      'burung unta',
      'gajah',
      'harimau',
      'jerapah',
      'katak',
      'koala',
      'kucing',
      'kuda',
      'lebah',
      'panda',
      'rusa',
      'sigung',
      'tikus',
      'ulat',
      'unta'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan hewan dengan bentuk bayangannya!',
            images: data,
            category: category,
            isColor: false,
            scale: 2.2,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah hewan yang sesuai dengan pola kumpulan hewan di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan hewan yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return PuzzleGame(
            title: 'Menyusun 3 potongan gambar mainan!',
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
            title: 'Mengingat pasangan hewan yang sama!',
            category: category,
            images: data,
          );
        case 7:
          return MatchSoundGame(
            title: 'Pilihlah hewan sesuai dengan petunjuk permainan!',
            category: 'animal',
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
