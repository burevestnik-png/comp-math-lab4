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
