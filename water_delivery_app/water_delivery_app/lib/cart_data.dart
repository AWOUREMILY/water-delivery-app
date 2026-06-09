import 'cart_model.dart';

List<CartItem> cartItems = [];

int getTotalPrice() {
  int total = 0;

  for (var item in cartItems) {
    total += item.price * item.quantity;
  }

  return total;
}