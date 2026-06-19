import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_service.dart';
import 'product_service.dart';


class ProductPage extends StatefulWidget {

  const ProductPage({super.key});


  @override
  State<ProductPage> createState() =>
      _ProductPageState();

}



class _ProductPageState extends State<ProductPage>{


final ProductService service =
ProductService();


final cart = CartService();



@override
Widget build(BuildContext context){


final user =
FirebaseAuth.instance.currentUser;


final uid =
user?.uid;



return Scaffold(


appBar:
AppBar(
title:
const Text("Order Water"),
),



body:

FutureBuilder<List<Map<String,dynamic>>>(


future:
service.getProducts(),



builder:(context,snapshot){


if(!snapshot.hasData){

return const Center(
child:CircularProgressIndicator(),
);

}



final products =
snapshot.data!;



return ListView.builder(


itemCount:
products.length,



itemBuilder:(context,index){


final item =
products[index];



return Card(


margin:
const EdgeInsets.all(10),



child:ListTile(



leading:
const Icon(
Icons.water_drop,
color:Colors.blue,
),



title:
Text(
item["name"],
),



subtitle:
Text(
"KSh ${item["price"]}",
),



trailing:

ElevatedButton(


onPressed:() async{


if(uid==null){

return;

}



await cart.addToCart(

uid,

{

"name":item["name"],

"price":item["price"],

},

);



ScaffoldMessenger.of(context)
.showSnackBar(

SnackBar(

content:
Text(
"${item["name"]} added to cart"
),

),

);


},


child:
const Text("Add"),

),


),


);



},


);


},


),


);


}

}