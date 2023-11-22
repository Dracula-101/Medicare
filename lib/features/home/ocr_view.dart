import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare/features/home/gallery_view.dart';
import 'package:medicare/features/home/text_recognizer_painter.dart';
import 'package:medicare/services/log_service/log_service.dart';

class OCRView extends StatefulWidget {
  const OCRView({super.key});

  @override
  State<OCRView> createState() => _OCRViewState();
}

class _OCRViewState extends State<OCRView> {
  final TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;
  InputImage? inputImage;
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  Size? _imageSize;
  CustomPainter? painter;
  String? _text;
  CameraLensDirection _cameraLensDirection = CameraLensDirection.back;
  bool isLoading = true;

  // logger
  final LogService _logService = GetIt.I.get<LogService>();

  @override
  void dispose() {
    _canProcess = false;
    textRecognizer.close();
    super.dispose();
  }

  Future<dynamic> predictModel(InputImage image) async {
    if (image.bytes == null) {
      return;
    }
    RecognizedText recognizedText;
    try {
      recognizedText = await textRecognizer.processImage(image);
    } catch (e) {
      _logService.e('Error detecting model', e, StackTrace.current);
      return;
    }

    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      _logService.i('Text $text');
      _logService.i('Rect $rect');
      _logService.i('Corner Points $cornerPoints');
      _logService.i('Languages $languages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GalleryView(
      customPainter: painter,
      title: 'Text Detector',
      text: _text,
      size: _imageSize,
      onImage: _processImage,
      onDetectorViewModeChanged: () {
        setState(() {
          _customPaint = null;
          painter = null;
          _text = '';
        });
      },
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    Size deviceSize = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(inputImage.filePath!);
    double width = min(properties.width!.toDouble(), deviceSize.width);
    double height =
        properties.height!.toDouble() * (width / properties.width!.toDouble());
    _imageSize = Size(width, height);
    File compressedFile = await FlutterNativeImage.compressImage(
      inputImage.filePath!,
      targetWidth: width.toInt(),
      targetHeight: height.toInt(),
    );
    inputImage = InputImage.fromFilePath(compressedFile.path);
    final recognizedText = await textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        _imageSize!,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      _logService.i('Image Size: $_imageSize');
      ImagePainter painter =
          ImagePainter(recognizedText, _imageSize!, primaryColor);
      for (TextBlock block in recognizedText.blocks) {
        final Rect rect = block.boundingBox;
        final List<Point<int>> cornerPoints = block.cornerPoints;
        final String text = block.text;
        final List<String> languages = block.recognizedLanguages;

        _logService.i('Text $text');
        _logService.i('Rect $rect');
        _logService.i('Corner Points $cornerPoints');
        _logService.i('Languages $languages');
      }
      this.painter = painter;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
