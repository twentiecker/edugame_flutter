import 'dart:math';

import 'package:flutter/material.dart';

class GreaterNumberGame extends StatefulWidget {
  const GreaterNumberGame({Key? key}) : super(key: key);

  @override
  State<GreaterNumberGame> createState() => _GreaterNumberGameState();
}

class _GreaterNumberGameState extends State<GreaterNumberGame> {
  bool isTrue1 = false;
  bool isTrue2 = false;
  int num1 = 0;
  int num2 = 1;

  @override
  void initState() {
    super.initState();
    while (true) {
      num1 = Random().nextInt(20);
      if (num1 != 0) break;
    }
    while (true) {
      num2 = Random().nextInt(20);
      if (num1 != num2 && num2 != 0) break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (num1 > num2) {
              setState(() {
                isTrue1 = true;
              });
            }
          },
          child: Stack(children: [
            Container(
              color: Colors.white,
              width: 280,
              height: 230,
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
                    ),
                  );
                }),
              ),
            ),
            isTrue1
                ? Container(
                    color: Colors.lightGreenAccent.withOpacity(0.8),
                    width: 280,
                    height: 230,
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
            if (num1 < num2) {
              setState(() {
                isTrue2 = true;
              });
            }
          },
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                width: 280,
                height: 230,
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
                      ),
                    );
                  }),
                ),
              ),
              isTrue2
                  ? Container(
                      color: Colors.lightGreenAccent.withOpacity(0.8),
                      width: 280,
                      height: 230,
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
      ],
    );
  }
}
