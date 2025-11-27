//Write a program to find quotient and remainder of two integers.

import 'dart:io';

void main() {
  stdout.write("Enter first integer number: ");
  int a = int.parse(stdin.readLineSync()!);
  stdout.write("Enter second integer number: ");
  int b = int.parse(stdin.readLineSync()!);

  int quotient = a ~/ b;
  int remainder = a % b;

  print('Quotient = $quotient');
  print('Remainder = $remainder');
}
