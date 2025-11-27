//Write a program to print full name of a from first name and last name using user input.

import 'dart:io';

void main() {
  stdout.write("Enter first name: ");
  String firstName = stdin.readLineSync()!;

  stdout.write("Enter last name: ");
  String lastName = stdin.readLineSync()!;

  String fullName = '$firstName $lastName';

  print('Full Name: $fullName');
}
