import 'package:comp_math_lab4/domain/models/dot.dart';

abstract class IApproxLifecycle {
  List<Dot> initDots(List<Dot> dots) => dots;

  void processDuring(List<Dot> dots) {}
}
