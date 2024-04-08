import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class MatchSoundGame extends StatefulWidget {
  const MatchSoundGame({Key? key}) : super(key: key);

  @override
  State<MatchSoundGame> createState() => _MatchSoundGameState();
}

class _MatchSoundGameState extends State<MatchSoundGame> {
  final List<int> number = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<int> sounds = [];
  List<bool> isTrue = [];
  int sound = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    number.shuffle();
    final int num1 = number[Random().nextInt(2)];
    final int num2 = number[2 + Random().nextInt(2)];
    final int num3 = number[4 + Random().nextInt(3)];
    final int num4 = number[7 + Random().nextInt(3)];
    sounds.add(num1);
    sounds.add(num2);
    sounds.add(num3);
    sounds.add(num4);
    sounds.shuffle();
    sound = sounds[Random().nextInt(4)];
    for (var i = 0; i < sounds.length; i++) {
      isTrue.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      levelState.setProgress(100);
      context.read<AudioController>().playSfx(SfxType.wssh);
      levelState.evaluate();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: InkWell(
            onTap: () {
              debugPrint(sound.toString());
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.white,
              child: Icon(Icons.volume_up),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: sounds.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        if (sound == sounds[index]) {
                          setState(() {
                            isTrue[index] = !isTrue[index];
                          });

                          winGame();
                        }
                      },
                      child: isTrue[index]
                          ? Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    'assets/images/number/${sounds[index]}.png')
                                                .image)),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.greenAccent.withOpacity(0.8),
                                    child: Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 50,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: Image.asset(
                                              'assets/images/number/${sounds[index]}.png')
                                          .image)),
                            ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 40);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
