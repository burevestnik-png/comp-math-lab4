import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/linear_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/polynomial_token.dart';

class QuadraticApproximation extends Approximation {
  QuadraticApproximation() : super(Approximations.QUADRATIC);

  double sumByCubedX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + pow(dot.x, 3));

  double sumByFourthDegreeX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + pow(dot.x, 4));

  double sumByYAndSquaredX(List<Dot> dots) => dots.fold(
      0.0, (previousValue, dot) => previousValue + dot.y * pow(dot.x, 2));

  @override
  List<List<double>> createMatrix(List<Dot> dots) {
    var sx = sumByX(dots);
    var sxx = sumBySquaredX(dots);
    var s3x = sumByCubedX(dots);
    var s4x = sumByFourthDegreeX(dots);

    return [
      [dots.length.toDouble(), sx, sxx],
      [sx, sxx, s3x],
      [sxx, s3x, s4x]
    ];
  }

  @override
  List<double> createResultVector(List<Dot> dots) {
    var sy = sumByY(dots);
    var sxy = sumByXY(dots);
    var sxxy = sumByYAndSquaredX(dots);

    return [sy, sxy, sxxy];
  }

  @override
  Equation createApproximatedFunction(List<double> factors) {
    return Equation([
      PolynomialToken.basicPos(
        power: 2.0,
        factor: factors.last,
      ),
      LinearToken(factors[1]),
      ConstToken(factors.first),
    ]);
  }
}
