import 'package:comp_math_lab3/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab3/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab3/domain/models/equation.dart';
import 'package:comp_math_lab3/domain/models/methods/method.dart';
import 'package:comp_math_lab3/domain/models/tokens/const_token.dart';
import 'package:comp_math_lab3/domain/models/tokens/polynomial_token.dart';
import 'package:comp_math_lab3/domain/state/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  late Rx<Equation> currentEquation;
  var method = Methods.LEFT_RECTANGLE.obs;
  var a = (-5.0).obs;
  var b = 5.0.obs;
  var accuracy = 0.01.obs;
  var n = 4.obs;

  final aController = TextEditingController();
  final bController = TextEditingController();
  final accuracyController = TextEditingController();
  final nController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    currentEquation = equations[0].obs;
    _restoreFieldControllers();
  }

  void reset() {
    a.value = -5.0;
    b.value = 5.0;
    accuracy.value = 0.01;
    n.value = 4;

    _restoreFieldControllers();
  }

  void _restoreFieldControllers() {
    aController.text = a.value.toStringAsFixed(0);
    bController.text = b.value.toStringAsFixed(0);
    accuracyController.text = accuracy.value.toString();
    nController.text = n.value.toString();
    _redraw();
  }

  void onDoubleFieldChange(
    String value, {
    required RxDouble obs,
  }) {
    var parsedValue = double.tryParse(value);
    if (parsedValue == null) return;

    obs.value = parsedValue;
    if (isBordersCorrect() && isAccuracyCorrect()) _redraw();
  }

  void onIntFieldChange(
    String value, {
    required RxInt obs,
  }) {
    var parsedValue = int.tryParse(value);
    if (parsedValue == null) return;

    obs.value = parsedValue;
    if (isNCorrect()) _redraw();
  }

  bool isBordersCorrect() => a.value < b.value;

  bool isAccuracyCorrect() => accuracy.value >= 0.01 && accuracy.value <= 1;

  bool isNCorrect() => n.value >= 1 && n.value <= 1000;

  void onEquationChange(Equation value) {
    currentEquation.value = value;
    _redraw();
  }

  void onComputeAction() {
    if (!isInputFieldsCorrect()) return;
    _computationController.solve(
      equation: currentEquation.value,
      a: a.value,
      b: b.value,
      accuracy: accuracy.value,
      n: n.value,
      method: method.value,
    );
  }

  bool isInputFieldsCorrect() {
    if (!isBordersCorrect()) {
      EasyLoading.showError("Borders input is incorrect", dismissOnTap: true);
      return false;
    }

    if (!isAccuracyCorrect()) {
      EasyLoading.showError("Accuracy input is incorrect", dismissOnTap: true);
      return false;
    }

    if (!isNCorrect()) {
      EasyLoading.showError("n input is incorrect", dismissOnTap: true);
      return false;
    }

    return true;
  }

  void onMethodChange(Methods value) => method.value = value;

  void _redraw() => _drawingController.drawGraph(
        currentEquation.value,
        min: a.value,
        max: b.value,
        accuracy: accuracy.value,
      );
}
