import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/area_calc_depended_method.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';

class LeftRectangleMethod extends AreaCalcDependedMethod {
  LeftRectangleMethod() : super(Methods.LEFT_RECTANGLE) {
    areaCallback = (double h, Equation equation, double a) =>
        (int i) => h * equation.compute(a + i * h);

    areaFromToCallback = (Equation equation, double a, double b) =>
        (b - a) * equation.compute(a);
  }
}
