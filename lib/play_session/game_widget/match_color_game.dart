import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class MatchColorGame extends StatefulWidget {
  const MatchColorGame({Key? key}) : super(key: key);

  @override
  State<MatchColorGame> createState() => _MatchColorGameState();
}

class _MatchColorGameState extends State<MatchColorGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;
  final FlutterTts flutterTts = FlutterTts();

  List<bool> isTrue = [];
  List<bool> isTrueId = [];
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
  int subLevel = 4;
  int adjLevel = 2;
  int adj = 0;

  void initGame() {
    isTrue = List.generate(adjLevel, (index) => false);
    isTrueId = List.generate(adjLevel, (index) => false);
    colors.shuffle();
    domain = List.generate(isTrue.length, (index) => index);
    domain.shuffle();
    codomain = List.generate(domain.length, (index) => domain[index]);
    codomain.shuffle();
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('id-ID');
    flutterTts.speak("Mencocokkan warna!");
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
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isTrueId[index]
                          ? Stack(
                              children: [
                                Container(
                                  height: height,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radius),
                                    color: colors[domain[index]].color,
                                  ),
                                ),
                                Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(radius),
                                      color: Colors.lightGreenAccent
                                          .withOpacity(0.8),
                                    ),
                                    child: Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 35,
                                      color: Colors.green,
                                    )),
                              ],
                            )
                          : Draggable(
                              data: {'id': index, 'content': domain[index]},
                              feedback: Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
                                  color: colors[domain[index]].color,
                                ),
                              ),
                              childWhenDragging: SizedBox(
                                height: height,
                                width: width,
                              ),
                              child: Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
                                  color: colors[domain[index]].color,
                                ),
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: isTrue[index]
                                  ? colors[codomain[index]].color
                                  : Colors.white),
                          child: Container(
                            margin: EdgeInsets.all(height / 100 * 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: colors[codomain[index]].color,
                            ),
                          ),
                        );
                      }, onAcceptWithDetails: (DragTargetDetails details) {
                        if (details.data['content'] == codomain[index]) {
                          setState(() {
                            isTrueId[int.parse('${details.data['id']}')] = true;
                            isTrue[index] = true;
                            flutterTts.speak(colors[codomain[index]].name);
                          });
                          winGame();
                        }
                      })
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
                itemCount: isTrue.length),
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
