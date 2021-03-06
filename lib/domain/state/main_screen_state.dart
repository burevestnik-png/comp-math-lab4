import 'package:comp_math_lab4/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab4/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:comp_math_lab4/domain/state/state.dart';
import 'package:get/get.dart';

class MainScreenState extends IState {
  final _drawingController = Get.find<DrawingController>();
  final _computationController = Get.find<ComputationController>();

  final selectedDots = <Dot>[].obs;

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
