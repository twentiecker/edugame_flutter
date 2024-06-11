import 'package:flutter/material.dart' hide Ink;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class WritingGame extends StatefulWidget {
  const WritingGame({Key? key}) : super(key: key);

  @override
  State<WritingGame> createState() => _WritingGameState();
}

class _WritingGameState extends State<WritingGame> {
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();
  var _language = 'en';

  // Codes from https://developers.google.com/ml-kit/vision/digital-ink-recognition/base-models?hl=en#text
  final _languages = [
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'pt',
    'ru',
    'zh-Hani',
  ];
  var _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink _ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Ink Recognition')),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDropdown(),
                  ElevatedButton(
                    onPressed: _isModelDownloaded,
                    child: Text('Check Model'),
                  ),
                  ElevatedButton(
                    onPressed: _downloadModel,
                    child: Icon(Icons.download),
                  ),
                  ElevatedButton(
                    onPressed: _deleteModel,
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _recogniseText,
                    child: Text('Read Text'),
                  ),
                  ElevatedButton(
                    onPressed: _clearPad,
                    child: Text('Clear Pad'),
                  ),
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
                    final RenderObject? object = context.findRenderObject();
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
            if (_recognizedText.isNotEmpty)
              Text(
                'Candidates: $_recognizedText',
                style: TextStyle(fontSize: 23),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() => DropdownButton<String>(
        value: _language,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (String? lang) {
          if (lang != null) {
            setState(() {
              _language = lang;
              _digitalInkRecognizer.close();
              _digitalInkRecognizer =
                  DigitalInkRecognizer(languageCode: _language);
            });
          }
        },
        items: _languages.map<DropdownMenuItem<String>>((lang) {
          return DropdownMenuItem<String>(
            value: lang,
            child: Text(lang),
          );
        }).toList(),
      );

  void _clearPad() {
    setState(() {
      _ink.strokes.clear();
      _points.clear();
      _recognizedText = '';
    });
  }

  Future<void> _isModelDownloaded() async {
    Toast().show(
        'Checking if model is downloaded...',
        _modelManager
            .isModelDownloaded(_language)
            .then((value) => value ? 'downloaded' : 'not downloaded'),
        context,
        this);
  }

  Future<void> _deleteModel() async {
    Toast().show(
        'Deleting model...',
        _modelManager
            .deleteModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
  }

  Future<void> _downloadModel() async {
    Toast().show(
        'Downloading model...',
        _modelManager
            .downloadModel(_language)
            .then((value) => value ? 'success' : 'failed'),
        context,
        this);
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
      _recognizedText = '';
      for (final candidate in candidates) {
        _recognizedText += '\n${candidate.text}';
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
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
