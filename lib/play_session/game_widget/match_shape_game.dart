import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../dda_service.dart';
import '../../game_internals/level_state.dart';
import '../../model/base_color.dart';
import '../../style/my_button.dart';

class MatchShapeGame extends StatefulWidget {
  final List<String> images;

  const MatchShapeGame({Key? key, required this.images}) : super(key: key);

  @override
  State<MatchShapeGame> createState() => _MatchShapeGameState();
}

class _MatchShapeGameState extends State<MatchShapeGame> {
  final double scale = 2.7;

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
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 0;
  int subLevel = 5;
  int adjLevel = 2;
  int adj = 0;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(adjLevel, (index) => false);
    isTrueId = List.generate(adjLevel, (index) => false);
    colors.shuffle();
    domain = List.generate(
      isTrue.length,
      (index) => {
        'data': '$index',
        'shape': widget.images[index],
      },
    );
    domain.shuffle();
    codomain = List.generate(domain.length, (index) => domain[index]);
    codomain.shuffle();
  }

  @override
  void initState() {
    super.initState();
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
                                  Image.asset(
                                    domain[index]['shape']!,
                                    scale: scale,
                                    color: colors[int.parse(
                                            '${domain[index]['data']}')]
                                        .color,
                                  ),
                                  Image.asset(
                                    domain[index]['shape']!,
                                    scale: scale,
                                    color: Colors.lightGreenAccent
                                        .withOpacity(0.8),
                                  ),
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 35,
                                    color: Colors.green,
                                  )
                                ],
                              )
                            : Draggable(
                                data: {
                                  'id': index,
                                  'content': domain[index]['data']
                                },
                                feedback: Image.asset(
                                  domain[index]['shape']!,
                                  scale: scale,
                                  color: colors[
                                          int.parse('${domain[index]['data']}')]
                                      .color,
                                ),
                                childWhenDragging: Image.asset(
                                  domain[index]['shape']!,
                                  scale: scale,
                                  color: colors[
                                          int.parse('${domain[index]['data']}')]
                                      .color,
                                ),
                                child: Image.asset(
                                  domain[index]['shape']!,
                                  scale: scale,
                                  color: colors[
                                          int.parse('${domain[index]['data']}')]
                                      .color,
                                ),
                              ),
                        DragTarget(builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return isTrue[index]
                              ? Image.asset(
                                  codomain[index]['shape']!,
                                  scale: scale,
                                  color: colors[int.parse(
                                          '${codomain[index]['data']}')]
                                      .color,
                                )
                              : Image.asset(
                                  codomain[index]['shape']!,
                                  scale: scale,
                                  color: Colors.black38,
                                );
                        }, onAcceptWithDetails: (DragTargetDetails details) {
                          if (details.data['content'] ==
                              codomain[index]['data']) {
                            setState(() {
                              isTrueId[int.parse('${details.data['id']}')] =
                                  true;
                              isTrue[index] = true;
                            });
                            winGame();
                          }
                        })
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 25);
                  },
                  itemCount: isTrue.length)),
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
                                  if ((adjLevel + adj) > widget.images.length) {
                                    adj = 0;
                                  }
                                } else if (levelState.prob >
                                    levelState.happyThreshold) {
                                  adj = 2;
                                  if ((adjLevel + adj) > widget.images.length) {
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
                          if ((adjLevel + adj) > widget.images.length) {
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
