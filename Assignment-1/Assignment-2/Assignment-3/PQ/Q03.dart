//3.Create a function called greet that takes a name as an argument and prints a greeting message. For example, greet(“John”) should print “Hello, John”.

void main() {
  greet(name: "Jhon");
}

void greet({required String name}) {
  print("Hello, $name!");
}
