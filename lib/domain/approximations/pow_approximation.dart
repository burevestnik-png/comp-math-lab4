import 'package:comp_math_lab4/domain/approximations/approximation.dart';
import 'package:comp_math_lab4/domain/approximations/linear_convertable_interface.dart';
import 'package:comp_math_lab4/domain/approximations/linearly_dependant_approximation.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';

class PowApproximation extends LinearlyDependantApproximation
    implements ILinearConvertible {
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

  @override
  List<Dot> modifyDots(List<Dot> dots) {
    // TODO: implement modifyDots
    throw UnimplementedError();
  }

  @override
  double calcPearsonCoefficient(List<Dot> dots) {
    // TODO: implement calcPearsonCoefficient
    throw UnimplementedError();
  }
}
