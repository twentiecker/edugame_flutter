import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class CountNumberGame extends StatefulWidget {
  const CountNumberGame({Key? key}) : super(key: key);

  @override
  State<CountNumberGame> createState() => _CountNumberGameState();
}

class _CountNumberGameState extends State<CountNumberGame> {
  bool isTrue1 = false;
  bool isTrue2 = false;
  bool isTrue3 = false;
  bool isTrue4 = false;
  List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> answerList = [];
  late int num1;
  late int num2;
  late int num3;
  late int num4;

  @override
  void initState() {
    super.initState();
    numberList.shuffle();
    num1 = numberList[Random().nextInt(numberList.length)];
    num2 = numberList[Random().nextInt(numberList.length)];
    num3 = numberList[Random().nextInt(numberList.length)];
    num4 = numberList[Random().nextInt(numberList.length)];
    answerList.add(num1);
    answerList.add(num2);
    answerList.add(num3);
    answerList.add(num4);
    answerList.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  width: 280,
                  height: 115,
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    shrinkWrap: true,
                    children: List.generate(num1, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/bird_midflap.png',
                            fit: BoxFit.cover,
                          ));
                    }),
                  ),
                ),
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: isTrue1
                        ? Center(
                            child: Text('$num1',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 50,
                                  height: 1,
                                )),
                          )
                        : Text(''),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == '$num1') {
                    setState(() {
                      isTrue1 = true;
                    });
                  }
                })
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  width: 280,
                  height: 115,
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    shrinkWrap: true,
                    children: List.generate(num2, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/bird_midflap.png',
                            fit: BoxFit.cover,
                          ));
                    }),
                  ),
                ),
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: isTrue2
                        ? Center(
                            child: Text('$num2',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 50,
                                  height: 1,
                                )),
                          )
                        : Text(''),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == '$num2') {
                    setState(() {
                      isTrue2 = true;
                    });
                  }
                })
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  width: 280,
                  height: 115,
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    shrinkWrap: true,
                    children: List.generate(num3, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/bird_midflap.png',
                            fit: BoxFit.cover,
                          ));
                    }),
                  ),
                ),
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: isTrue3
                        ? Center(
                            child: Text('$num3',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 50,
                                  height: 1,
                                )),
                          )
                        : Text(''),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == '$num3') {
                    setState(() {
                      isTrue3 = true;
                    });
                  }
                })
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.white,
                  width: 280,
                  height: 115,
                  child: GridView.count(
                    crossAxisCount: 5,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    shrinkWrap: true,
                    children: List.generate(num4, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/bird_midflap.png',
                            fit: BoxFit.cover,
                          ));
                    }),
                  ),
                ),
                DragTarget(builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: isTrue4
                        ? Center(
                            child: Text('$num4',
                                style: TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 50,
                                  height: 1,
                                )),
                          )
                        : Text(''),
                  );
                }, onAcceptWithDetails: (DragTargetDetails details) {
                  if (details.data == '$num4') {
                    setState(() {
                      isTrue4 = true;
                    });
                  }
                })
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Draggable(
                  data: '${answerList[0]}',
                  child: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[0]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  feedback: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[0]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[0]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                ),
                Draggable(
                  data: '${answerList[1]}',
                  child: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[1]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  feedback: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[1]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[1]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                ),
                Draggable(
                  data: '${answerList[2]}',
                  child: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[2]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  feedback: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[2]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[2]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                ),
                Draggable(
                  data: '${answerList[3]}',
                  child: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[3]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  feedback: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[3]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                  childWhenDragging: Container(
                    height: 115,
                    width: 80,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text('${answerList[3]}',
                          style: TextStyle(
                            fontFamily: 'Permanent Marker',
                            fontSize: 50,
                            height: 1,
                          )),
                    ),
                  ),
                ),
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
