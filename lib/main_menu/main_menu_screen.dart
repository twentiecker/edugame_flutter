// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basic/firebase/auth_service.dart';
import 'package:basic/firebase/firestore_service.dart';
import 'package:basic/player_progress/player_progress.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();

  static const _gap = SizedBox(height: 10);
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: Stack(
          children: [
            Center(
              child: Transform.rotate(
                angle: -0.1,
                child: const Text(
                  'Tiny Town Games!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Permanent Marker',
                    fontSize: 55,
                    height: 1,
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: authService.userState(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<PlayerProgress>().reset();
                            authService.userLogout();
                          },
                          child: Image.asset('assets/images/menu/logout.png'),
                        ),
                      )
                    : Container();
              },
            )
          ],
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
                stream: authService.userState(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? MyButton(
                          onPressed: () {
                            audioController.playSfx(SfxType.buttonTap);
                            GoRouter.of(context).go('/games');
                          },
                          child: const Text('Games'),
                        )
                      : MyButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Login Page'),
                                  content: SizedBox(
                                    height: 230,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              TextFormField(
                                                controller: emailController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the email';
                                                  } else if (!RegExp(
                                                          r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                                          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                                          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                                          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                                          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                                          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                                          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])')
                                                      .hasMatch(value)) {
                                                    return 'Enter a valid email adsress';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              TextFormField(
                                                controller: passController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                obscureText: true,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter the password';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  authService
                                                      .userLogin(
                                                          emailController.text,
                                                          passController.text)
                                                      .then((value) {
                                                    GoRouter.of(context).pop();
                                                    GoRouter.of(context)
                                                        .go('/games');
                                                  });
                                                }
                                              },
                                              child: Text('Login'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('Games'),
                        );
                }),
            MainMenuScreen._gap,
            MyButton(
              onPressed: () => GoRouter.of(context).push('/leaderboard'),
              child: const Text('Leaderboard'),
            ),
            MainMenuScreen._gap,
            // MyButton(
            //   onPressed: () => authService.userSignup(),
            //   child: const Text('Sign Up'),
            // ),
            // MainMenuScreen._gap,
            MyButton(
              onPressed: () => GoRouter.of(context).push('/settings'),
              child: const Text('Settings'),
            ),
            MainMenuScreen._gap,
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.audioOn,
                builder: (context, audioOn, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleAudioOn(),
                    icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                  );
                },
              ),
            ),
            MainMenuScreen._gap,
            const Text('Music by Mr Smith'),
            MainMenuScreen._gap,
          ],
        ),
      ),
    );
  }
}
