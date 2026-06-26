import 'package:flutter/material.dart';
import 'cart_service.dart';
import 'event_logger.dart'; 
import 'package:firebase_auth/firebase_auth.dart';



class CartPage extends StatefulWidget {

  const CartPage({
    super.key,
  });


  @override
  State<CartPage> createState() =>
      _CartPageState();

}




class _CartPageState extends State<CartPage> {


  final CartService cart =
      CartService();




  Future<String?> getUserId() async {


    final user =
        FirebaseAuth.instance.currentUser;


    return user?.uid;

  }




  Future<void> removeItem(
      String uid,
      String productName) async {


    EventLogger.add(
  "Swipe Remove $productName",
);

    await cart.removeFromCart(
      uid,
      productName,
    );


    setState(() {});


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:

      AppBar(

        title:
            const Text(
              "My Orders",
            ),

      ),



      body:

      FutureBuilder<String?>(


        future:
            getUserId(),



        builder:
            (context,userSnapshot){



          if(!userSnapshot.hasData){


            return const Center(

              child:
                  CircularProgressIndicator(),

            );


          }



          final uid =
              userSnapshot.data;



          if(uid == null){


            return const Center(

              child:
                  Text(
                    "Please login first",
                  ),

            );


          }



          return FutureBuilder<List<Map<String,dynamic>>>(


            future:
                cart.getCartItems(uid),



            builder:
                (context,snapshot){



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
                      Text(
                        "Cart is empty",
                      ),

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



                      itemBuilder:
                          (context,index){



                        final item =
                            items[index];



                        return Dismissible(


                          key:
                              Key(
                                item["product_name"],
                              ),



                          direction:
                              DismissDirection.horizontal,



                          onDismissed:
                              (direction) async {


                            await removeItem(

                              uid,

                              item["product_name"],

                            );



                            ScaffoldMessenger.of(context)
                                .showSnackBar(


                              SnackBar(

                                content:
                                    Text(

                                  "${item["product_name"]} removed",

                                ),

                              ),


                            );


                          },



                          background:
                              Container(

                            color:
                                Colors.red,

                            alignment:
                                Alignment.centerLeft,

                            padding:
                                const EdgeInsets.only(
                                  left:20,
                                ),


                            child:
                                const Icon(

                              Icons.delete,

                              color:
                                  Colors.white,

                            ),

                          ),



                          secondaryBackground:
                              Container(

                            color:
                                Colors.red,

                            alignment:
                                Alignment.centerRight,

                            padding:
                                const EdgeInsets.only(
                                  right:20,
                                ),


                            child:
                                const Icon(

                              Icons.delete,

                              color:
                                  Colors.white,

                            ),

                          ),




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

                              item["product_name"],

                            ),



                            subtitle:
                                Text(

                              "KSh ${item["price"]}",

                            ),


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


                            fontSize:
                                20,


                            fontWeight:
                                FontWeight.bold,


                          ),


                        ),



                        const SizedBox(

                          height:
                              10,

                        ),




                        ElevatedButton(



                          onPressed:
                              () async {



                            EventLogger.add(
                              "Checkout Button Tapped",
                            );



                            await cart.clearCart(uid);



                            setState(() {});



                            EventLogger.add(
                              " Order Completed",
                            );



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