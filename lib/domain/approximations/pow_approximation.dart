import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';

class PowApproximation extends Approximation {
  PowApproximation() : super(Approximations.POW);

  @override
  double process(List<Dot> dots) {
    return 0.0;
  }

  @override
  List<List<double>> createMatrix(List<Dot> dots) {
    // TODO: implement createMatrix
    throw UnimplementedError();
  }

  @override
  List<double> createResultVector(List<Dot> dots) {
    // TODO: implement createResultVector
    throw UnimplementedError();
  }

  @override
  Equation createApproximatedFunction(List<double> factors) {
    // TODO: implement createApproximatedFunction
    throw UnimplementedError();
  }
}
