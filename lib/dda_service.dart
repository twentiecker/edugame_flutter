import 'package:camera/camera.dart';
import 'package:camera_process/camera_process.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_internals/level_state.dart';
import 'main.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector =
  CameraProcess.vision.faceDetector(const FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));
  bool isBusy = false;

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    final levelState = context.read<LevelState>();

    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    debugPrint('Found ${faces.length} faces');

    if (faces.isEmpty) {
      levelState.setProb(0.0);
    } else {
      for (Face face in faces) {
        debugPrint('${face.smilingProbability}');
        levelState.setProb(double.parse('${face.smilingProbability}'));
      }
    }

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class CameraView extends StatefulWidget {
  const CameraView({super.key,
    required this.onImage,
    this.initialDirection = CameraLensDirection.back});

  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  int _cameraIndex = 0;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _liveFeedBody();
  }

  Widget _liveFeedBody() {
    final levelState = context.read<LevelState>();

    if (_controller?.value.isInitialized == false) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 0,
          height: 0,
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CameraPreview(_controller!),
            ],
          ),
        ),
        Text(
          levelState.prob.toStringAsFixed(3),
          style: TextStyle(fontSize: 35),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes
        .done()
        .buffer
        .asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat = InputImageFormatMethods.fromRawValue(
        int.parse('${image.format.raw}')) ??
        InputImageFormat.NV21;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
