import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
}
