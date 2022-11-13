
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // left:10 and rigt:10 
          margin:const EdgeInsets.symmetric(horizontal: 10),
          child:SingleChildScrollView(
            child: Row(
            children: [
                 Image.network(product.images[0],height: 200,width: 100,),
                 Column(
                  children: [
                    Container(
                      width:235,
                      padding:const EdgeInsets.symmetric(horizontal: 10),
                      child:Text(
                        product.name,
                        style: const TextStyle(fontSize: 16),
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width:235,
                      padding:const EdgeInsets.only(left: 10,top:10),
                      child: Stars(rating: 4),
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
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                       maxLines: 2,
                      ),
                    ),
                  
                  ],
                 )
            ],
                  ),
          )
        ),
      ],
    );
  }
}