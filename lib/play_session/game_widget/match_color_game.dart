import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
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

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<int> domain = [];
  List<int> codomain = [];

  int progress = 0;
  int subLevel = 3;
  int adjLevel = 4;

  void initGame() {
    isTrue = List.generate(adjLevel, (index) => false);
    Random().nextInt(2) == 1
        ? colors = List.generate(
            Colors.primaries.length, (index) => Colors.primaries[index])
        : colors = List.generate(
            Colors.accents.length, (index) => Colors.accents[index]);
    colors.shuffle();
    domain = List.generate(isTrue.length, (index) => index);
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
                      data: domain[index],
                      feedback: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: colors[domain[index]],
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
                          color: colors[domain[index]],
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
                                ? colors[codomain[index]]
                                : Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(height / 100 * 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: colors[codomain[index]],
                          ),
                        ),
                      );
                    }, onAcceptWithDetails: (DragTargetDetails details) {
                      if (details.data == codomain[index]) {
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
              itemCount: isTrue.length),
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
