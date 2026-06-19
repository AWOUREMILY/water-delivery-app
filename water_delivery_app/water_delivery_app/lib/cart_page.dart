import 'package:flutter/material.dart';
import 'cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CartPage extends StatefulWidget {

  const CartPage({super.key});


  @override
  State<CartPage> createState() => _CartPageState();

}



class _CartPageState extends State<CartPage> {


  final CartService cart = CartService();



  Future<String?> getUserId() async {

    final user =
        FirebaseAuth.instance.currentUser;

    return user?.uid;

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:
      AppBar(
        title:
        const Text("My Orders"),
      ),



      body:

      FutureBuilder<String?>(

        future:
        getUserId(),


        builder:(context, userSnapshot){


          if(!userSnapshot.hasData){

            return const Center(
              child:CircularProgressIndicator(),
            );

          }


          final uid =
          userSnapshot.data;



          if(uid == null){

            return const Center(

              child:
              Text("Please login first"),

            );

          }




          return FutureBuilder<List<Map<String,dynamic>>>(


            future:
            cart.getCartItems(uid),



            builder:(context, snapshot){


              if(snapshot.connectionState ==
                  ConnectionState.waiting){

                return const Center(
                  child:
                  CircularProgressIndicator(),
                );

              }




              final items =
              snapshot.data ?? [];




              if(items.isEmpty){

                return const Center(

                  child:
                  Text("Cart is empty"),

                );

              }




              double total = 0;


              for(var item in items){

                total += item["price"];

              }





              return Column(


                children:[



                  Expanded(


                    child:
                    ListView.builder(


                      itemCount:
                      items.length,



                      itemBuilder:(context,index){


                        final item =
                        items[index];



                        return ListTile(


                          leading:
                          const Icon(
                            Icons.water_drop,
                            color:Colors.blue,
                          ),



                          title:
                          Text(
                            item["product_name"],
                          ),



                          subtitle:
                          Text(
                            "KSh ${item["price"]}",
                          ),



                        );


                      },

                    ),

                  ),




                  Padding(

                    padding:
                    const EdgeInsets.all(16),


                    child:
                    Column(

                      children:[



                        Text(

                          "Total: KSh $total",

                          style:
                          const TextStyle(

                            fontSize:20,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),



                        const SizedBox(
                          height:10,
                        ),




                        ElevatedButton(


                          onPressed:() async {



                            await cart.clearCart(uid);



                            setState(() {});



                            ScaffoldMessenger.of(context)
                                .showSnackBar(


                              const SnackBar(

                                content:
                                Text(
                                  "Order placed successfully",
                                ),

                              ),

                            );


                          },


                          child:
                          const Text(
                            "Checkout",
                          ),


                        ),



                      ],

                    ),

                  )



                ],


              );


            },

          );


        },


      ),


    );

  }

}