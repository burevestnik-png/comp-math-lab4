import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linear_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/pow_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/quadratic_approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  final approximationFunctions = {
    Approximations.LINEAR: LinearApproximation(),
    Approximations.QUADRATIC: QuadraticApproximation(),
    Approximations.POW: PowApproximation(),
  };

  final lastApproxStandardDeviations = {
    Approximations.LINEAR: 0.0,
    Approximations.QUADRATIC: 0.0,
    Approximations.POW: 0.0,
  };

  void approximate(List<Dot> dots) {
    approximationFunctions.forEach((type, approx) {
      lastApproxStandardDeviations[type] = approx.process(dots);
    });

    print("SKO: $lastApproxStandardDeviations");
  }
}
