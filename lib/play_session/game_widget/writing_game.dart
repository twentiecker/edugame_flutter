import 'package:flutter/material.dart' hide Ink;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../game_internals/level_state.dart';
import '../../style/my_button.dart';

class WritingGame extends StatefulWidget {
  final String title;
  final List<String> data;
  final bool isShape;

  const WritingGame({
    Key? key,
    required this.title,
    required this.data,
    this.isShape = false,
  }) : super(key: key);

  @override
  State<WritingGame> createState() => _WritingGameState();
}

class _WritingGameState extends State<WritingGame> {
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  final _language = 'en';
  final _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink _ink = Ink();
  final FlutterTts flutterTts = FlutterTts();

  List<StrokePoint> _points = [];
  String question = '';
  bool result = false;
  bool isLoading = true;
  Map<String, String> shapeTranslator = {
    'X': 'tanda silang',
    '+': 'tanda tambah',
    'll': '2 garis tegak lurus',
    'l': '1 garis tegak lurus',
    '=': '2 garis mendatar',
    '-': '1 garis mendatar',
    'O': 'lingkaran',
  };

  int progress = 0;
  int subLevel = 5;

  void initGame() {
    _isModelDownloaded();
    _clearPad();
    widget.data.shuffle();
    question = widget.data[0];
    result = false;
  }

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('id-ID');
    flutterTts.speak(widget.title);
    initGame();
  }

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final levelState = context.watch<LevelState>();

    void winGame() {
      if (result) {
        progress = levelState.progress + levelState.goal ~/ subLevel;
        levelState.setProgress(progress);
        context.read<AudioController>().playSfx(SfxType.wssh);
        levelState.evaluate();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 64, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: result
                                  ? () {}
                                  : () async {
                                      await _recogniseText();
                                      setState(() {
                                        winGame();
                                      });
                                    },
                              child: Text('Read Text'),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  question,
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _clearPad,
                              child: Text('Clear Pad'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: progress < levelState.goal && result
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
                  Expanded(
                    child: GestureDetector(
                      onPanStart: (DragStartDetails details) {
                        _ink.strokes.add(Stroke());
                      },
                      onPanUpdate: (DragUpdateDetails details) {
                        setState(() {
                          final RenderObject? object =
                              context.findRenderObject();
                          final localPosition = (object as RenderBox?)
                              ?.globalToLocal(details.localPosition);
                          if (localPosition != null) {
                            _points = List.from(_points)
                              ..add(StrokePoint(
                                x: localPosition.dx,
                                y: localPosition.dy,
                                t: DateTime.now().millisecondsSinceEpoch,
                              ));
                          }
                          if (_ink.strokes.isNotEmpty) {
                            _ink.strokes.last.points = _points.toList();
                          }
                        });
                      },
                      onPanEnd: (DragEndDetails details) {
                        _points.clear();
                        setState(() {});
                      },
                      child: CustomPaint(
                        painter: Signature(ink: _ink),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _clearPad() {
    setState(() {
      _ink.strokes.clear();
      _points.clear();
    });
  }

  Future<void> _isModelDownloaded() async {
    await _modelManager.isModelDownloaded(_language)
        ? setState(() {
            isLoading = false;
          })
        : _downloadModel();
  }

  Future<void> _downloadModel() async {
    Toast().show(
        'Downloading model...',
        _modelManager
            .downloadModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _recogniseText() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Recognizing'),
            ),
        barrierDismissible: true);
    try {
      final candidates = await _digitalInkRecognizer.recognize(_ink);
      for (var i = 0; i < 3; i++) {
        debugPrint('${candidates[i].text} : ${candidates[i].text == question}');
        if (candidates[i].text == question) {
          result = true;
          widget.isShape
              ? flutterTts.speak(shapeTranslator[question]!)
              : flutterTts.speak(question);
          break;
        }
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please write something!'),
      ));
    }
    Navigator.pop(context);
  }
}

class Signature extends CustomPainter {
  Ink ink;

  Signature({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}

class Toast {
  void show(String message, Future<String> t, BuildContext context,
      State<StatefulWidget> state) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    showLoadingIndicator(context, message);
    final verificationResult = await t;
    Navigator.of(context).pop();
    if (!state.mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Result: ${verificationResult.toString()}'),
    ));
  }

  void showLoadingIndicator(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final String text;

  const LoadingIndicator({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [_getLoadingIndicator(), _getHeading(), _getText(text)]));
  }

  Widget _getLoadingIndicator() {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 3)));
  }

  Widget _getHeading() {
    return Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          'Please wait …',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ));
  }

  Widget _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}
