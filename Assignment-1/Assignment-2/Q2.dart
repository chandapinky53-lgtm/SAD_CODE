//Write a dart program to check whether a character is a vowel or consonant.

import 'dart:io';

void main() {
  stdout.write("Enter a character: ");
  String ch = stdin.readLineSync()!.toLowerCase();

  if ('aeiou'.contains(ch)) {
    print("$ch is a Vowel");
  } else {
    print("$ch is a Consonant");
  }
}
