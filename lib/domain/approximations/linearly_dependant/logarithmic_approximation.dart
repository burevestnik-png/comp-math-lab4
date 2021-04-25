import 'dart:math';

import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/polynomial_token.dart';

class LogarithmicApproximation extends LinearlyDependantApproximation {
  LogarithmicApproximation() : super(Approximations.LOGARITHMIC);

  @override
  Equation createApproximatedFunction(List<double> factors) => Equation([
        PolynomialToken.logarithmic(factors.first),
        ConstToken(factors.last),
      ]);

  @override
  List<Dot> modifyDots(List<Dot> dots) {
    return dots.map((e) => Dot(log(e.x), e.y)).toList();
  }
}
