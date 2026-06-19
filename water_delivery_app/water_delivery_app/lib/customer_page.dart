import 'package:flutter/material.dart';
import 'customer_service.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}


class _CustomerPageState extends State<CustomerPage> {

  final CustomerService service = CustomerService();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();



  void showForm({Map<String, dynamic>? customer}) {

    if (customer != null) {

      nameController.text = customer["name"];
      phoneController.text = customer["phone"];

    } else {

      nameController.clear();
      phoneController.clear();

    }


    showDialog(

      context: context,

      builder: (_) => AlertDialog(

        title: Text(
          customer == null
              ? "Add Customer"
              : "Edit Customer",
        ),


        content: Column(

          mainAxisSize: MainAxisSize.min,

          children: [


            TextField(

              controller: nameController,

              decoration:
              const InputDecoration(
                labelText: "Name",
              ),

            ),



            TextField(

              controller: phoneController,

              decoration:
              const InputDecoration(
                labelText: "Phone",
              ),

            ),


          ],

        ),


        actions: [


          ElevatedButton(

            onPressed: () async {


              final data = {

                "name": nameController.text,

                "phone": phoneController.text,

              };


              if (customer == null) {


                await service.addCustomer(data);


              } else {


                await service.updateCustomer(

                  customer["id"],

                  data,

                );

              }


              setState(() {});


              Navigator.pop(context);


            },


            child:
            const Text("Save"),

          )

        ],

      ),

    );

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:
      AppBar(
        title:
        const Text("Customers"),
      ),



      floatingActionButton:

      FloatingActionButton(

        onPressed: () {

          showForm();

        },

        child:
        const Icon(Icons.add),

      ),




      body:

      FutureBuilder<List<Map<String,dynamic>>>(


        future:
        service.getCustomers(),



        builder:(context, snapshot){


          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return const Center(
              child:CircularProgressIndicator(),
            );

          }



          if(!snapshot.hasData ||
              snapshot.data!.isEmpty){

            return const Center(

              child:
              Text("No customers yet"),

            );

          }



          final customers =
          snapshot.data!;



          return ListView.builder(


            itemCount:
            customers.length,



            itemBuilder:(context,index){


              final customer =
              customers[index];



              return ListTile(


                title:
                Text(
                  customer["name"],
                ),



                subtitle:
                Text(
                  customer["phone"],
                ),



                trailing:

                Row(

                  mainAxisSize:
                  MainAxisSize.min,


                  children: [



                    IconButton(

                      icon:
                      const Icon(Icons.edit),


                      onPressed:(){

                        showForm(
                          customer: customer,
                        );

                      },

                    ),




                    IconButton(

                      icon:
                      const Icon(Icons.delete),


                      onPressed:() async{


                        await service.deleteCustomer(

                          customer["id"],

                        );


                        setState(() {});


                      },

                    ),


                  ],

                ),


              );


            },

          );

        },


      ),


    );

  }

}