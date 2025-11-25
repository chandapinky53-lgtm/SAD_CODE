//Write a program in Dart that finds simple interest. Formula= (p * t * r) / 100

import 'dart:io';

void main() {
  stdout.write("Enter principal ammount: ");
  double p = double.parse(stdin.readLineSync()!);

  stdout.write("Enter time(in years): ");
  double t = double.parse(stdin.readLineSync()!);

  stdout.write("Enter rate of interest ");
  double r = double.parse(stdin.readLineSync()!);

  double si = (p * t * r) / 100;
  print('Simple Interest = $si');
}
