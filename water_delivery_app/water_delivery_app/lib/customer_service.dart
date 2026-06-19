import 'database_helper.dart';


class CustomerService {



  Future<void> addCustomer(
      Map<String,String> customer) async {


    final db =
    await DatabaseHelper.instance.database;


    await db.insert(
      'customers',
      customer,
    );

  }



  Future<List<Map<String,dynamic>>> getCustomers() async {


    final db =
    await DatabaseHelper.instance.database;


    return await db.query(
      'customers',
    );

  }




  Future<void> updateCustomer(
      int id,
      Map<String,String> customer) async {


    final db =
    await DatabaseHelper.instance.database;


    await db.update(

      'customers',

      customer,

      where: 'id = ?',

      whereArgs: [id],

    );

  }




  Future<void> deleteCustomer(
      int id) async {


    final db =
    await DatabaseHelper.instance.database;


    await db.delete(

      'customers',

      where: 'id = ?',

      whereArgs: [id],

    );

  }

}