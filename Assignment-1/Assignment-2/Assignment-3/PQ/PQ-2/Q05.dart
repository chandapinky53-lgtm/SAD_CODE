//Add your 7 friend names to the list. Use where to find a name that starts with alphabet a.
void main() {
  List<String> friends = [
    "Ayshee",
    "Nilima",
    "Srishty",
    "Tonny",
    "Hafsa",
    "Anupom",
  ];

  var aNames = friends.where((name) => name.startsWith('A'));

  print("Friends starting with A:");
  for (var name in aNames) {
    print(name);
  }
}
