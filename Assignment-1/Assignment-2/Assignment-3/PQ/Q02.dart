//2. Print even numbers between intervals using function
void main() {
  printEvenNumber(1, 100);
}

void printEvenNumber(int start, int end) {
  for (int i = start; i <= end; i++) {
    if (i % 2 == 0) {
      print(i);
    }
  }
}
