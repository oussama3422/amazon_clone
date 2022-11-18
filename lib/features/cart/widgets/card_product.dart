import 'package:amazon_clone/features/cart/services/card_services.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key,required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
 final ProductDetailsServices productDetailsServices=ProductDetailsServices();
 final CartServices cartServices=CartServices();
 void increaseQuantity(Product product){
  productDetailsServices.addToCart(
    context: context,
    product: product
    );
 }
 void decreaseQuantity(Product product){
  cartServices.removeFromCart(
    context: context,
    product: product
    );
 }

  

  @override
  Widget build(BuildContext context) {
  final productCart=Provider.of<UserProvider>(context).user.cart[widget.index];
  final product=Product.fromMap(productCart['product']);
  final quantity=productCart['quantity'];
    return Column(
      children: [
        Container(
          // left:10 and rigt:10 
          margin:const EdgeInsets.symmetric(horizontal: 10),
          child:Row(
          children: [
               Image.network(product.images[0],height: 200,width: 140,),
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
                 ),
               )
          ],
                )
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border:Border.all(
                    color:Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(children: [
                  InkWell(
                   onTap:() =>decreaseQuantity(product),
                    child: Container(
                      width: 34,
                      height: 32,
                      alignment: Alignment.center,
                      child:const Icon(
                        Icons.remove,
                        size:18,
                      )
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12,width: 2.5),
                      color:Colors.white,
                    ),
                    child: Container(
                      width: 34,
                      height: 32,
                      alignment: Alignment.center,
                      child:Text(quantity.toString())
                    ),
                  ),
                  InkWell(
                    onTap:()=> increaseQuantity(product),
                    child: Container(
                        width: 34,
                        height: 32,
                        alignment: Alignment.center,
                        child:const Icon(Icons.add)
                      ),
                    ),
                ]
                ),
              )
            ],
            )
        )
      ],
    );
  }
}