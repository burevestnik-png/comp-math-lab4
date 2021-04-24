import 'package:comp_math_lab4/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/models/equation.dart';
import 'package:comp_math_lab4/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab4/domain/models/tokens/polynomial_token.dart';
import 'package:comp_math_lab4/domain/state/state.dart';
import 'package:get/get.dart';

class MainScreenState extends IState {
  final _drawingController = Get.find<DrawingController>();

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

  final dots = <Dot>[
    Dot(1, 1),
    Dot(1, 1),
    Dot(1, 1),
  ].obs;

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
}
