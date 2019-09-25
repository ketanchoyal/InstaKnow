import 'dart:math';
import 'package:flutter/material.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;

class GaugeChart extends StatelessWidget {
  final List<Color> colors;
  final double percentage;
  final bool isPrivate;

  GaugeChart({
    this.colors,
    this.percentage,
    this.isPrivate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      // margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(150.0),
        ),
        border: new Border.all(width: 4, color: colors[1].withOpacity(0.2)),
      ),
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                percentage.toString() + '%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: R.avenirFontFamily,
                  fontSize: 16,
                  color: isPrivate ? Colors.black : Colors.white,
                ),
              ),
            ),
            CustomPaint(
              painter: CurvePainter(
                colors: colors,
                percentage: percentage / 100,
              ),
              child: SizedBox(
                width: 150,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  // List<charts.Series<GaugeSegment, String>> _createSampleData() {
  //   final data = [
  //     new GaugeSegment(
  //         '',
  //         1,
  //         charts.Color.fromHex(
  //             code: "#" + color.value.toRadixString(16).substring(2))),
  //   ];

  //   return [
  //     new charts.Series<GaugeSegment, String>(
  //       id: 'Segments',
  //       colorFn: (GaugeSegment segment, _) => segment.color,
  //       domainFn: (GaugeSegment segment, _) => segment.segment,
  //       measureFn: (GaugeSegment segment, _) => segment.size,
  //       data: data,
  //     )
  //   ];
  // }
}

/// Sample data type.
// class GaugeSegment {
//   final String segment;
//   final int size;
//   final charts.Color color;

//   GaugeSegment(this.segment, this.size, this.color);
// }

class CurvePainter extends CustomPainter {
  double _angle;
  final List<Color> colors;
  final double percentage;

  CurvePainter({
    this.colors,
    this.percentage: 0.3,
  }) {
    _angle = 360 * percentage;
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius = min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - _angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - _angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - _angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - _angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - _angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(_angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (pi / 180) * degree;
    return redian;
  }
}
