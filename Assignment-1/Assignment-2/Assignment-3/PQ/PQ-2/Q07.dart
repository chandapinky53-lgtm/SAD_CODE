//Create a map with name, phone keys and store some values to it. Use where to find all keys that have length 4.

void main() {
  Map<String, String> contacts = {
    "Messi": "12345",
    "Rolando": "67890",
    "D.beckham": "98765",
    "H.kane": "11223",
  };

  var result = contacts.keys.where((key) => key.length == 4);

  print("Keys with length 4:");
  for (var key in result) {
    print(key);
  }
}
