import 'package:amazon_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child:Row(
        children: [
          const  Text(
            'SubTotal: ',
            style:TextStyle(fontSize: 20,fontFamily: 'FiraCode',fontWeight:FontWeight.bold)
          ),
           Text(
            '\$$sum',
            style:const TextStyle(fontSize: 20,fontFamily: 'FiraCode',fontWeight: FontWeight.bold)
          )
        ],
      )
    );
  }
}