import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/calculator_logic.dart';

void main() {
  final calculator = Calculator();

  // Test 1: Addition of two positive numbers should return their sum.
  test('add() returns the sum of two positive numbers', () {
    expect(calculator.add(2, 3), 5);
  });

  // Test 2: Subtraction should correctly handle a negative result
  // (second operand larger than the first).
  test('subtract() returns a negative result when b > a', () {
    expect(calculator.subtract(4, 10), -6);
  });

  // Test 3: Multiplication involving a negative number should return
  // a negative product.
  test('multiply() returns a negative product when one operand is negative', () {
    expect(calculator.multiply(-3, 6), -18);
  });

  // Test 4: Division of two numbers should return the correct quotient,
  // including non-integer results.
  test('divide() returns the correct quotient, including decimals', () {
    expect(calculator.divide(7, 2), 3.5);
  });

  // Test 5: Dividing by zero is undefined for this calculator, so it
  // should throw an ArgumentError instead of returning infinity/NaN.
  test('divide() throws ArgumentError when dividing by zero', () {
    expect(() => calculator.divide(5, 0), throwsArgumentError);
  });
}
