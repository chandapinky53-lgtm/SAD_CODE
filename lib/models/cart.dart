import 'supplement.dart';

class Cart {
  static List<Supplement> cartItems = [];

  static void addItem(Supplement item) {
    cartItems.add(item);
  }

  static void removeItem(Supplement item) {
    cartItems.remove(item);
  }

  static double get total =>
      cartItems.fold(0, (sum, item) => sum + item.price);
}
