import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class CompletePatternGame extends StatefulWidget {
  const CompletePatternGame({Key? key}) : super(key: key);

  @override
  State<CompletePatternGame> createState() => _CompletePatternGameState();
}

class _CompletePatternGameState extends State<CompletePatternGame> {
  bool isTrue = false;
  List<Map<String, String>> gameData = [
    {'data': 'circle', 'shape': 'assets/images/shape2d/circle.png'},
    {'data': 'square', 'shape': 'assets/images/shape2d/square.png'},
    {'data': 'triangle', 'shape': 'assets/images/shape2d/triangle.png'},
    {'data': 'star', 'shape': 'assets/images/shape2d/star.png'}
  ];
  Map<String, String> shape1 = {};
  Map<String, String> shape2 = {};

  @override
  void initState() {
    super.initState();
    gameData.shuffle();
    shape1 = gameData[Random().nextInt(gameData.length)];
    while (true) {
      shape2 = gameData[Random().nextInt(gameData.length)];
      if (shape1 != shape2) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Draggable(
                  data: gameData[0]['data'],
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(gameData[0]['shape']!),
                  ),
                  feedback: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[0]['shape']!),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[0]['shape']!),
                  ),
                ),
                SizedBox(height: 10),
                Draggable(
                  data: gameData[1]['data'],
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(gameData[1]['shape']!),
                  ),
                  feedback: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[1]['shape']!),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[1]['shape']!),
                  ),
                ),
                SizedBox(height: 10),
                Draggable(
                  data: gameData[2]['data'],
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(gameData[2]['shape']!),
                  ),
                  feedback: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[2]['shape']!),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[2]['shape']!),
                  ),
                ),
                SizedBox(height: 10),
                Draggable(
                  data: gameData[3]['data'],
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(gameData[3]['shape']!),
                  ),
                  feedback: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[3]['shape']!),
                  ),
                  childWhenDragging: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(gameData[3]['shape']!),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(shape1['shape']!),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(shape2['shape']!),
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(shape1['shape']!),
                ),
                SizedBox(height: 10),
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isTrue ? Image.asset(shape2['shape']!) : Text(''),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == shape2['data']) {
                    setState(() {
                      isTrue = true;
                    });
                  }
                })
              ],
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
