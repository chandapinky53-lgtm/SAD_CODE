//Write a Dart program to convert String to int.
import 'dart:io';

void main() {
  stdout.write("Enter a number as String: ");
  String strNum = stdin.readLineSync()!;
  int number = int.parse(strNum);
  print('Integer value: $number');
}
