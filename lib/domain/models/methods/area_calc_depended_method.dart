import 'package:comp_math_lab3/domain/controllers/breakpoint_controller.dart';
import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';

abstract class AreaCalcDependedMethod extends Method {
  double Function(int) Function(double, Equation, double) areaCallback;
  double Function(Equation, double, double) areaFromToCallback;

  static double Function(int) _defaultCallback(
          double h, Equation equation, double a) =>
      (int i) => 0.0;

  static double _default(Equation equation, double a, double b) => 0.0;

  AreaCalcDependedMethod(
    Methods type, [
    this.areaCallback = _defaultCallback,
    this.areaFromToCallback = _default,
  ]) : super(type);

  @override
  double findArea(Equation equation, double a, double h, int n) {
    var bindedAreaCallback = areaCallback(h, equation, a);
    var possibleBreakpoint =
        BreakpointController.findBreakpoint(equation, a: a, b: a + h * n);

    var area = 0.0;

    if (possibleBreakpoint == null) {
      for (int i = 0; i < n; i++) {
        area += bindedAreaCallback(i);
      }
    } else {
      var epsilon = 0.000001;
      var firstCut = possibleBreakpoint - epsilon;
      // var secondCut = a + n * h - (possibleBreakpoint + epsilon);

      for (int i = 0; i < n / 2 - 1; i++) {
        area += bindedAreaCallback(i);
      }
      var stoppedPoint = a + h * (n / 2 - 1);
      var debug = firstCut - stoppedPoint;
      area +=
          areaFromToCallback(equation, stoppedPoint, stoppedPoint + firstCut);

      stoppedPoint = a + h * (n ~/ 2 + 1);
      area +=
          areaFromToCallback(equation, firstCut + 2 * epsilon, stoppedPoint);
      for (int i = n ~/ 2 + 1; i < n; i++) {
        area += bindedAreaCallback(i);
      }
    }

    return area;
  }
}
