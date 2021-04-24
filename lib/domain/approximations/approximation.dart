import 'dart:math';

import 'package:comp_math_lab4/domain/controllers/log_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:get/get.dart';

enum Approximations {
  LINEAR,
  QUADRATIC,
  POW,
  EXPONENTIAL,
  LOGARITHMIC,
}

abstract class Approximation {
  final logger = Get.find<LogController>();
  final Approximations type;

  Approximation(this.type);

  double process(List<Dot> dots);

  double sumByX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.x);

  double sumByY(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.y);

  double sumBySquaredX(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + pow(dot.x, 2));

  double sumByXY(List<Dot> dots) =>
      dots.fold(0.0, (previousValue, dot) => previousValue + dot.x * dot.y);
}
