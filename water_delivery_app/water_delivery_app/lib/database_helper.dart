import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {

  static final DatabaseHelper instance =
      DatabaseHelper._init();

  static Database? _database;


  DatabaseHelper._init();



  Future<Database> get database async {

    if (_database != null) return _database!;

    _database = await _initDB();

    return _database!;
  }



  Future<Database> _initDB() async {

    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      'water_delivery.db',
    );


    return await openDatabase(

      path,

      version: 1,

      onCreate: _createTables,

    );

  }




  Future<void> _createTables(
      Database db,
      int version) async {



    // CUSTOMERS TABLE

    await db.execute('''

    CREATE TABLE customers(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      name TEXT NOT NULL,

      phone TEXT NOT NULL

    )

    ''');




    // PRODUCTS TABLE

    await db.execute('''

    CREATE TABLE products(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      name TEXT NOT NULL,

      price INTEGER NOT NULL,

      quantity INTEGER NOT NULL

    )

    ''');





    // ORDERS TABLE

    await db.execute('''

    CREATE TABLE orders(

      id INTEGER PRIMARY KEY AUTOINCREMENT,

      customer_id INTEGER,

      product_id INTEGER,

      product_name TEXT NOT NULL,

      price INTEGER NOT NULL,

      quantity INTEGER NOT NULL,

      FOREIGN KEY(customer_id)
      REFERENCES customers(id),

      FOREIGN KEY(product_id)
      REFERENCES products(id)

    )

    ''');



    // DEFAULT PRODUCTS

    await db.insert(
      'products',
      {
        'name':'20L Water',
        'price':5000,
        'quantity':50
      },
    );


    await db.insert(
      'products',
      {
        'name':'10L Water',
        'price':3000,
        'quantity':50
      },
    );


    await db.insert(
      'products',
      {
        'name':'5L Water',
        'price':1500,
        'quantity':50
      },
    );

  }

}