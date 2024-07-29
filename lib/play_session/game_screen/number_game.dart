import 'package:basic/play_session/game_widget/writing_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/count_number_game.dart';
import '../game_widget/greater_number_game.dart';
import '../game_widget/match_shape_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';

class NumberGame extends StatelessWidget {
  final int level;

  const NumberGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'numbers';
    final data = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
    ];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan angka dengan bentuk bayangannya!',
            images: data,
            category: category,
            isColor: false,
            scale: 2.7,
          );
        case 2:
          return CountNumberGame();
        case 3:
          return MemoryGame(
            title: 'Mengingat pasangan angka yang sama!',
            category: category,
            images: data,
          );
        case 4:
          return MatchSoundGame(
            title: 'Pilihlah angka sesuai dengan petunjuk permainan!',
            category: 'number',
            images: List.generate(11, (index) => '$index'),
          );
        case 5:
          return CompletePatternGame(
            title:
                'Pilihlah angka yang sesuai dengan pola kumpulan angka di sebelah kanan!',
            category: category,
            images: data,
            isColor: false,
          );
        case 6:
          return GreaterNumberGame(
            title: 'Manakah kotak yang meimiliki jumlah paling banyak?',
            isGreater: true,
            images: List.generate(
                16, (index) => 'assets/images/group/${index + 1}.png'),
          );
        case 7:
          return GreaterNumberGame(
            title: 'Manakah kotak yang meimiliki jumlah paling sedikit?',
            isGreater: false,
            images: List.generate(
                16, (index) => 'assets/images/group/${index + 1}.png'),
          );
        case 8:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan angka yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 9:
          return PuzzleGame(
            title: 'Menyusun 3 potongan gambar angka!',
            imageKey: 'n',
            imageNum: 10,
          );
        case 10:
          return WritingGame(
              title: 'Tulislah angka sesuai dengan petunjuk permainan!',
              data: List.generate(11, (index) => '$index'));
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
