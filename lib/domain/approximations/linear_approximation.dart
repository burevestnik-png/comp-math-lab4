import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/linear_token.dart';

class LinearApproximation extends LinearlyDependantApproximation {
  LinearApproximation() : super(Approximations.LINEAR);

  @override
  Equation createApproximatedFunction(List<double> factors) {
    return Equation([
      LinearToken(factors[0]),
      ConstToken(factors[1]),
    ]);
  }
}
