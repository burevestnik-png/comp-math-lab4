import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/exponential_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/linear_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/logarithmic_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant/pow_approximation.dart';
import 'package:comp_math_lab4/domain/approximations/quadratic_approximation.dart';
import 'package:comp_math_lab4/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab4/domain/controllers/log_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/utils/pair.dart';
import 'package:get/get.dart';

class ApproximationResult {
  final double standardDeviation;
  final Equation approxFunction;

  ApproximationResult(this.standardDeviation, this.approxFunction);

  ApproximationResult.empty() : this(double.infinity, Equation([]));

  @override
  String toString() {
    return 'ApproximationResult{std: $standardDeviation, phi: $approxFunction}';
  }
}

class ComputationController extends GetxController {
  final logger = Get.find<LogController>();
  final drawController = Get.find<DrawingController>();

  final approximationFunctions = {
    Approximations.LINEAR: LinearApproximation(),
    Approximations.QUADRATIC: QuadraticApproximation(),
    Approximations.POW: PowApproximation(),
    Approximations.EXPONENTIAL: ExponentialApproximation(),
    Approximations.LOGARITHMIC: LogarithmicApproximation()
  };

  final lastApproxStandardDeviations = {
    Approximations.LINEAR: ApproximationResult.empty(),
    Approximations.QUADRATIC: ApproximationResult.empty(),
    Approximations.POW: ApproximationResult.empty(),
    Approximations.EXPONENTIAL: ApproximationResult.empty(),
    Approximations.LOGARITHMIC: ApproximationResult.empty()
  };

  Pair<Approximations, ApproximationResult> findBestApprox(
      Map<Approximations, ApproximationResult> lastResults) {
    ApproximationResult best = ApproximationResult.empty();
    var typeOfBest = Approximations.LINEAR;

    lastResults.forEach((type, result) {
      if (result.standardDeviation < best.standardDeviation &&
          result.approxFunction.isNotEmpty) {
        best = result;
        typeOfBest = type;
      }
    });
    return Pair(typeOfBest, best);
  }

  void approximate(List<Dot> dots) {
    logger.println("Started to search the best approximation...");

    approximationFunctions.forEach((type, approx) {
      lastApproxStandardDeviations[type] = approx.process(dots);
      logger.println();
    });

    var bestApprox = findBestApprox(lastApproxStandardDeviations);
    logger.println("Best approx is in ${bestApprox.key}");
    logger.println("And equals: ${bestApprox.value.standardDeviation}");

    drawController.drawApproxes(lastApproxStandardDeviations, bestApprox.key);
  }
}
