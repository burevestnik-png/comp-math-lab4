import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/center_rectangle_method.dart';
import 'package:comp_math_lab3/domain/models/methods/left_rectangle_method.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';
import 'package:comp_math_lab3/domain/models/methods/right_rectangle_method.dart';
import 'package:comp_math_lab3/domain/models/methods/simpson_method.dart';
import 'package:comp_math_lab3/domain/models/methods/trapezoid_method.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  final Map<Methods, Method> _methods = {
    Methods.LEFT_RECTANGLE: LeftRectangleMethod(),
    Methods.CENTER_RECTANGLE: CenterRectangleMethod(),
    Methods.RIGHT_RECTANGLE: RightRectangleMethod(),
    Methods.TRAPEZOID: TrapezoidMethod(),
    Methods.SIMPSON: SimpsonMethod(),
  };

  void solve({
    required Equation equation,
    required double a,
    required double b,
    required double accuracy,
    required int n,
    required Methods method,
  }) {
    _methods[method]!.solve(equation, a, b, accuracy, n);
  }
}
