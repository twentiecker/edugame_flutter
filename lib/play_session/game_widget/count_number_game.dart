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

class CountNumberGame extends StatefulWidget {
  const CountNumberGame({Key? key}) : super(key: key);

  @override
  State<CountNumberGame> createState() => _CountNumberGameState();
}

class _CountNumberGameState extends State<CountNumberGame> {
  final double height = 95.0;
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
  List<int> domain = [];
  List<int> codomain = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 1;
  int adj = 0;
  int randomId = 0;

  void initGame() {
    isTrue = List.generate(adjLevel, (index) => false);
    colors.shuffle();
    domain = List.generate(10, (index) => index + 1);
    domain.shuffle();
    codomain = List.generate(isTrue.length, (index) => domain[index]);
    codomain.shuffle();
    randomId = Random().nextInt(8);
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('id-ID');
    flutterTts.speak('Hitunglah benda yang ada di kotak!');
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
          ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: 250,
                      height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: GridView.count(
                        crossAxisCount: 5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        shrinkWrap: true,
                        children: List.generate(codomain[index], (_) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/images/group/${codomain[index]}.png',
                              color: codomain[index] > colors.length - 1
                                  ? colors[randomId].color
                                  : colors[codomain[index]].color,
                            ),
                          );
                        }),
                      ),
                    ),
                    DragTarget(builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: Colors.white,
                        ),
                        child: isTrue[index]
                            ? Center(
                                child: Text(
                                  '${codomain[index]}',
                                  style: TextStyle(
                                      fontFamily: 'Permanent Marker',
                                      fontSize: 50,
                                      height: 1,
                                      color: colors[index].color),
                                ),
                              )
                            : Text(''),
                      );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == '${codomain[index]}') {
                        flutterTts.speak('${details.data}');
                        // print(details.data);
                        setState(() {
                          isTrue[index] = true;
                        });
                        winGame();
                      }
                    })
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15);
              },
              itemCount: isTrue.length),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: height,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Draggable(
                      data: '${codomain[index]}',
                      feedback: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '${codomain[index]}',
                            style: TextStyle(
                                fontFamily: 'Permanent Marker',
                                fontSize: 50,
                                height: 1,
                                color: colors[index].color),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '${codomain[index]}',
                            style: TextStyle(
                                fontFamily: 'Permanent Marker',
                                fontSize: 50,
                                height: 1,
                                color: colors[index].color),
                          ),
                        ),
                      ),
                      child: Container(
                        height: height,
                        width: width,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '${codomain[index]}',
                            style: TextStyle(
                                fontFamily: 'Permanent Marker',
                                fontSize: 50,
                                height: 1,
                                color: colors[index].color),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 19);
                  },
                  itemCount: isTrue.length,
                ),
              ),
            ],
          ),
          Spacer(),
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
                                  if ((adjLevel + adj) > 4) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) > 4) {
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
                          if ((adjLevel + adj) > 4) {
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
