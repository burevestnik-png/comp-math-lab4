class LinearToken extends Token {
  LinearToken(double factor) : super(factor);

  LinearToken.basic() : this(1.0);

  // LinearToken.basicNeg() : this(-1.0);

  @override
  double compute(double x) => factor * x;

  @override
  String toString() => '$factor * x';
}
