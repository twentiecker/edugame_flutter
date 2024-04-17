import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class MatchShapeGame extends StatefulWidget {
  final int level;

  const MatchShapeGame({Key? key, required this.level}) : super(key: key);

  @override
  State<MatchShapeGame> createState() => _MatchShapeGameState();
}

class _MatchShapeGameState extends State<MatchShapeGame> {
  final double scale = 2.7;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<String> shapes = [];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 100;

  void initGame() {
    if (shapes.isEmpty) {
      print('masukin shape');
      for (var i = 1; i < 16; i++) {
        shapes.add('$i');
      }
    } else {
      print('shape dah ready');
    }
    shapes.shuffle();
    for (var i = 0; i < widget.level + 2; i++) {
      isTrue.add(false);
    }
    Random().nextInt(2) == 1
        ? colors.addAll(Colors.primaries)
        : colors.addAll(Colors.accents);
    colors.shuffle();
    for (var i = 0; i < isTrue.length; i++) {
      domain.add({'data': '$i', 'shape': '$i'});
    }
    domain.shuffle();
    codomain.addAll(domain);
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
        progress = levelState.progress + levelState.goal ~/ isTrue.length;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      children: [
        Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Draggable(
                        data: domain[index]['data'],
                        feedback: Image.asset(
                          'assets/images/shape2d/${shapes[int.parse('${domain[index]['shape']}')]}.png',
                          scale: scale,
                          color: colors[int.parse('${domain[index]['shape']}')],
                        ),
                        childWhenDragging: Image.asset(
                          'assets/images/shape2d/${shapes[int.parse('${domain[index]['shape']}')]}.png',
                          scale: scale,
                          color: colors[int.parse('${domain[index]['shape']}')],
                        ),
                        child: Image.asset(
                          'assets/images/shape2d/${shapes[int.parse('${domain[index]['shape']}')]}.png',
                          scale: scale,
                          color: colors[int.parse('${domain[index]['shape']}')],
                        ),
                      ),
                      DragTarget(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return isTrue[index]
                            ? Image.asset(
                                'assets/images/shape2d/${shapes[int.parse('${codomain[index]['shape']}')]}.png',
                                scale: scale,
                                color: colors[
                                    int.parse('${codomain[index]['shape']}')],
                              )
                            : Image.asset(
                                'assets/images/shape2d/${shapes[int.parse('${codomain[index]['shape']}')]}.png',
                                scale: scale,
                                color: Colors.black38,
                              );
                      }, onAcceptWithDetails: (DragTargetDetails details) {
                        if (details.data == codomain[index]['data']) {
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
                  return SizedBox(height: 25);
                },
                itemCount: isTrue.length)),
        progress < levelState.goal
            ? MyButton(
                onPressed: () {
                  setState(() {
                    isTrue = [];
                    colors = [];
                    domain = [];
                    codomain = [];
                    progress = 100;
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
