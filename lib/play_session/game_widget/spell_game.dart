import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';

class SpellGame extends StatefulWidget {
  const SpellGame({Key? key}) : super(key: key);

  @override
  State<SpellGame> createState() => _SpellGameState();
}

class _SpellGameState extends State<SpellGame> {
  FlutterTts flutterTts = FlutterTts();

  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';

  bool isTrue = false;
  List<String> words = ['B A', 'C A', 'D A', 'F A', 'G A'];
  String word = '';

  @override
  void initState() {
    super.initState();

    flutterTts.setLanguage('id-ID');
    _initSpeech();

    words.shuffle();
    word = words[Random().nextInt(words.length)];
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    var locales = await _speechToText.locales();
    var selectedLocale = locales[66];

    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: selectedLocale.localeId,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (_lastWords ==
          '${word.toLowerCase()} ${word.toLowerCase().replaceAll(' ', '')}') {
        isTrue = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (isTrue) {
        levelState.setProgress(100);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: () {
            flutterTts.setSpeechRate(0.3);
            flutterTts.speak(word);
          },
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                  left: 28,
                  top: 28,
                  child: Text(word,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ))),
              Positioned(left: 3, top: 3, child: Icon(Icons.volume_up)),
            ],
          ),
        ),
        SizedBox(height: 10),
        _lastWords == ''
            ? Text('Jawaban: -', style: TextStyle(fontSize: 25))
            : Text('Jawaban: $_lastWords', style: TextStyle(fontSize: 25)),
        SizedBox(height: 10),
        _lastWords != ''
            ? ElevatedButton(
                onPressed: () {
                  if (isTrue) {
                    winGame();
                  } else {
                    flutterTts.speak('Coba lagi');
                    setState(() {
                      _lastWords = '';
                    });
                  }
                },
                child: Text('Cek Jawaban'))
            : Container(),
        SizedBox(height: 50),
        Text(
          _speechToText.isListening
              ? 'You can talk now'
              : 'Tap the microphone to start talking',
        ),
        SizedBox(height: 10),
        ElevatedButton(
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            child:
                Icon(_speechToText.isNotListening ? Icons.mic : Icons.mic_off)),
      ],
    );
  }
}
