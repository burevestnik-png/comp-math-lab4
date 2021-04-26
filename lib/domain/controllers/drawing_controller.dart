import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [
///   axisX
///   axisY
///   currentDots
///   linearApprox
///   quadraticApprox
///   powApprox
///   expApprox
///   logApprox
/// ]
class DrawingController extends GetxController {
  static const _kPaddingValue = 5;
  static const _kDefaultMax = 15.0;
  static const _kDefaultMin = -15.0;

  static const _kAxisXPlace = 0;
  static const _kAxisYPlace = 1;
  static const _kTableGraphPlace = 2;
  static const _kApproxStartPlace = 3;

  var _maxApprox = _kApproxStartPlace;

  var currentMinX = _kDefaultMin;
  var currentMaxX = _kDefaultMax;
  var currentMinY = _kDefaultMin;
  var currentMaxY = _kDefaultMax;

  final Map<int, LineChartBarData> graphCache = {};

  late final LineChartData chartData;
  final List<LineChartBarData> _lines = [];

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
      lineTouchData: LineTouchData(
        enabled: false,
        touchTooltipData:
            LineTouchTooltipData(tooltipBgColor: Colors.white.withOpacity(0.8)),
        handleBuiltInTouches: true,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: _drawTitles(),
        leftTitles: _drawTitles(),
      ),
      lineBarsData: _lines,
    );
  }

  void drawTableGraph(
    List<Dot> dots,
  ) {
    _removeApproxes();

    if (_lines.asMap().containsKey(_kTableGraphPlace))
      _lines.removeAt(_kTableGraphPlace);

    if (dots.isEmpty) {
      currentMinX = _kDefaultMin;
      currentMaxX = _kDefaultMax;
      currentMinY = _kDefaultMin;
      currentMaxY = _kDefaultMax;
      updateGridSize();
      return;
    }

    currentMinX = dots.minX().x;
    currentMaxX = dots.maxX().x;
    currentMinY = dots.minY().y;
    currentMaxY = dots.maxY().y;

    updateGridSize();

    _lines.insert(
      _kTableGraphPlace,
      LineChartBarData(
        spots: dots.toFLSpots(),
        isCurved: false,
        dotData: FlDotData(show: true),
      ),
    );
  }

  void _removeApproxes() {
    if (_lines.asMap().containsKey(_kApproxStartPlace)) {
      _lines.removeRange(_kApproxStartPlace, _maxApprox);
    }
    _maxApprox = _kApproxStartPlace;
  }

  void drawApproxes(
    Map<Approximations, ApproximationResult> approxes,
    Approximations bestApproxType,
  ) {
    _removeApproxes();

    approxes.forEach((type, result) {
      if (result.approxFunction.isNotEmpty) {
        _maxApprox++;
        if (type == bestApproxType) {
          drawGraph(
            result.approxFunction,
            min: currentMinX,
            max: currentMaxX,
            isAccent: true,
          );
        } else {
          drawGraph(
            result.approxFunction,
            min: currentMinX,
            max: currentMaxX,
            isGreyed: true,
          );
        }
      }
    });
  }

  void hideAllApproxes() => _hideGraphs(_kApproxStartPlace, _maxApprox);

  void showAllApproxes() => _showGraphs(_kApproxStartPlace, _maxApprox);

  void _showGraphs(int from, int to) {
    for (var i = from; i < to; i++) {
      if (graphCache.containsKey(i)) {
        _lines.insert(i, graphCache[i]!);
        graphCache.remove(i);
      }
    }
  }

  void _hideGraphs(int from, int to) {
    for (var i = from; i < to; i++) {
      graphCache[i] = _lines[i];
    }

    _lines.removeRange(from, to);
  }

  void drawGraph(
    Equation equation, {
    bool isAccent = false,
    bool isGreyed = false,
    double min = _kDefaultMin,
    double max = _kDefaultMax,
    double accuracy = 0.01,
  }) {
    List<FlSpot> dots = [];
    for (var i = min; i < max; i += accuracy) {
      if (equation.compute(i) < gridMaxY && equation.compute(i) > gridMinY) {
        dots.add(FlSpot(i, equation.compute(i)));
      }
    }

    _lines.add(LineChartBarData(
      spots: dots,
      colors: [
        if (isAccent) Colors.black,
        if (isGreyed) Colors.grey,
      ],
      isCurved: true,
      dotData: FlDotData(
        show: false,
      ),
      dashArray: isGreyed ? [3, 2] : null,
    ));
  }

  void updateGridSize() {
    chartData.minX = (currentMinX - _kPaddingValue).ceilToDouble();
    chartData.maxX = (currentMaxX + _kPaddingValue).ceilToDouble();

    chartData.maxY = (currentMaxY + _kPaddingValue).ceilToDouble();
    chartData.minY = (currentMinY - _kPaddingValue).ceilToDouble();

    _drawAxisX();
    _drawAxisY();
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
    dots.addAll(kPlace == _kAxisXPlace
        ? [FlSpot(from, 0), FlSpot(to, 0)]
        : [FlSpot(0, from), FlSpot(0, to)]);

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

  double get gridMinX => chartData.minX;

  double get gridMaxX => chartData.maxX;

  double get gridMinY => chartData.minY;

  double get gridMaxY => chartData.maxY;
}
