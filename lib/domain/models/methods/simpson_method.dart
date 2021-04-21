import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';
import 'package:comp_math_lab3/domain/utils/pair.dart';

class SimpsonMethod extends Method {
  SimpsonMethod() : super(Methods.SIMPSON);

  @override
  double findArea(Equation equation, double a, double h, int n) {
    List<Pair<double, double>> dots = _formDots(equation, a, h, n);

    double oddSum = 0;
    double evenSum = 0;
    for (var i = 1; i < n; i++) {
      if (i % 2 == 1)
        oddSum += dots[i].value;
      else
        evenSum += dots[i].value;
    }

    return h / 3 * (dots[0].value + 4 * oddSum + 2 * evenSum + dots[n].value);
  }

  List<Pair<double, double>> _formDots(
    Equation equation,
    double a,
    double h,
    int n,
  ) {
    List<Pair<double, double>> dots = [];
    for (var i = 0; i <= n; i++) {
      dots.add(Pair(a + i * h, equation.compute(a + i * h)));
    }
    return dots;
  }
}
