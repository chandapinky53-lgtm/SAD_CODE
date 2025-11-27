//Suppose, you often go to restaurant with friends and you have to split amount of bill. Write a program to calculate split amount of bill. Formula= (total bill amount) / number of people

import 'dart:io';

void main() {
  stdout.write("Enter the total bill: ");
  double total = double.parse(stdin.readLineSync()!);
  stdout.write("Enter number of people: ");
  double people = double.parse(stdin.readLineSync()!);
  double split = total / people;
  print('Each person pays: $split');
}
