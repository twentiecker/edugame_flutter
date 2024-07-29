import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class CompletePatternGame extends StatefulWidget {
  final String title;
  final List<String> images;
  final String category;
  final bool isColor;
  final List<String> hijaiyahSound;
  final bool isHijaiyah;

  const CompletePatternGame({
    Key? key,
    required this.title,
    required this.images,
    required this.category,
    required this.isColor,
    this.hijaiyahSound = const [],
    this.isHijaiyah = false,
  }) : super(key: key);

  @override
  State<CompletePatternGame> createState() => _CompletePatternGameState();
}

class _CompletePatternGameState extends State<CompletePatternGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<BaseColor> colors = [
    BaseColor(name: 'merah', color: Colors.red),
    BaseColor(name: 'merah muda', color: Colors.pink),
    BaseColor(name: 'ungu', color: Colors.purple),
    BaseColor(name: 'biru', color: Colors.blue),
    BaseColor(name: 'hijau', color: Colors.green),
    BaseColor(name: 'kuning', color: Colors.yellow),
    BaseColor(name: 'jingga', color: Colors.orange),
    BaseColor(name: 'coklat', color: Colors.brown)
  ];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];
  List<String> hijaiyahSounds = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 2;
  int adj = 0;

  late int difficulty;

  void initGame() {
    adjLevel > 4 && widget.images.length >= 6 ? difficulty = 6 : difficulty = 4;
    if (widget.isHijaiyah) {
      hijaiyahSounds =
          List.generate(30, (index) => widget.hijaiyahSound[index]);
    }
    widget.images.shuffle();
    isTrue = List.generate(difficulty, (index) => true);
    isTrue[Random().nextInt(isTrue.length)] = false;
    if (difficulty == 6) {
      final int baseIndex = isTrue.indexWhere((element) => element == false);
      for (var i = 0; i < isTrue.length; i++) {
        if (i == baseIndex - 3 || i == baseIndex + 3) continue;
        isTrue[i] = isTrue[i] ? false : isTrue[i];
        if (isTrue.where((element) => element == false).length == 2) break;
      }
    }
    colors.shuffle();
    domain = List.generate(
        isTrue.length,
        (index) => {
              'data': '$index',
              'shape': widget.images[index],
            });
    domain.shuffle();
    codomain = List.generate(
        domain.length, (index) => domain[index % (difficulty ~/ 2)]);
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
      if (isTrue.every((element) => element == true)) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Draggable(
                              data: {
                                'data': domain[index]['data'],
                                'shape': domain[index]['shape']
                              },
                              feedback: Container(
                                height: height,
                                width: width,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: widget.isColor
                                    ? Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        color: colors[int.parse(
                                                domain[index]['data']!)]
                                            .color,
                                      )
                                    : Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                      ),
                              ),
                              childWhenDragging: SizedBox(
                                height: height,
                                width: width,
                              ),
                              child: Container(
                                height: height,
                                width: width,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: widget.isColor
                                    ? Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                        color: colors[int.parse(
                                                domain[index]['data']!)]
                                            .color,
                                      )
                                    : Image.asset(
                                        'assets/images/${widget.category}/${domain[index]['shape']!}.png',
                                      ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: isTrue.length),
                    ],
                  ),
                ),
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return DragTarget(builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return Container(
                                height: height,
                                width: width,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: isTrue[index]
                                    ? widget.isColor
                                        ? Image.asset(
                                            'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                            color: colors[int.parse(
                                                    codomain[index]['data']!)]
                                                .color,
                                          )
                                        : Image.asset(
                                            'assets/images/${widget.category}/${codomain[index]['shape']!}.png',
                                          )
                                    : Text(''),
                              );
                            }, onAcceptWithDetails:
                                (DragTargetDetails details) {
                              if (details.data['data'] ==
                                  codomain[index]['data']) {
                                widget.isHijaiyah
                                    ? FlameAudio.play(
                                        '${hijaiyahSounds[int.parse('${details.data['shape']}') - 1]}.aac')
                                    : flutterTts
                                        .speak('${details.data['shape']}');
                                setState(() {
                                  isTrue[index] = true;
                                });
                                winGame();
                              }
                            });
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: isTrue.length)
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal &&
                    isTrue.every((element) => element == true)
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
                                  if ((adjLevel + adj) >= colors.length) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) >= colors.length) {
                                    adj = 1;
                                  }
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
                          if ((adjLevel + adj) >= colors.length) {
                            adj = 0;
                          }
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
