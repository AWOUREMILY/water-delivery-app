class CartService {
  static final List<Map<String, dynamic>> _cartItems = [];

  Future<void> addToCart(
    String uid,
    Map<String, dynamic> item,
  ) async {
    _cartItems.add(item);
  }

  List<Map<String, dynamic>> getCartItems() {
    return _cartItems;
  }

  Future<void> clearCart(String uid) async {
    _cartItems.clear();
  }
}