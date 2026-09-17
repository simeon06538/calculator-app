/// Pure arithmetic logic for the calculator, kept separate from the UI
/// so it can be unit tested without needing a widget tree.
class Calculator {
  double add(double a, double b) => a + b;

  double subtract(double a, double b) => a - b;

  double multiply(double a, double b) => a * b;

  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero');
    }
    return a / b;
  }

  /// Applies [operator] to [a] and [b]. Used by the UI so button
  /// presses can route through a single entry point.
  double calculate(double a, double b, String operator) {
    switch (operator) {
      case '+':
        return add(a, b);
      case '-':
        return subtract(a, b);
      case '×':
      case '*':
        return multiply(a, b);
      case '÷':
      case '/':
        return divide(a, b);
      default:
        throw ArgumentError('Unknown operator: $operator');
    }
  }
}
