import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class CountNumberGame extends StatefulWidget {
  final int level;

  const CountNumberGame({Key? key, required this.level}) : super(key: key);

  @override
  State<CountNumberGame> createState() => _CountNumberGameState();
}

class _CountNumberGameState extends State<CountNumberGame> {
  final double height = 95.0;
  final double width = 80.0;
  final double radius = 10.0;

  List<bool> isTrue = [];
  List<Color> colors = [];
  List<int> domain = [];
  List<int> codomain = [];

  int progress = 0;
  int subLevel = 3;

  void initGame() {
    for (var i = 0; i < widget.level; i++) {
      isTrue.add(false);
    }
    Random().nextInt(2) == 1
        ? colors.addAll(Colors.primaries)
        : colors.addAll(Colors.accents);
    colors.shuffle();
    for (var i = 1; i < 11; i++) {
      domain.add(i);
    }
    domain.shuffle();
    for (var i = 0; i < isTrue.length; i++) {
      codomain.add(domain[i]);
    }
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
                            'assets/images/shape2d/${codomain[index]}.png',
                            color: colors[codomain[index]],
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
                                    color: colors[index]),
                              ),
                            )
                          : Text(''),
                    );
                  }, onAcceptWithDetails: (DragTargetDetails details) {
                    if (details.data == '${codomain[index]}') {
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
                              color: colors[index]),
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
                              color: colors[index]),
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
                              color: colors[index]),
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
        progress < levelState.goal && isTrue.every((element) => element == true)
            ? MyButton(
                onPressed: () {
                  setState(() {
                    isTrue = [];
                    colors = [];
                    domain = [];
                    codomain = [];
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
