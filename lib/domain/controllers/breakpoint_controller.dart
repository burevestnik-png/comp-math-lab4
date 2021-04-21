import 'package:comp_math_lab3/domain/models/equation.dart';

class BreakpointController {
  static double? findBreakpoint(
    Equation equation, {
    double a = -15,
    double b = 15,
    double accuracy = 0.01,
  }) {
    for (double i = a; i <= b; i += 0.5) {
      if (equation.compute(i).isNaN || equation.compute(i).isInfinite) {
        return i;
      }
    }
  }
}
