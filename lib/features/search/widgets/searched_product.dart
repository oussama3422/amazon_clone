
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
      double avrgRating=0;
      double totalRating=0;
    for(int i=0;i<product.rating!.length;i++)
    {
      totalRating+=product.rating![i].rating;
      // ignore: unrelated_type_equality_checks
      if(product.rating![i].userId==Provider.of<UserProvider>(context,listen: false).user.id){
        avrgRating=product.rating![i].rating; 
      } 
    }


    return Column(
      children: [
        Container(
          // left:10 and rigt:10 
          margin:const EdgeInsets.symmetric(horizontal: 10),
          child:Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child:Image.network(product.images[0],height:150,width: 200,)
              ),
               Expanded(
                 child: Column(
                  children: [
                    Container(
                      width:235,
                      padding:const EdgeInsets.symmetric(horizontal: 10),
                      child:Text(
                        product.name,
                        style: const TextStyle(fontSize: 16),
                       maxLines: 2,
                      ),
                    ),
                    Container(
                      width:235,
                      padding:const EdgeInsets.only(left: 10,top:10),
                      child: Stars(rating:avrgRating),
                    ),
                    Container(
                      width:235,
                      padding:const EdgeInsets.symmetric(horizontal: 10),
                      child:Text(
                        '\$${product.price}',
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                       maxLines: 2,
                      ),
                    ),
                     Container(
                      width:235,
                      padding:const EdgeInsets.only(left: 10),
                      child:const Text(
                        'Eligible for shiping',
                      ),
                    ),
                     Container(
                      width:235,
                      padding:const EdgeInsets.only(left: 10),
                      child:const Text(
                        'In Stock',
                        style: TextStyle(color:Colors.teal),
                      maxLines: 2,
                      ),
                    ),
                  ],
                 ),
               )
          ],
        )
        ),
      ],
    );
  }
}