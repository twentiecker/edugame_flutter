import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class CompletePatternGame extends StatefulWidget {
  final List<String> images;

  const CompletePatternGame({Key? key, required this.images}) : super(key: key);

  @override
  State<CompletePatternGame> createState() => _CompletePatternGameState();
}

class _CompletePatternGameState extends State<CompletePatternGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 0;
  int subLevel = 3;
  int adjLevel = 4;

  late int difficulty;

  void initGame() {
    adjLevel < 5 ? difficulty = 4 : difficulty = 6;
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
    Random().nextInt(2) == 1
        ? colors = List.generate(
            Colors.primaries.length, (index) => Colors.primaries[index])
        : colors = List.generate(
            Colors.accents.length, (index) => Colors.accents[index]);
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
                                domain[index]['shape']!,
                                color:
                                    colors[int.parse(domain[index]['data']!)],
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
                                domain[index]['shape']!,
                                color:
                                    colors[int.parse(domain[index]['data']!)],
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
                                      codomain[index]['shape']!,
                                      color: colors[
                                          int.parse(codomain[index]['data']!)],
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
