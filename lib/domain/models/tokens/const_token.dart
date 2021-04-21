class ConstToken extends Token {
  ConstToken(double factor) : super(factor);

  @override
  double compute(double x) => factor;

  @override
  String toString() => factor.toString();
}
