import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/linear_convertible_interface.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/exponential_token.dart';

class ExponentialApproximation extends LinearlyDependantApproximation
    implements ILinearConvertible {
  ExponentialApproximation() : super(Approximations.EXPONENTIAL);

  @override
  Equation createApproximatedFunction(List<double> factors) => Equation([
        ExponentialToken(pow(e, factors.last).toDouble(), factors.first),
      ]);

  @override
  List<Dot> modifyDots(List<Dot> dots) {
    return dots.map((e) => Dot(e.x, log(e.y))).toList();
  }

  @override
  List<double>? solveLinearSystem(List<Dot> dots) {
    List<Dot> modifiedDots = modifyDots(dots);
    return LinearSystemSolver.compute(
        createMatrix(modifiedDots), createResultVector(modifiedDots));
  }
}
