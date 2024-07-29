import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';
import '../game_widget/puzzle_game.dart';
import '../game_widget/writing_game.dart';

class GeometryGame extends StatelessWidget {
  final int level;

  const GeometryGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'shape';
    final data = [
      'belah ketupat',
      'berlian',
      'bintang',
      'bulan sabit',
      'hati',
      'lingkaran',
      'oval',
      'persegi panjang',
      'persegi',
      'segienam',
      'segilima',
      'segitiga',
      'tanda panah',
      'tanda tambah'
    ];
    final shapes = ['-', 'l', 'll', '+', '=', 'O', 'X'];
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan bentuk dan bayangannya!',
            images: data,
            category: category,
            scale: 2.7,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah bentuk yang sesuai dengan pola kumpulan bentuk di sebelah kanan!',
            images: data,
            category: category,
            isColor: true,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan bentuk yang sesuai!',
            category: '$category/slices',
            images: data,
            // isColor: true,
            isSymmetric: false,
          );
        case 4:
          return PuzzleGame(
            title: 'Menyusun 3 potongan gambar mainan!',
            imageKey: 'c',
            imageNum: 7,
          );
        case 5:
          return MemoryGame(
            title: 'Mengingat pasangan bentuk yang sama!',
            category: category,
            images: data,
          );
        case 6:
          return MatchSoundGame(
            title: 'Pilihlah bentuk sesuai dengan petunjuk permainan!',
            category: 'shape',
            images: data,
          );
        case 7:
          return WritingGame(
            title: 'Gambarlah bentuk sesuai dengan petunjuk permainan!',
            data: shapes,
            isShape: true,
          );
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
