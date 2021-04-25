import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/math/linear_system_solver.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/linear_token.dart';

class LinearApproximation extends LinearlyDependantApproximation {
  LinearApproximation() : super(Approximations.LINEAR);

  @override
  double process(List<Dot> dots) {
    double sx = sumByX(dots);
    double sy = sumByY(dots);
    double sxx = sumBySquaredX(dots);
    double sxy = sumByXY(dots);

    var solutions = LinearSystemSolver.compute([
      [sxx, sx],
      [sx, dots.length.toDouble()]
    ], [
      sxy,
      sy
    ]);

    if (solutions == null) {
      logger.println("No or unlimited solutions");
      return -1;
    }

    final Equation phi = Equation([
      LinearToken(solutions[0]),
      ConstToken(solutions[1]),
    ]);

    double sumOfDeviationSquares = dots.fold(
      0.0,
      (previousValue, dot) =>
          previousValue + pow(phi.compute(dot.x) - dot.y, 2),
    );
    print('Sun: $sumOfDeviationSquares');

    double averageX = sx / dots.length.toDouble();
    double averageY = sy / dots.length.toDouble();

    double sumOfDiffXY = 0.0;
    double sumOfDiffXSquared = 0.0;
    double sumOfDiffYSquared = 0.0;
    dots.forEach((dot) {
      sumOfDiffXY += (dot.x - averageX) * (dot.y - averageY);
      sumOfDiffXSquared += pow((dot.x - averageX), 2);
      sumOfDiffYSquared += pow((dot.y - averageY), 2);
    });
    double r = sumOfDiffXY / sqrt(sumOfDiffYSquared * sumOfDiffXSquared);
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

  @override
  Equation createApproximatedFunction(List<double> factors) {
    return Equation([
      LinearToken(factors[0]),
      ConstToken(factors[1]),
    ]);
  }

  @override
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
