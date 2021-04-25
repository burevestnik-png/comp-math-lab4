import 'dart:math';

import 'package:comp_math_lab4/domain/controllers/log_controller.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:get/get.dart';

enum Approximations {
  LINEAR,
  QUADRATIC,
  POW,
  EXPONENTIAL,
  LOGARITHMIC,
}

abstract class Approximation {
  final logger = Get.find<LogController>();
  final Approximations type;

  Approximation(this.type);

  double process(List<Dot> dots) {
    var solutions = solveLinearSystem(dots);
    if (solutions == null) {
      logger.println("No solutions or unlimited solutions");
      return -1;
    }
    print('Solutions: $solutions');

    final phi = createApproximatedFunction(solutions);
    print('Phi: $phi');
    final sumOfDeviationSquares = calculateSumOfSquaredDeviations(dots, phi);
    print('S: $sumOfDeviationSquares');

    return sqrt(sumOfDeviationSquares / dots.length.toDouble());
  }

  List<double>? solveLinearSystem(List<Dot> dots) => LinearSystemSolver.compute(
        createMatrix(dots),
        createResultVector(dots),
      );

  List<List<double>> createMatrix(List<Dot> dots);

  List<double> createResultVector(List<Dot> dots);

  Equation createApproximatedFunction(List<double> factors);

  double calculateSumOfSquaredDeviations(List<Dot> dots, Equation equation) =>
      dots.fold(
          0.0,
          (previousValue, dot) =>
              previousValue + pow(equation.compute(dot.x) - dot.y, 2));

  double sumByX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.x);

  double sumByY(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.y);

  double sumBySquaredX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + pow(dot.x, 2));

  double sumByXY(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.x * dot.y);
}
