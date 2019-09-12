import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  MyCustomPainter(this.animation, this.size) {
    final initialWidth = size.width / 30;
    final initialHeight = size.height * 0.925 - 100;
    final aditionalWidth = size.width * .45;

    firstAnimation = [
      // MAKING BUTTON BORDER
      Offset(initialWidth, initialHeight),
      for (int i = 0; i <= 100; i++)
        Offset(initialWidth + (aditionalWidth * i / 100), initialHeight),
      for (int i = 0; i <= 10; i++)
        Offset(
          initialWidth + aditionalWidth,
          size.height - 100 - (size.height * .075 * (10 - i) / 10),
        ),
      for (int i = 0; i <= 20; i++)
        Offset(
            initialWidth + aditionalWidth * (20 - i) / 20, size.height - 100),
      for (int i = 0; i <= 5; i++)
        Offset(initialWidth, initialHeight + (i / 5)),

      // MAKING PATH TO USER INPUT
      for (int i = 0; i <= 75; i++)
        Offset(initialWidth, initialHeight - (size.height / 2 * i / 75)),
      for (int i = 0; i <= 200; i++)
        Offset(
          size.width * (i / 200) -
              size.width / 30 +
              (2 * size.width / 30) * ((200 - i) / 200),
          initialHeight - size.height / 2,
        ),
    ];
    secondAnimation = [
      // MAKING PATH TO USER INPUT
      for (int i = 0; i <= 700; i++)
        Offset(
          size.width * (i / 700) -
              size.width / 30 +
              (2 * size.width / 30) * ((700 - i) / 700),
          initialHeight - size.height / 2,
        ),

      // MAKING PATH FOR PASSWORD INPUT
      for (int i = 0; i <= 200; i++)
        Offset(
          size.width * 29 / 30,
          initialHeight - size.height / 2 + (100 * i / 200),
        ),

      for (int i = 0; i <= 500; i++)
        Offset(
          size.width * 29 / 30 - (size.width * 28 / 30 * i / 500),
          initialHeight - size.height / 2 + 100,
        ),
    ];
    thirdAnimation = [
      for (int i = 0; i <= 50; i++)
        Offset(
          size.width * 29 / 30 - (size.width * 28 / 30 * i / 50),
          initialHeight - size.height / 2 + 100,
        ),

      // MAKING PATH TO MAKE LOGIN BUTTON
      for (int i = 0; i <= 100; i++)
        Offset(
          size.width / 30,
          initialHeight - size.height / 2 + 100 + (165 * i / 100),
        ),

      for (int i = 0; i <= 50; i++)
        Offset(
          size.width * (i / 50) -
              size.width / 30 +
              (2 * size.width / 30) * ((50 - i) / 50),
          initialHeight - size.height / 6,
        ),

      for (int i = 0; i <= 50; i++)
        Offset(
          size.width * 29 / 30,
          initialHeight - size.height / 6 - (60 * i / 50),
        ),

      for (int i = 0; i <= 400; i++)
        Offset(
          size.width * 29 / 30 - (size.width * 28 / 30 * i / 400),
          initialHeight - size.height / 6 - 60,
        ),
    ];
  }
  final Animation animation;
  final Size size;

  List<Offset> firstAnimation;
  List<Offset> secondAnimation;
  List<Offset> thirdAnimation;

  double lerp(double v0, double v1, double t) => (1 - t) * v0 + t * v1;

  double sigmoid(double x) => 0.5 * (sin(x * pi - pi / 2) + 1);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = [];

    Paint paint = Paint();
    paint.color = Colors.white.withOpacity(1);
    paint.strokeWidth = 0.3;
    paint.strokeCap = StrokeCap.square;

    final realAnimationValue = animation.value * 4;

    if (realAnimationValue == 0) {
      points = firstAnimation.sublist(0, 135);
    } else if (realAnimationValue > 0 && realAnimationValue <= 1) {
      points = firstAnimation.sublist(
          ((firstAnimation.length - 200) *
                  pow(sigmoid(realAnimationValue / 2), 0.5))
              .floor(),
          (firstAnimation.length * realAnimationValue).floor() - 30);
    } else if (realAnimationValue > 1 && realAnimationValue <= 2) {
      points = firstAnimation.sublist(
        ((firstAnimation.length - 200) *
                pow(sigmoid(realAnimationValue / 2), 0.5))
            .floor(),
        firstAnimation.length - (30 * (2 - realAnimationValue)).floor(),
      );
    } else if (realAnimationValue > 2 && realAnimationValue <= 3) {
      points = secondAnimation.sublist(
        (pow(sigmoid(realAnimationValue - 2), 0.3) *
                (secondAnimation.length - 501))
            .floor(),
        (700 +
                (secondAnimation.length - 700) *
                    pow(sigmoid(realAnimationValue - 2), 0.5))
            .floor(),
      );
    } else if (realAnimationValue > 3 && realAnimationValue <= 4) {
      points = thirdAnimation.sublist(
        (122 * (realAnimationValue - 3)).floor(),
        (51 +
                (thirdAnimation.length - 51) *
                    (pow(sigmoid(realAnimationValue - 3),
                        6 / (realAnimationValue * realAnimationValue))))
            .floor(),
      );
    }

    // points = thirdAnimation.sublist(0, 51);
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldPainter) => true;
}
