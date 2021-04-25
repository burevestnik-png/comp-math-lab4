import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';

abstract class LinearlyDependantApproximation extends Approximation {
  LinearlyDependantApproximation(Approximations type) : super(type);

  @override
  void processDuring(List<Dot> dots) {
    final r = calcPearsonCoefficient(dots);
    print('r: $r');
  }

  List<double>? solveLinearSystem(List<Dot> dots) {
    var modifiedDots = modifyDots(dots);
    return super.solveLinearSystem(modifiedDots);
  }

  List<Dot> modifyDots(List<Dot> dots) => dots;

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
