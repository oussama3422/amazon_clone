import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
   HomeServices homeServices=HomeServices();

   @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }
  void fetchDealOfDay()async{
    product=await homeServices.fetchDealDay(context: context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return 
    product==null
    ?
    const Loader()
     : 
     product!.name.isEmpty
     ? 
     const SizedBox()
     :
     Column(
      children:[
        Container(
          alignment: Alignment.topLeft,
          padding:const EdgeInsets.only(left:10,top:10),
          child:const Text('Deal of the day',style:TextStyle(fontSize:20))
        ),
          Image.network(
            product!.images[0],
            fit: BoxFit.cover,
            height:233
            ),
        Container(
          padding: const EdgeInsets.only(left:15),
          alignment:Alignment.topLeft ,
          child:const Text('\$100',style: TextStyle(fontSize: 20))
        ),
        Container(
          padding:const EdgeInsets.only(top:5,left:15,right:40),
          child:const Text('Oussama',maxLines: 2,overflow: TextOverflow.ellipsis,)
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: product!.images.map((e) => Image.network(
              e,
              fit:BoxFit.cover,
              height: 200,
              width: 400,
            )).toList()
            ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical:15).copyWith(left:15),
          alignment: Alignment.topLeft,
          child: Text('See all deal',style: TextStyle(color:Colors.cyan[800]),),
        )
      ]
    );
  }
}