import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details.dart';
import 'package:amazon_clone/features/widget/single_product.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? ordersList;
  AdminServices adminServices=AdminServices();
  
  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  void fetchOrders()async{
    ordersList=await adminServices.fetchAllOrders(context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return ordersList==null
    ?
    const Loader()
    :
    GridView.builder(
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ) ,
      itemCount:ordersList!.length,
      itemBuilder: (context, index) {
        final orderData=ordersList![index];
        return InkWell(
          onTap:(){
            Navigator.pushNamed(context, OrderDetails.routeName,arguments: orderData);
          } ,
          child: SizedBox(
            height: 140,
            child: SingleProduct(img: orderData.products[0].images[0]),
            ),
        );
      },
    );
  }
}