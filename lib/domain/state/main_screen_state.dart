import 'package:comp_math_lab4/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab4/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/polynomial_token.dart';
import 'package:comp_math_lab4/domain/state/state.dart';
import 'package:get/get.dart';

class MainScreenState extends IState {
  final _drawingController = Get.find<DrawingController>();
  final _computationController = Get.find<ComputationController>();

  final equations = <Equation>[
    Equation([
      PolynomialToken.basicPos(power: 2.0, factor: 1.0),
    ]),
    Equation([
      PolynomialToken.basicPos(power: 3, factor: 1),
      PolynomialToken.basicPos(power: 2, factor: 2),
      PolynomialToken.basicNeg(power: 1, factor: 3),
      ConstToken(-12),
    ]),
    Equation([
      PolynomialToken.basicPos(power: 5, factor: 2),
      PolynomialToken.basicPos(power: 2, factor: 6),
      PolynomialToken.basicNeg(power: 1, factor: 6),
      ConstToken(-3),
    ]),
    Equation([
      PolynomialToken.basicPos(power: -1, factor: 1),
    ]),
  ];

  final selectedDots = <Dot>[].obs;

  /*final dots = <Dot>[
    Dot(1.2, 7.4),
    Dot(2.9, 9.5),
    Dot(4.1, 11.1),
    Dot(5.5, 12.9),
    Dot(6.7, 14.6),
    Dot(7.8, 17.3),
    Dot(9.2, 18.2),
    Dot(10.3, 20.7),
  ].obs;*/

  /*final dots = <Dot>[
    Dot(1.1, 3.5),
    Dot(2.3, 4.1),
    Dot(3.7, 5.2),
    Dot(4.5, 6.9),
    Dot(5.4, 8.3),
    Dot(6.8, 14.8),
    Dot(7.5, 21.2),
  ].obs;*/

  final dots = <Dot>[
    Dot(1.1, 2.73),
    Dot(2.3, 5.12),
    Dot(3.7, 7.74),
    Dot(4.5, 8.91),
    Dot(5.4, 10.59),
    Dot(6.8, 12.75),
    Dot(7.5, 13.43),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    redrawGraph();
  }

  void addDot(double x, double y) {
    dots.add(Dot(x, y));
    dots.sort((first, second) => first.x.compareTo(second.x));
    redrawGraph();
  }

  void deleteSelectedDots() {
    if (selectedDots.isNotEmpty) {
      var tmpDots = <Dot>[].obs;

      tmpDots.addAll(selectedDots);
      for (Dot dot in tmpDots) {
        dots.remove(dot);
        selectedDots.remove(dot);
      }

      redrawGraph();
    }
  }

  void deleteAllDots() {
    selectedDots.clear();
    dots.clear();
    redrawGraph();
  }

  void redrawGraph() {
    _drawingController.drawTableGraph(dots.toList());
  }

  void compute() {
    _computationController.approximate(dots.toList());
  }
}
