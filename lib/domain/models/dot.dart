import 'package:fl_chart/fl_chart.dart';
import 'package:uuid/uuid.dart';

class Dot {
  final String id;
  final double x;
  final double y;

  Dot(this.x, this.y) : id = Uuid().v4();

  @override
  String toString() {
    return 'Dot{id: $id, x: $x, y: $y}';
  }
}

extension DotExtension on Dot {
  FlSpot toFlSpot() => FlSpot(this.x, this.y);
}

extension DotsExtension on List<Dot> {
  List<FlSpot> toFLSpots() {
    List<FlSpot> flSpots = [];
    for (Dot dot in this) {
      flSpots.add(dot.toFlSpot());
    }
    return flSpots;
  }
}
