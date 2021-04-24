class LinearSystemSolver {
  static List<double>? compute(
    List<List<double>> matrix,
    List<double> resultsVector,
  ) {
    var results = List<double>.filled(matrix.length, 0);
    for (var i = 0; i < matrix.length; i++) {
      var max = i;
      for (var j = i + 1; j < matrix.length; j++) {
        if (matrix[j][i].abs() > matrix[max][i]) max = j;
      }

      matrix.swap(i, max);
      resultsVector.swap(i, max);

      if (matrix[i][i].abs() <= 1e-10) return null;

      for (var j = i + 1; j < matrix.length; j++) {
        var alpha = matrix[j][i] / matrix[i][i];
        resultsVector[j] -= alpha * resultsVector[i];
        for (var n = i; n < matrix.length; n++) {
          matrix[j][n] -= alpha * matrix[i][n];
        }
      }

      for (var i = matrix.length - 1; i >= 0; i--) {
        var sum = 0.0;
        for (var j = i + 1; j < matrix.length; j++) {
          sum += matrix[i][j] * results[j];
        }
        results[i] = (resultsVector[i] - sum) / matrix[i][i];
      }
    }

    return results;
  }
}

extension ListSwap<T> on List<T> {
  void swap(int index1, int index2) {
    var length = this.length;
    RangeError.checkValidIndex(index1, this, "index1", length);
    RangeError.checkValidIndex(index2, this, "index2", length);
    if (index1 != index2) {
      var tmp1 = this[index1];
      this[index1] = this[index2];
      this[index2] = tmp1;
    }
  }
}
