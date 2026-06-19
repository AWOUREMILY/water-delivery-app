import 'database_helper.dart';


class ProductService {


Future<void> addProduct(
Map<String,dynamic> product) async {


final db =
await DatabaseHelper.instance.database;


await db.insert(
'products',
product,
);


}



Future<List<Map<String,dynamic>>> getProducts() async {


final db =
await DatabaseHelper.instance.database;


return await db.query(
'products'
);


}




Future<void> deleteProduct(int id) async {


final db =
await DatabaseHelper.instance.database;


await db.delete(

'products',

where:'id=?',

whereArgs:[id],

);


}


}