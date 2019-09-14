import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:instaknown/UI/Resources/Constants.dart' as R;

class GaugeChart extends StatelessWidget {
  final bool animate;
  final Color color;
  final double percentage;
  final bool isPrivate;

  GaugeChart({
    this.animate,
    this.color,
    this.percentage,
    this.isPrivate = false,
  });

  @override
  Widget build(BuildContext context) {
    var p = percentage * 100;
    return Container(
      height: 150,
      width: 150,
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                p.toString() + '%',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: R.avenirFontFamily,
                  fontSize: 16,
                  color: isPrivate ? Colors.black : Colors.white,
                ),
              ),
            ),
            charts.PieChart(
              _createSampleData(),
              animate: animate,
              defaultInteractions: false,
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 20,
                startAngle: 7.5 / 5 * pi,
                arcLength: 10 / 5 * pi * percentage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment(
          '',
          1,
          charts.Color.fromHex(
              code: "#" + color.value.toRadixString(16).substring(2))),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        colorFn: (GaugeSegment segment, _) => segment.color,
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}
