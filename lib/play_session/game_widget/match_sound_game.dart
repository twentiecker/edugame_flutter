import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/game_data.dart';
import '../../style/my_button.dart';

class MatchSoundGame extends StatefulWidget {
  final String title;
  final String category;
  final List<String> images;
  final List<String> hijaiyahSound;
  final bool isHijaiyah;

  const MatchSoundGame({
    Key? key,
    required this.title,
    required this.category,
    required this.images,
    this.hijaiyahSound = const [],
    this.isHijaiyah = false,
  }) : super(key: key);

  @override
  State<MatchSoundGame> createState() => _MatchSoundGameState();
}

class _MatchSoundGameState extends State<MatchSoundGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;
  final FlutterTts flutterTts = FlutterTts();

  List<GameData> gameData = [];
  List<String> hijaiyahSounds = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 1;
  int adj = 0;

  void initGame() {
    if (widget.isHijaiyah) {
      hijaiyahSounds =
          List.generate(30, (index) => widget.hijaiyahSound[index]);
    }
    gameData = List.generate(adjLevel, (i) {
      widget.images.shuffle();
      return GameData(
        isTrue: List.generate(4, (j) => false),
        sounds: List.generate(4, (j) => widget.images[j]),
        sound: widget.images[Random().nextInt(4)],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('id-ID');
    flutterTts.speak(widget.title);
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (gameData.every((element) => element.isTrue.contains(true))) {
        progress = levelState.progress + levelState.goal ~/ subLevel;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 64.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          debugPrint(gameData[i].sound);
                          widget.isHijaiyah
                              ? FlameAudio.play(
                                  '${hijaiyahSounds[int.parse(gameData[i].sound) - 1]}.aac')
                              : flutterTts.speak(gameData[i].sound);
                        },
                        child: Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.volume_up,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                          width: double.infinity,
                          height: height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: gameData[i].sounds.length,
                                itemBuilder: (context, index) {
                                  return gameData[i].isTrue[index] == true
                                      ? Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: height,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            radius),
                                                    image: DecorationImage(
                                                        image: Image.asset(
                                                                'assets/images/${widget.category}/${gameData[i].sounds[index]}.png')
                                                            .image)),
                                              ),
                                              Container(
                                                height: height,
                                                width: width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          radius),
                                                  color: Colors.greenAccent
                                                      .withOpacity(0.8),
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .check_circle_outline_rounded,
                                                  size: 35,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            if (gameData[i].sound ==
                                                gameData[i].sounds[index]) {
                                              setState(() {
                                                gameData[i].isTrue[index] =
                                                    true;
                                              });
                                              winGame();
                                            }
                                          },
                                          child: Container(
                                            height: height,
                                            width: width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radius),
                                                image: DecorationImage(
                                                    image: Image.asset(
                                                            'assets/images/${widget.category}/${gameData[i].sounds[index]}.png')
                                                        .image)),
                                          ),
                                        );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 20);
                                },
                              ),
                            ],
                          )),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 50);
                },
                itemCount: gameData.length),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    gameData.every((element) => element.isTrue.contains(true))
                ? levelState.isDda
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            FaceDetectorView(),
                            MyButton(
                              onPressed: () {
                                if ((levelState.prob > 0 &&
                                        levelState.prob <
                                            levelState.sadThreshold) &&
                                    adjLevel != 1) {
                                  adj = -1;
                                } else if ((levelState.prob >=
                                            levelState.sadThreshold &&
                                        levelState.prob <=
                                            levelState.happyThreshold) ||
                                    levelState.prob == 0) {
                                  adj = 1;
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                } else {
                                  adj = 0;
                                }
                                setState(() {
                                  adjLevel += adj;
                                  initGame();
                                });
                              },
                              child: const Text('Next'),
                            ),
                          ]),
                        ],
                      )
                    : MyButton(
                        onPressed: () {
                          adj = 1;
                          setState(() {
                            adjLevel += adj;
                            initGame();
                          });
                        },
                        child: const Text('Next'),
                      )
                : Container(),
          )
        ],
      ),
    );
  }
}
