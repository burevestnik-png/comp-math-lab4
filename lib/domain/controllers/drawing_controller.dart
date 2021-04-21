import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [
///   axisX
///   axisY
///   currentEquation
/// ]
class DrawingController extends GetxController {
  static const _kPaddingValue = 5;
  static const _kDefaultMax = 15.0;
  static const _kDefaultMin = -15.0;

  static const _kAxisXPlace = 0;
  static const _kAxisYPlace = 1;
  static const _kEquationPlace = 2;

  late final LineChartData chartData;
  late final List<LineChartBarData> _lines = [];

  @override
  void onInit() {
    super.onInit();
    chartData = init();
    _drawAxisX();
    _drawAxisY();
  }

  LineChartData init() {
    return LineChartData(
      gridData: _drawGrid(),
      maxX: _kDefaultMax,
      maxY: _kDefaultMax,
      minX: _kDefaultMin,
      minY: _kDefaultMin,
      lineTouchData: LineTouchData(enabled: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: _drawTitles(),
        leftTitles: _drawTitles(),
      ),
      lineBarsData: _lines,
    );
  }

  void drawGraph(
    Equation equation, {
    double min = _kDefaultMin,
    double max = _kDefaultMax,
    double accuracy = 0.01,
  }) {
    if (_lines.asMap().containsKey(_kEquationPlace))
      _lines.removeAt(_kEquationPlace);

    /*if ((equation.min(min, max).y - chartData.minY).abs() > _kPaddingValue) {
      var previousMinY = chartData.minY;
      chartData.minY = equation.min(min, max).y - _kPaddingValue;
      chartData.maxY = chartData.maxY - previousMinY;

      List<FlSpot> newYAxisDots = [];
      for (var i = chartData.minY; i <= chartData.maxY; i++) {
        newYAxisDots.add(FlSpot(0, i));
      }
      chartData.lineBarsData[1].spots.clear();
      chartData.lineBarsData[1].spots.addAll(newYAxisDots);
    }*/

    List<FlSpot> dots = [];
    for (var i = min; i < max; i += accuracy) {
      if (equation.compute(i) < gridMaxY && equation.compute(i) > gridMinY) {
        dots.add(FlSpot(i, equation.compute(i)));
      }
    }

    _lines.add(LineChartBarData(
      spots: dots,
      isCurved: true,
      dotData: FlDotData(
        show: false,
      ),
    ));
  }

  void _drawAxisY() =>
      _drawAxis(kPlace: _kAxisYPlace, from: gridMinY, to: gridMaxY);

  void _drawAxisX() =>
      _drawAxis(kPlace: _kAxisXPlace, from: gridMinX, to: gridMaxX);

  void _drawAxis({
    required int kPlace,
    required double from,
    required double to,
  }) {
    LineChartBarData defaultStyledAxis(List<FlSpot> dots) {
      return LineChartBarData(
        spots: dots,
        colors: [Colors.black],
        barWidth: 3,
        dotData: FlDotData(
          show: false,
        ),
      );
    }

    if (_lines.asMap().containsKey(kPlace)) _lines.removeAt(kPlace);

    List<FlSpot> dots = [];
    for (var i = from; i <= to; i++) {
      dots.add(kPlace == _kAxisXPlace ? FlSpot(i, 0) : FlSpot(0, i));
    }

    _lines.insert(kPlace, defaultStyledAxis(dots));
  }

  SideTitles _drawTitles() => SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff68737d),
          fontWeight: FontWeight.normal,
          fontSize: 11,
        ),
        getTitles: (value) {
          return value.toInt().toString();
        },
        margin: 8,
      );

  FlGridData _drawGrid() => FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      );

  get gridMinX => chartData.minX;

  get gridMaxX => chartData.maxX;

  get gridMinY => chartData.minY;

  get gridMaxY => chartData.maxY;
}
