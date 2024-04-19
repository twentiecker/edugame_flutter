import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class CompletePatternGame extends StatefulWidget {
  final int level;

  const CompletePatternGame({Key? key, required this.level}) : super(key: key);

  @override
  State<CompletePatternGame> createState() => _CompletePatternGameState();
}

class _CompletePatternGameState extends State<CompletePatternGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<String> shapes = [];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];
  List<Map<String, String>> tempCodomain = [];

  int progress = 0;
  int subLevel = 3;

  late int difficulty;

  void initGame() {
    if (shapes.isEmpty) {
      for (var i = 1; i < 16; i++) {
        shapes.add('$i');
      }
    }
    shapes.shuffle();
    widget.level < 4 ? difficulty = 4 : difficulty = 6;
    for (var i = 0; i < difficulty; i++) {
      isTrue.add(true);
    }
    isTrue[Random().nextInt(isTrue.length)] = false;
    if (difficulty == 6) {
      final int baseIndex = isTrue.indexWhere((element) => element == false);
      for (var i = 0; i < isTrue.length; i++) {
        if (i == baseIndex - 3 || i == baseIndex + 3) continue;
        isTrue[i] = isTrue[i] ? false : isTrue[i];
        if (isTrue.where((element) => element == false).length == 2) break;
      }
    }
    Random().nextInt(2) == 1
        ? colors.addAll(Colors.primaries)
        : colors.addAll(Colors.accents);
    colors.shuffle();
    for (var i = 0; i < isTrue.length; i++) {
      domain.add({'data': '${i + 1}', 'shape': shapes[i], 'color': '$i'});
    }
    domain.shuffle();
    tempCodomain.addAll(domain);
    tempCodomain.shuffle();
    for (var i = 0; i < isTrue.length; i++) {
      codomain.add(tempCodomain[i % (difficulty ~/ 2)]);
    }
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

    return Column(
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
                            data: domain[index]['data'],
                            feedback: Container(
                              height: height,
                              width: width,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              child: Image.asset(
                                'assets/images/shape2d/${domain[index]['shape']!}.png',
                                color: colors[
                                    int.parse('${domain[index]['color']}')],
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
                              child: Image.asset(
                                'assets/images/shape2d/${domain[index]['shape']!}.png',
                                color: colors[
                                    int.parse('${domain[index]['color']}')],
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
                                  ? Image.asset(
                                      'assets/images/shape2d/${codomain[index]['shape']!}.png',
                                      color: colors[int.parse(
                                          '${codomain[index]['color']}')],
                                    )
                                  : Text(''),
                            );
                          }, onAcceptWithDetails: (DragTargetDetails details) {
                            if (details.data == codomain[index]['data']) {
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
        progress < levelState.goal && isTrue.every((element) => element == true)
            ? MyButton(
                onPressed: () {
                  setState(() {
                    isTrue = [];
                    colors = [];
                    domain = [];
                    codomain = [];
                    tempCodomain = [];
                    initGame();
                  });
                },
                child: const Text('Next'),
              )
            : Container()
      ],
    );
  }
}
