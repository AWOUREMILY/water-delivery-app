import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_delivery_app/event_logger.dart';

import 'cart_service.dart';
import 'product_service.dart';
import 'event_logger.dart';



class ProductPage extends StatefulWidget {

  const ProductPage({
    super.key,
  });


  @override
  State<ProductPage> createState() =>
      _ProductPageState();

}




class _ProductPageState extends State<ProductPage> {


  final ProductService service =
      ProductService();


  final CartService cart =
      CartService();




  @override
  Widget build(BuildContext context) {


    final user =
        FirebaseAuth.instance.currentUser;


    final uid =
        user?.uid;



    return Scaffold(


      appBar:
          AppBar(

        title:
            const Text(
              "Order Water",
            ),

      ),



      body:

      FutureBuilder<List<Map<String,dynamic>>>(


        future:
            service.getProducts(),



        builder:
            (context, snapshot) {



          if (!snapshot.hasData) {


            return const Center(

              child:
                  CircularProgressIndicator(),

            );

          }




          final products =
              snapshot.data!;



          return ListView.builder(


            itemCount:
                products.length,



            itemBuilder:
                (context,index) {



              final item =
                  products[index];




              return GestureDetector(


                onLongPress: () {


                  EventLogger.add(
                    " Long Press on ${item["name"]}",
                  );


                  showDialog(

                    context:
                        context,


                    builder:
                        (context) {


                      return AlertDialog(


                        title:
                            Text(
                              item["name"],
                            ),



                        content:
                            Text(
                              "Water Price: KSh ${item["price"]}",
                            ),



                        actions: [


                          TextButton(

                            onPressed: () {


                              Navigator.pop(
                                context,
                              );


                            },

                            child:
                                const Text(
                                  "Close",
                                ),

                          ),

                        ],


                      );


                    },

                  );

                },



                child:
                    Card(

                  margin:
                      const EdgeInsets.all(10),



                  child:
                      ListTile(


                    leading:
                        const Icon(

                      Icons.water_drop,

                      color:
                          Colors.blue,

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


                      onPressed:
                          () async {

                            EventLogger.add(
                              " Add Button Tapped",
                            );


                            if(uid == null){

                              return;

                            }
                                                        await cart.addToCart(

                              uid,

                              {

                                "name":
                                    item["name"],

                                "price":
                                    item["price"],

                              },

                            );



                            EventLogger.add(
                              " ${item["name"]} Added To Cart",
                            );



                            ScaffoldMessenger.of(context)
                                .showSnackBar(

                              SnackBar(

                                content:
                                    Text(

                                  "${item["name"]} added to cart",

                                ),

                              ),

                            );


                          },



                      child:
                          const Text(
                            "Add",
                          ),

                    ),



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