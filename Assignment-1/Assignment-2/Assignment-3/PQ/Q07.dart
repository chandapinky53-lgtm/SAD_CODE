//Write a program in Dart to calculate power of a certain number. For e.g 5^3=125

import 'dart:math';

num power(num base, num exponent) {
  return pow(base, exponent);
}

void main() {
  print(power(5, 3));
}
