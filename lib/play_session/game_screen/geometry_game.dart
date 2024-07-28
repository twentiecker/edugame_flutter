import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/jigsaw_game.dart';
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
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: "Mencocokkan bentuk bayangan!",
            images: data,
            category: category,
            scale: 2.7,
          );
        case 2:
          return CompletePatternGame(
            images: data,
            category: category,
            isColor: true,
          );
        case 3:
          return MatchSliceGame(
            title: 'Mencocokkan potongan bentuk!',
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
            title: 'Memilih bentuk!',
            category: 'shape',
            images: data,
          );
        case 8:
          return WritingGame(
              title: 'Menggambar bentuk!',
              data: ['-', 'l', 'll', '+', '=', 'O', 'X']);
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
