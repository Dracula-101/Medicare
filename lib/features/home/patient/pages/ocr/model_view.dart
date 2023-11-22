import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteModel {
  final String modelName = 'model.tflite';
  final int inputSize = 224;
  final int numChannels = 3;
  final int numBytesPerChannel = 4;

  late InterpreterOptions _interpreterOptions;
  late Interpreter _interpreter;

  TFLiteModel() {
    _interpreterOptions = InterpreterOptions();
  }

  init () async {
    try {
      // _interpreter = await Interpreter.fromAsset(modelName, options: _interpreterOptions)
      Future.delayed(Duration(milliseconds: 1), () async {
      });
    } catch (e) {
      print('Error initializing interpreter.');
      print(e);
    }
  }

  Future<List> predict(List input) async {
    final output = List.filled(1 * 1001, 0).reshape([1, 1001]);
    _interpreter.run(input, output);
    return output;
  }

  void close() {
    _interpreter.close();
  }
}