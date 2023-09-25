import 'package:flutter_test/flutter_test.dart';
import 'package:widget_test_practice/algorithem/prime_number.dart';

void main() {
  test('test number 1', () {
    expect(getPrimeFactors(1), []);
  });

  test('test number 2', () {
    expect(getPrimeFactors(2), [2]);
  });

  test('test number 3', () {
    expect(getPrimeFactors(3), [3]);
  });

  test('test number 4', () {
    expect(getPrimeFactors(4), [2, 2]);
  });

  test('test number 5', () {
    expect(getPrimeFactors(5), [5]);
  });

  test('test number 6', () {
    expect(getPrimeFactors(6), [2, 3]);
  });

  test('test number 8', () {
    expect(getPrimeFactors(8), [2, 2, 2]);
  });

  test('test number 9', () {
    expect(getPrimeFactors(9), [3, 3]);
  });
}
