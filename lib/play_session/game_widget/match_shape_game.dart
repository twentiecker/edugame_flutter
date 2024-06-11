import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class MatchShapeGame extends StatefulWidget {
  final int level;
  final List<String> images;

  const MatchShapeGame({
    Key? key,
    required this.level,
    required this.images,
  }) : super(key: key);

  @override
  State<MatchShapeGame> createState() => _MatchShapeGameState();
}

class _MatchShapeGameState extends State<MatchShapeGame> {
  final double scale = 2.7;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<Map<String, String>> domain = [];
  List<Map<String, String>> codomain = [];

  int progress = 0;
  int subLevel = 3;

  void initGame() {
    widget.images.shuffle();
    isTrue = List.generate(widget.level + 2, (index) => false);
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
                          domain[index]['shape']!,
                          scale: scale,
                          color: colors[int.parse('${domain[index]['data']}')],
                        ),
                        childWhenDragging: Image.asset(
                          domain[index]['shape']!,
                          scale: scale,
                          color: colors[int.parse('${domain[index]['data']}')],
                        ),
                        child: Image.asset(
                          domain[index]['shape']!,
                          scale: scale,
                          color: colors[int.parse('${domain[index]['data']}')],
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
                                color: colors[
                                    int.parse('${codomain[index]['data']}')],
                              )
                            : Image.asset(
                                codomain[index]['shape']!,
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
