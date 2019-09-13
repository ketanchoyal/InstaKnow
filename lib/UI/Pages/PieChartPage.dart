import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GaugeChart extends StatelessWidget {
  final bool animate;
  final charts.Color color;
  final double percentage;

  GaugeChart({
    this.animate,
    this.color,
    this.percentage,
  });

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      // _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      _createSampleData(),
      animate: animate,
      defaultInteractions: false,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 20,
        startAngle: 7.5 / 5 * pi,
        arcLength: 10 / 5 * pi * percentage,
      ),
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      // new GaugeSegment('Low', 75),
      // new GaugeSegment('Acceptable', 100),
      new GaugeSegment('', 1, color),
      // new GaugeSegment('Highly Unusual', 5),
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
