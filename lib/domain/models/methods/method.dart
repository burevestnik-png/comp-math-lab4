import 'package:comp_math_lab3/domain/controllers/log_controller.dart';
import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:get/get.dart';

enum Methods {
  LEFT_RECTANGLE,
  CENTER_RECTANGLE,
  RIGHT_RECTANGLE,
  TRAPEZOID,
  SIMPSON
}

extension MethodToString on Methods {
  String toStr() => this.toString().substring(this.toString().indexOf('.') + 1);
}

abstract class Method {
  final logService = Get.find<LogController>();
  final Methods type;

  Method(this.type);

  void solve(
    Equation equation,
    double a,
    double b,
    double accuracy,
    int n,
  ) {
    logService.println("Calculating: $equation");
    logService.println("By ${type.toStr()} method");
    logService.println();

    var h = findStep(a, b, n.toDouble());
    var iterations = 1;

    if (type == Methods.SIMPSON) n = n % 2 == 1 ? n + 1 : n;

    double resultForN = 0.0;
    double resultFor2N = findArea(equation, a, h, n);
    do {
      h /= 2;
      n *= 2;

      resultForN = resultFor2N;
      resultFor2N = findArea(equation, a, h, n);
      iterations++;
    } while ((resultForN - resultFor2N).abs() > accuracy);

    logService.println("Answer is: $resultFor2N");
    logService.println("Was computed by $iterations iterations");
    logService.println("Entered accuracy was reached on n = $n");
    logService.printdln();
  }

  double findStep(double a, double b, double n) => (b - a) / n;

  double findArea(
    Equation equation,
    double a,
    double h,
    int n,
  );
}
