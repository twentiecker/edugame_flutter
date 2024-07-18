import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class GreaterNumberGame extends StatefulWidget {
  final bool isGreater;
  final List<String> images;

  const GreaterNumberGame({
    Key? key,
    required this.isGreater,
    required this.images,
  }) : super(key: key);

  @override
  State<GreaterNumberGame> createState() => _GreaterNumberGameState();
}

class _GreaterNumberGameState extends State<GreaterNumberGame> {
  bool isTrue1 = false;
  bool isTrue2 = false;
  int num1 = 0;
  int num2 = 1;
  String imgNum1 = '';
  String imgNum2 = '';
  List<Color> colors = [];
  Color colorNum1 = Colors.white;
  Color colorNum2 = Colors.white;

  int progress = 0;
  int subLevel = 3;

  void initGame() {
    widget.images.shuffle();
    imgNum1 = widget.images[1];
    imgNum2 = widget.images[2];

    colors = List.generate(
        Colors.primaries.length, (index) => Colors.primaries[index]);
    colors.shuffle();
    colorNum1 = colors[1];
    colorNum2 = colors[2];

    while (true) {
      num1 = Random().nextInt(20);
      if (num1 != 0) break;
    }
    while (true) {
      num2 = Random().nextInt(20);
      if (num1 != num2 && num2 != 0) break;
    }
    isTrue1 = false;
    isTrue2 = false;
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
      if (isTrue1 || isTrue2) {
        progress = levelState.progress + levelState.goal ~/ subLevel;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  if (widget.isGreater ? num1 > num2 : num1 < num2) {
                    setState(() {
                      isTrue1 = true;
                    });
                    winGame();
                  }
                },
                child: Stack(children: [
                  Container(
                    width: 280,
                    height: 230,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: GridView.count(
                      crossAxisCount: 5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      shrinkWrap: true,
                      children: List.generate(num1, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            imgNum1,
                            color: colorNum1,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                    ),
                  ),
                  isTrue1
                      ? Container(
                          width: 280,
                          height: 230,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 50,
                            color: Colors.green,
                          ),
                        )
                      : SizedBox(
                          width: 280,
                          height: 230,
                        )
                ]),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (widget.isGreater ? num1 < num2 : num1 > num2) {
                    setState(() {
                      isTrue2 = true;
                    });
                    winGame();
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: 280,
                      height: 230,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: GridView.count(
                        crossAxisCount: 5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        shrinkWrap: true,
                        children: List.generate(num2, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              imgNum2,
                              color: colorNum2,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                      ),
                    ),
                    isTrue2
                        ? Container(
                            width: 280,
                            height: 230,
                            decoration: BoxDecoration(
                                color: Colors.lightGreenAccent.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Icon(
                              Icons.check_circle_outline_rounded,
                              size: 50,
                              color: Colors.green,
                            ),
                          )
                        : SizedBox(
                            width: 280,
                            height: 230,
                          )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: progress < levelState.goal && (isTrue1 || isTrue2)
                    ? MyButton(
                        onPressed: () {
                          setState(() {
                            initGame();
                          });
                        },
                        child: const Text('Next'),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
