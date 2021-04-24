import 'package:comp_math_lab4/domain/controllers/log_controller.dart';
import 'package:comp_math_lab4/domain/models/dot.dart';
import 'package:get/get.dart';

abstract class Approximation {
  final logger = Get.find<LogController>();

  void process(List<Dot> dots);
}
