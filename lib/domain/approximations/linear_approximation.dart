import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';

class LinearApproximation extends Approximation {
  @override
  void process(List<Dot> dots) {
    double sx =
        dots.fold(0.0, (previousValue, element) => previousValue + element.x);

    double sy =
        dots.fold(0.0, (previousValue, element) => previousValue + element.y);

    double sxx = dots.fold(
        0.0, (previousValue, element) => previousValue + pow(element.x, 2));
    double sxy = dots.fold(
        0.0, (previousValue, element) => previousValue + element.x * element.y);

    print('Solutions: ${LinearSystemSolver.compute([
      [sxx, sx],
      [sx, dots.length.toDouble()]
    ], [
      sxy,
      sy,
    ])}');
  }
}
