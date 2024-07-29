import 'package:basic/play_session/game_widget/match_shape_game.dart';
import 'package:flutter/cupertino.dart';

import '../game_widget/complete_pattern_game.dart';
import '../game_widget/match_slice_game.dart';
import '../game_widget/match_sound_game.dart';
import '../game_widget/memory_game.dart';

class IslamicGame extends StatelessWidget {
  final int level;

  const IslamicGame({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String category = 'islamic';
    final data = [
      'syahadat',
      'solat',
      'zakat',
      'puasa',
      'haji',
    ];
    final hijaiyahSound = [
      '1alif',
      '2ba',
      '3ta',
      '4tsa',
      '5jim',
      '6kha',
      '7kho',
      '8dal',
      '9dzal',
      '10ro',
      '11zai',
      '12sin',
      '13syin',
      '14shod',
      '15dhod',
      '16tho',
      '17dha',
      '18ain',
      '19ghain',
      '20fa',
      '21qof',
      '22kaf',
      '23lam',
      '24mim',
      '25nun',
      '26wau',
      '27ha',
      '28lam alif',
      '29hamzah',
      '30ya'
    ];
    final List<String> hijaiyah = List.generate(30, (index) => '${index + 1}');
    return Builder(builder: (BuildContext context) {
      switch (level) {
        case 1:
          return MatchShapeGame(
            title: 'Mencocokkan huruf hijaiyah dengan bentuk bayangannya!',
            images: hijaiyah,
            category: '$category/hijaiyah',
            isColor: false,
            scale: 0.7,
            isHijaiyah: true,
            hijaiyahSound: hijaiyahSound,
          );
        case 2:
          return CompletePatternGame(
            title:
                'Pilihlah huruf hijaiyah yang sesuai dengan pola kumpulan huruf di sebelah kanan!',
            category: '$category/hijaiyah',
            images: hijaiyah,
            isColor: false,
            isHijaiyah: true,
            hijaiyahSound: hijaiyahSound,
          );
        case 3:
          return MatchSliceGame(
            title: 'Pasangkan dengan potongan gambar rukun islam yang sesuai!',
            category: '$category/slices',
            images: data,
            isSymmetric: false,
          );
        case 4:
          return MemoryGame(
            title: 'Mengingat pasangan huruf hijaiyah yang sama!',
            category: '$category/hijaiyah',
            images: hijaiyah,
            isHijaiyah: true,
            hijaiyahSound: hijaiyahSound,
          );
        case 5:
          return MatchSoundGame(
            title: 'Pilihlah huruf hijaiyah sesuai dengan petunjuk permainan!',
            category: '$category/hijaiyah',
            images: hijaiyah,
            isHijaiyah: true,
            hijaiyahSound: hijaiyahSound,
          );
        default:
          return Center(
            child: Text("Game isn't Available Now!"),
          );
      }
    });
  }
}
