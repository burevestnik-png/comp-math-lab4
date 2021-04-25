import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';

abstract class LinearlyDependantApproximation extends Approximation {
  LinearlyDependantApproximation(Approximations type) : super(type);

  @override
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
    final r = calcPearsonCoefficient(dots);
    print('R: $r');

    return sqrt(sumOfDeviationSquares / dots.length.toDouble());
  }

  @override
  List<List<double>> createMatrix(List<Dot> dots) {
    var sx = sumByX(dots);
    var sxx = sumBySquaredX(dots);

    return [
      [sxx, sx],
      [sx, dots.length.toDouble()]
    ];
  }

  @override
  List<double> createResultVector(List<Dot> dots) {
    var sy = sumByY(dots);
    var sxy = sumByXY(dots);

    return [sxy, sy];
  }

  double calcPearsonCoefficient(List<Dot> dots) {
    double averageX = sumByX(dots) / dots.length.toDouble();
    double averageY = sumByY(dots) / dots.length.toDouble();

    double sumOfDiffXY = 0.0;
    double sumOfDiffXSquared = 0.0;
    double sumOfDiffYSquared = 0.0;
    dots.forEach((dot) {
      sumOfDiffXY += (dot.x - averageX) * (dot.y - averageY);
      sumOfDiffXSquared += pow((dot.x - averageX), 2);
      sumOfDiffYSquared += pow((dot.y - averageY), 2);
    });

    return sumOfDiffXY / sqrt(sumOfDiffYSquared * sumOfDiffXSquared);
  }
}
