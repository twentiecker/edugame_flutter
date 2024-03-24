import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../style/palette.dart';

class MatchColorGame extends StatefulWidget {
  const MatchColorGame({Key? key}) : super(key: key);

  @override
  State<MatchColorGame> createState() => _MatchColorGameState();
}

class _MatchColorGameState extends State<MatchColorGame> {
  bool isRed = false;
  bool isGreen = false;
  bool isBlue = false;
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];
  List<Map<String, dynamic>> gameData = [
    {'data': 'red', 'color': 0},
    {'data': 'green', 'color': 1},
    {'data': 'blue', 'color': 2}
  ];

  @override
  void initState() {
    super.initState();
    gameData.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[0]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[0]['color'].toString())],
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[0]['color'].toString())],
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: isRed
                        ? colors[int.parse(gameData[2]['color'].toString())]
                        : Colors.white),
                child: Container(
                  margin: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors[int.parse(gameData[2]['color'].toString())],
                  ),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[2]['data']) {
                setState(() {
                  isRed = true;
                });
              }
            })
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[1]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[1]['color'].toString())],
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[1]['color'].toString())],
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: isBlue
                        ? colors[int.parse(gameData[0]['color'].toString())]
                        : Colors.white),
                child: Container(
                  margin: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors[int.parse(gameData[0]['color'].toString())],
                  ),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[0]['data']) {
                setState(() {
                  isBlue = true;
                });
              }
            })
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Draggable(
              data: gameData[2]['data'],
              feedback: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[2]['color'].toString())],
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(color: palette.backgroundLevelSelection),
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[int.parse(gameData[2]['color'].toString())],
                ),
              ),
            ),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: isGreen
                        ? colors[int.parse(gameData[1]['color'].toString())]
                        : Colors.white),
                child: Container(
                  margin: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors[int.parse(gameData[1]['color'].toString())],
                  ),
                ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == gameData[1]['data']) {
                setState(() {
                  isGreen = true;
                });
              }
            })
          ],
        ),
      ],
    );
  }
}
