import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  bool isCastle1 = false;
  bool isCastle2 = false;
  bool isCastle3 = false;

  // List<Map<String, String>> gameData = [
  //   {'data': 'circle', 'shape': 'assets/images/shape2d/circle.png'},
  //   {'data': 'square', 'shape': 'assets/images/shape2d/square.png'},
  //   {'data': 'triangle', 'shape': 'assets/images/shape2d/triangle.png'},
  //   {'data': 'star', 'shape': 'assets/images/shape2d/star.png'}
  // ];
  // Map<String, String> shape1 = {};
  // Map<String, String> shape2 = {};

  // @override
  // void initState() {
  //   super.initState();
  //   gameData.shuffle();
  //   shape1 = gameData[Random().nextInt(gameData.length)];
  //   while (true) {
  //     shape2 = gameData[Random().nextInt(gameData.length)];
  //     if (shape1 != shape2) break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 300,
                height: 162,
                child: isCastle1
                    ? Image.asset(
                        'assets/images/slice/castle_01.png',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2)),
                  child: Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontFamily: 'Permanent Marker',
                        fontSize: 100,
                        height: 1,
                      ),
                    ),
                  ),
                      ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == 'castle_01') {
                setState(() {
                  isCastle1 = true;
                });
              }
            }),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 300,
                height: 161,
                child: isCastle2
                    ? Image.asset(
                        'assets/images/slice/castle_02.png',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2)),
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontFamily: 'Permanent Marker',
                        fontSize: 100,
                        height: 1,
                      ),
                    ),
                  ),
                      ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == 'castle_02') {
                setState(() {
                  isCastle2 = true;
                });
              }
            }),
            DragTarget(builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 300,
                height: 162,
                child: isCastle3
                    ? Image.asset(
                        'assets/images/slice/castle_03.png',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 2)),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: 'Permanent Marker',
                              fontSize: 100,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
              );
            }, onAcceptWithDetails: (DragTargetDetails details) {
              if (details.data == 'castle_03') {
                setState(() {
                  isCastle3 = true;
                });
              }
            }),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(vertical: 30.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Draggable(
                        data: 'castle_01',
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: 186,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/slice/castle_01.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        feedback: Container(
                          width: 300,
                          height: 162,
                          child: Image.asset(
                            'assets/images/slice/castle_01.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        childWhenDragging: Container(),
                      ),
                      SizedBox(width: 10),
                      Draggable(
                        data: 'castle_02',
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: 186,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/slice/castle_02.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        feedback: Container(
                          width: 300,
                          height: 162,
                          child: Image.asset(
                            'assets/images/slice/castle_02.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        childWhenDragging: Container(),
                      ),
                      SizedBox(width: 10),
                      Draggable(
                        data: 'castle_03',
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: 186,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/slice/castle_03.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        feedback: Container(
                          width: 300,
                          height: 162,
                          child: Image.asset(
                            'assets/images/slice/castle_03.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        childWhenDragging: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/games');
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}
