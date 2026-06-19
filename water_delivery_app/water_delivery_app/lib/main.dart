import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'database_helper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  // Initialize SQLite Database
  await DatabaseHelper.instance.database;


  runApp(const MyApp());

}



class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Water Delivery App',


      theme: ThemeData(

        primarySwatch: Colors.blue,

        useMaterial3: true,

      ),


      home: const LoginPage(),

    );

  }

}