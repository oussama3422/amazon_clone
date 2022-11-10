

import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/widget/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount:GlobalVariables.carouselImages.length,
            itemBuilder: (context, index) => SingleProduct(img:GlobalVariables.carouselImages[index] ),
            ),
        )
      ],
    );
  }
}