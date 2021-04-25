import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linear_convertable_interface.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/power_token.dart';

class PowApproximation extends LinearlyDependantApproximation
    implements ILinearConvertible {
  PowApproximation() : super(Approximations.POW);

  @override
  List<Dot> modifyDots(List<Dot> dots) {
    return dots.map((e) => Dot(log(e.x), log(e.y))).toList();
  }

  @override
  List<double>? solveLinearSystem(List<Dot> dots) {
    List<Dot> modifiedDots = modifyDots(dots);
    return LinearSystemSolver.compute(
        createMatrix(modifiedDots), createResultVector(modifiedDots));
  }

  @override
  Equation createApproximatedFunction(List<double> factors) => Equation([
        PowerToken(pow(e, factors.last).toDouble(), factors.first),
      ]);
}
