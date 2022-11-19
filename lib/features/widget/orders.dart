

import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details.dart';
import 'package:amazon_clone/features/widget/single_product.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
   List<Order>? orders;


   AccountServices accountServices=AccountServices();
  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  void fetchOrders()async{
    orders=await accountServices.fetchAllOrders(context: context);
    setState(() { });
  }
  @override
  Widget build(BuildContext context) {   
    return orders==null
    ?
    const Loader()
    :
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:const EdgeInsets.only(left:15),
              child:const Text('Your Orders',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500))
            ),
            Container(
              padding:const EdgeInsets.only(right:15),
              child:Text('See All',style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: GlobalVariables.selectedNavBarColor))
            ),
          ],
        ),
        //display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(top:20,left:10,right:0),
          child: ListView.builder(
            scrollDirection:Axis.horizontal ,
            itemCount:orders!.length,
            itemBuilder: (context, index) => InkWell(
              onTap: (){
                Navigator.pushNamed(context, OrderDetails.routeName,arguments: orders![index]);
              },
              child: SingleProduct(img:orders![index].products[0].images[0])
              ),
            ),
        )
      ],
    );
  }
}