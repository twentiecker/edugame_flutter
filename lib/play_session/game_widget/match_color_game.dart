import 'dart:math';

import 'package:basic/style/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class MatchColorGame extends StatefulWidget {
  final int level;

  const MatchColorGame({Key? key, required this.level}) : super(key: key);

  @override
  State<MatchColorGame> createState() => _MatchColorGameState();
}

class _MatchColorGameState extends State<MatchColorGame> {
  final double height = 80.0;
  final double width = 80.0;
  final double radius = 10.0;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<Map<String, dynamic>> domain = [];
  List<Map<String, dynamic>> codomain = [];

  int progress = 100;

  void initGame() {
    Random().nextInt(2) == 1
        ? colors.addAll(Colors.primaries)
        : colors.addAll(Colors.accents);
    for (var i = 0; i < widget.level + 2; i++) {
      isTrue.add(false);
    }
    colors.shuffle();
    for (var i = 0; i < isTrue.length; i++) {
      domain.add({'data': i, 'color': i});
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
        print(levelState.goal);
        progress = levelState.progress + levelState.goal ~/ isTrue.length;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
        print(levelState.progress);
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
                      feedback: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: colors[int.parse('${domain[index]['color']}')],
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
                          color: colors[int.parse('${domain[index]['color']}')],
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
                                ? colors[
                                    int.parse('${codomain[index]['color']}')]
                                : Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(height / 100 * 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: colors[
                                int.parse('${codomain[index]['color']}')],
                          ),
                        ),
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
                return SizedBox(height: 20);
              },
              itemCount: codomain.length),
        ),
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
