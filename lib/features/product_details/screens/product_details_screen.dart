import 'dart:ui';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../contants/global_variables.dart';
import '../../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key,required this.product});
  static const String routeName='/product-detail-screen';


  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
   Product? product;
   ProductDetailsServices productDetailsServices=ProductDetailsServices();


  
   navigatToSearch(String query){
    Navigator.pushNamed(context,SearchScreen.routeName,arguments:query );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height:42,
                  margin: const EdgeInsets.only(left: 15),
                  child:Material(
                    borderRadius:BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatToSearch,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding: EdgeInsets.only(top:6),
                            child: Icon(Icons.search,color: Colors.black,size:32),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top:10),
                        border:  const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(color: Colors.black38,width:1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle:const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color:Colors.transparent,
                height:42,
                margin:const EdgeInsets.symmetric(horizontal: 10),
                child:IconButton(
                  icon:const Icon(Icons.mic,size:28,color:Colors.black),
                  onPressed: (){},
                  )
              )
            ],
          ),
          ),
        ),
       body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(widget.product.id!,style:const TextStyle(fontFamily: 'FiraCode'),),
                  const Stars(rating: 4),
                 
                ]
              ),
            ),
             Padding(
              padding:const EdgeInsets.symmetric(
                   horizontal: 20,
                   vertical: 10
              ),
              child: Text(widget.product.name,style:const TextStyle(fontSize: 15,fontFamily: 'FiraCode'),),
              ),
              CarouselSlider(
                 items:widget.product.images.map(
                          (item) => Builder(
                         builder:(context)=>Image.network(item,fit:BoxFit.cover,height:200),
                        )
                       ).toList(),
                       options:CarouselOptions(
                         viewportFraction: 1,
                         height:330,
                       ), 
                ),
            Container(
              color:Colors.grey,
              height:6,             
            ),
            RichText(
              text: TextSpan(
                text: 'Deal Price : ',
                style:const TextStyle(fontSize: 16,color:Colors.black,fontFamily: 'FiraCode',fontWeight:FontWeight.bold),
                children: [
                   TextSpan(
                  text: '\$${widget.product.price}',
                  style:const TextStyle(fontSize: 22,color:Color.fromARGB(255, 218, 20, 20),fontFamily: 'FiraCode',fontWeight:FontWeight.w500)
                )
                ],
                )
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description,style: const TextStyle(fontFamily: 'FiraCode'),),
            ),
             Container(
              color:Colors.grey,
              height:6,             
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: CustomButton(
                text: 'Buy Now',
                onPressed: (){},
                ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: CustomButton(
                text: 'Add To Cart',
                onPressed: (){},
                color: const Color.fromARGB(255, 225, 104, 11),
                ),
            ), Container(
              color:Colors.grey,
              height:6,             
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:Text(
                'Rate The Product',
                style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'FiraCode'),
              ),
              ),
            RatingBar.builder(
              minRating: 1,
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding:const EdgeInsets.symmetric(horizontal: 4) ,
              itemBuilder: (context, index) =>const Icon(Icons.star,color: GlobalVariables.secondaryColor,),
              onRatingUpdate: (rating){
                    productDetailsServices.rateProduct(context: context, product: widget.product, rating: rating);
              },
              )
          ],
         ),
       ),
    );
  }
}