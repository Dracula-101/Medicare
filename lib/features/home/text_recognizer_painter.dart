import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../data/models/ocr/ocr_response_model.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
    this.recognizedText,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final RecognizedText recognizedText;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.lightGreenAccent
      ..strokeCap = StrokeCap.round;

    final Paint background = Paint()..color = Color(0x99000000);

    for (final textBlock in recognizedText.blocks) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 18,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(
          ui.TextStyle(color: Colors.lightGreenAccent, background: background));
      builder.addText(textBlock.text);
      builder.pop();

      final left = translateX(
        textBlock.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        textBlock.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        textBlock.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final List<Offset> cornerPoints = <Offset>[];
      for (final point in textBlock.cornerPoints) {
        double x = translateX(
          point.x.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );
        double y = translateY(
          point.y.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );

        if (Platform.isAndroid) {
          switch (cameraLensDirection) {
            case CameraLensDirection.front:
              switch (rotation) {
                case InputImageRotation.rotation0deg:
                case InputImageRotation.rotation90deg:
                  break;
                case InputImageRotation.rotation180deg:
                  x = size.width - x;
                  y = size.height - y;
                  break;
                case InputImageRotation.rotation270deg:
                  x = translateX(
                    point.y.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  );
                  y = size.height -
                      translateY(
                        point.x.toDouble(),
                        size,
                        imageSize,
                        rotation,
                        cameraLensDirection,
                      );
                  break;
              }
              break;
            case CameraLensDirection.back:
              switch (rotation) {
                case InputImageRotation.rotation0deg:
                case InputImageRotation.rotation270deg:
                  break;
                case InputImageRotation.rotation180deg:
                  x = size.width - x;
                  y = size.height - y;
                  break;
                case InputImageRotation.rotation90deg:
                  x = size.width -
                      translateX(
                        point.y.toDouble(),
                        size,
                        imageSize,
                        rotation,
                        cameraLensDirection,
                      );
                  y = translateY(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  );
                  break;
              }
              break;
            case CameraLensDirection.external:
              break;
          }
        }

        cornerPoints.add(Offset(x, y));
      }

      // Add the first point to close the polygon
      cornerPoints.add(cornerPoints.first);
      canvas.drawPoints(PointMode.polygon, cornerPoints, paint);

      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: (right - left).abs(),
          )),
        Offset(
            Platform.isAndroid &&
                    cameraLensDirection == CameraLensDirection.front
                ? right
                : left,
            top),
      );
    }
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.recognizedText != recognizedText;
  }
}

double translateX(
  double x,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
      return x *
          canvasSize.width /
          (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation270deg:
      return canvasSize.width -
          x *
              canvasSize.width /
              (Platform.isIOS ? imageSize.width : imageSize.height);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      switch (cameraLensDirection) {
        case CameraLensDirection.back:
          return x * canvasSize.width / imageSize.width;
        default:
          return canvasSize.width - x * canvasSize.width / imageSize.width;
      }
  }
}

double translateY(
  double y,
  Size canvasSize,
  Size imageSize,
  InputImageRotation rotation,
  CameraLensDirection cameraLensDirection,
) {
  switch (rotation) {
    case InputImageRotation.rotation90deg:
    case InputImageRotation.rotation270deg:
      return y *
          canvasSize.height /
          (Platform.isIOS ? imageSize.height : imageSize.width);
    case InputImageRotation.rotation0deg:
    case InputImageRotation.rotation180deg:
      return y * canvasSize.height / imageSize.height;
  }
}

class ImagePainter extends CustomPainter {
  ImagePainter(this.recognizedText, this.imageSize, this.borderColor,
      {this.padding = 4.0,
      this.borderRadius = 2.0,
      this.addText = false,
      this.opacity = 0.2});

  final RecognizedText recognizedText;
  final Size imageSize;
  final double padding;
  final double borderRadius;
  final double opacity;
  final Color borderColor;
  final bool addText;

  @override
  void paint(Canvas canvas, Size size) {
    for (final textBlock in recognizedText.blocks) {
      final left = textBlock.boundingBox.left - padding;
      final top = textBlock.boundingBox.top - padding;
      final right = textBlock.boundingBox.right + padding;
      final bottom = textBlock.boundingBox.bottom + padding;

      // Create a filled rectangle with opacity
      final Rect filledRect =
          Rect.fromPoints(Offset(left, top), Offset(right, bottom));
      final Paint fillPaint = Paint()
        ..color = borderColor.withOpacity(opacity); // Opacity set to 0.1
      canvas.drawRect(filledRect, fillPaint);

      // Create a rounded rectangle with the specified borderRadius
      final RRect roundedRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(left, top, right, bottom),
        Radius.circular(borderRadius),
      );

      // Draw the rounded rectangle with border
      final Paint borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = borderColor
        ..strokeCap = StrokeCap.round;

      canvas.drawRRect(roundedRect, borderPaint);

      if (addText) {
        final ParagraphBuilder builder = ParagraphBuilder(
          ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 8,
            textDirection: TextDirection.ltr,
          ),
        );
        builder.pushStyle(ui.TextStyle(
          color: Colors.lightGreenAccent,
        ));
        builder.addText(textBlock.text);

        // Adjust the text position to account for padding
        final textLeft = left + padding;
        final textTop = top + padding;

        canvas.drawParagraph(
          builder.build()
            ..layout(ParagraphConstraints(
              width: (right - left - 2 * padding).abs(),
            )),
          Offset(textLeft, textTop),
        );
      }
    }
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return oldDelegate.recognizedText != recognizedText;
  }
}

class OCRPainter extends CustomPainter {
  OCRPainter(this.ocrDoc, this.imageSize, this.borderColor,
      {this.padding = 4.0, this.borderRadius = 2.0, this.opacity = 0.2});

  final OCRDocument ocrDoc;
  final Size imageSize;
  final double padding;
  final double borderRadius;
  final double opacity;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (final OCRPage page in ocrDoc.pages?? []){
      for (final Block textBlock in page.blocks ?? []) {
        double leftX =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[0].x ?? 0.0) *
                imageSize.width;
        ;
        double leftY =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[0].y ?? 0.0) *
                imageSize.height;
        double rightX =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[2].x ?? 0.0) *
                imageSize.width;
        double rightY =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[2].y ?? 0.0) *
                imageSize.height;
        double topX =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[1].x ?? 0.0) *
                imageSize.width;
        double topY =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[1].y ?? 0.0) *
                imageSize.height;
        double bottomX =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[3].x ?? 0.0) *
                imageSize.width;
        double bottomY =
            (textBlock.layout?.boundingPoly?.normalizedVertices?[3].y ?? 0.0) *
                imageSize.height;

        // Create a filled rectangle with opacity
        final Rect filledRect =
            Rect.fromPoints(Offset(leftX, leftY), Offset(rightX, rightY));
        final Paint fillPaint = Paint()
          ..color = borderColor.withOpacity(opacity); // Opacity set to 0.1
        canvas.drawRect(filledRect, fillPaint);

        // create a rounded rectangle with the specified borderRadius
        final RRect roundedRect = RRect.fromRectAndRadius(
          Rect.fromLTRB(leftX, leftY, rightX, rightY),
          Radius.circular(borderRadius),
        );

        // Draw the rounded rectangle with border
        final Paint borderPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = borderColor
          ..strokeCap = StrokeCap.round;

        canvas.drawRRect(roundedRect, borderPaint);
      }
    }
    
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return oldDelegate.recognizedText != ocrDoc;
  }
}
