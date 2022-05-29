import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madproject/modules/models/order.dart';
import 'package:madproject/modules/models/product.dart';
import 'package:madproject/modules/repository/order_repo.dart';
import 'package:madproject/modules/services/order_services.dart';
import '/modules/widgets/view_product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  OrdersRepo ordersRepo = OrdersRepo.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(child: Text("Order List" , style: TextStyle(color: Colors.black),)),

      ),
      body: SafeArea(
          child: FutureBuilder(
        future: ordersRepo.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Some error has occured");
          } else {
            List<Order> list = OrderServies().convertOrders(snapshot.data);

            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // return ListTile(

                  //   leading: Text("Order ID : ${list[index].id}"+"Product_id"+"${list[index].products_list[0]['product_id']}"+"  "+"${list[index].price}"+"  "+"${list[index].order_status}"+"     "+"${list[index].delivery_zone}", style: TextStyle(color: Colors.black, fontSize: 12),),
                  //   //leading: Text("${list[index].date}"),

                  // );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        
                        height: 120,
                        width: 60,
                        decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(20)) ),
                        child: Column(
                          
                          children: [
                            Text(
                              "Order ID : ${list[index].id}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20 ,),
                            ),
                            Text("Product_id : "+"${list[index].products_list[0]['product_id']}" , style: TextStyle(fontSize: 18),),
                            Text("Price : " + "${list[index].price}",style: TextStyle(fontSize: 18)),
                            Text("Status : " + "${list[index].order_status}",style: TextStyle(fontSize: 18)),
                            Text("Zone : " + "${list[index].delivery_zone}",style: TextStyle(fontSize: 18))
                          ],
                        )),
                  );
                });
          }
        },
      )),
    );
  }
}
