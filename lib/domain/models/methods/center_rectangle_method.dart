import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/area_calc_depended_method.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';

class CenterRectangleMethod extends AreaCalcDependedMethod {
  CenterRectangleMethod() : super(Methods.CENTER_RECTANGLE) {
    areaCallback = (double h, Equation equation, double a) => (int i) {
          return h * equation.compute((a + i * h + a + (i + 1) * h) / 2);
        };

    areaFromToCallback = (Equation equation, double a, double b) {
      var ans = (b - a) * equation.compute((a + b) / 2);
      return ans;
    };
  }
}
