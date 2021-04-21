import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/area_calc_depended_method.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';

class TrapezoidMethod extends AreaCalcDependedMethod {
  TrapezoidMethod() : super(Methods.TRAPEZOID) {
    areaCallback = (double h, Equation equation, double a) => (int i) =>
        h /
        2 *
        (equation.compute(a + i * h) + equation.compute(a + (i + 1) * h));

    areaFromToCallback = (Equation equation, double a, double b) =>
        (b - a) / 2 * (equation.compute(a) + equation.compute(b));
  }
}
