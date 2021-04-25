import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';

abstract class LinearlyDependantApproximation extends Approximation {
  LinearlyDependantApproximation(Approximations type) : super(type);

  @override
  double process(List<Dot> dots) {
    var solutions = LinearSystemSolver.compute(
        createMatrix(dots), createResultVector(dots));
    if (solutions == null) {
      logger.println("No solutions or unlimited solutions");
      return -1;
    }

    final phi = createApproximatedFunction(solutions);
    final sumOfDeviationSquares = calculateSumOfSquaredDeviations(dots, phi);
    final r = calcPearsonCoefficient(dots);

    return sqrt(sumOfDeviationSquares / dots.length.toDouble());
  }

  double calcPearsonCoefficient(List<Dot> dots);
}
