//Write a program in Dart to remove all whitespaces from String.

import 'dart:io';

void main() {
  stdout.write('Enter a String : ');
  String text = stdin.readLineSync()!;

  String result = text.replaceAll(' ', '');
  print("Without Spaces : $result");
}
