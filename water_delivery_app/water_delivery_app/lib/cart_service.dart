import 'database_helper.dart';


class CartService {



  // Add item to cart / create order
  Future<void> addToCart(
      String uid,
      Map<String, dynamic> item) async {


    final db =
        await DatabaseHelper.instance.database;


    await db.insert(

      'orders',

      {

        'customer_id': uid,

        'product_name': item['name'],

        'price': item['price'],

        'quantity': 1,

      },

    );

  }






  // Get user's orders
  Future<List<Map<String, dynamic>>> getCartItems(
      String uid) async {


    final db =
        await DatabaseHelper.instance.database;


    return await db.query(

      'orders',

      where: 'customer_id = ?',

      whereArgs: [uid],

    );

  }






  // Remove one item from cart
  // Used by swipe gesture (Dismissible)
  Future<void> removeFromCart(
      String uid,
      String productName) async {


    final db =
        await DatabaseHelper.instance.database;


    await db.delete(

      'orders',

      where:
          'customer_id = ? AND product_name = ?',


      whereArgs: [

        uid,

        productName,

      ],

    );


  }






  // Clear user's orders after checkout
  Future<void> clearCart(
      String uid) async {


    final db =
        await DatabaseHelper.instance.database;


    await db.delete(

      'orders',

      where: 'customer_id = ?',


      whereArgs: [uid],

    );

  }



}