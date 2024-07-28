import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/group_game.dart';
import '../game_widget/jigsaw_game.dart';
import '../game_widget/match_color_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

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
      'putih',
      'ungu'
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchColorGame();
        case 2:
          return CompletePatternGame(
            category: category,
            images: data,
            isColor: false,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan warna!',
            category: '$category/slices',
            images: data,
            isColor: true,
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
            title: 'Memilih warna!',
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
