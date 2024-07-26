import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class GreaterNumberGame extends StatefulWidget {
  final String title;
  final bool isGreater;
  final List<String> images;

  const GreaterNumberGame({
    Key? key,
    required this.title,
    required this.isGreater,
    required this.images,
  }) : super(key: key);

  @override
  State<GreaterNumberGame> createState() => _GreaterNumberGameState();
}

class _GreaterNumberGameState extends State<GreaterNumberGame> {
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<int> numbers = [];
  List<String> images = [];
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

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 2;
  int adj = 0;

  void initGame() {
    numbers = [];
    widget.images.shuffle();
    isTrue = List.generate(adjLevel, (index) => false);
    while (numbers.length != isTrue.length) {
      var number = 1 + Random().nextInt(10);
      if (!numbers.contains(number)) {
        numbers.add(number);
      }
    }
    images = List.generate(adjLevel, (index) => widget.images[index]);
    colors.shuffle();
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
      if (isTrue.contains(true)) {
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
                itemBuilder: (context, index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        if (widget.isGreater
                            ? numbers[index] == numbers.reduce(max)
                            : numbers[index] == numbers.reduce(min)) {
                          setState(() {
                            isTrue[index] = true;
                          });
                          winGame();
                        }
                      },
                      child: Stack(children: [
                        Container(
                          width: 280,
                          height: 115,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: GridView.count(
                            crossAxisCount: 5,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            shrinkWrap: true,
                            children: List.generate(numbers[index], (i) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  images[index],
                                  color: colors[index].color,
                                  fit: BoxFit.contain,
                                ),
                              );
                            }),
                          ),
                        ),
                        isTrue[index]
                            ? Container(
                                width: 280,
                                height: 115,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreenAccent
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              )
                            : SizedBox(
                                width: 280,
                                height: 115,
                              )
                      ]),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemCount: isTrue.length),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: progress < levelState.goal && (isTrue.contains(true))
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
                                    adjLevel != 2) {
                                  adj = -1;
                                } else if ((levelState.prob >=
                                            levelState.sadThreshold &&
                                        levelState.prob <=
                                            levelState.happyThreshold) ||
                                    levelState.prob == 0) {
                                  adj = 1;
                                  if ((adjLevel + adj) > 6) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) > 6) {
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
                          if ((adjLevel + adj) > 6) {
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
