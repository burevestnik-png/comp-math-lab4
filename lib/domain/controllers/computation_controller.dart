import 'package:comp_math_lab4/domain/approximations/linear_approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  void approximate(List<Dot> dots) {
    var a = LinearApproximation();

    a.process(dots);
  }
}
