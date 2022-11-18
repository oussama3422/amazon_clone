import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/card_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_sub_total.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../contants/global_variables.dart';
import '../../home/widgets/address_box.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {
   

  void navigatToSearch(String query){
  Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
 }
 // navigate To Addresss
  void navigateToAddess(int sum){
     Navigator.pushNamed(context, AddressScreen.routeName,arguments: sum);
 }
  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity'] * e['product']['price'] as int).toList();
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
      body :SingleChildScrollView(
        child: Column(
         children: [
            const AddressBox(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomButton(
                color: const Color.fromARGB(255, 200, 168, 25),
                text: 'Procced To Buy (${user.cart.length} items)',
                onPressed:()=>navigateToAddess(sum),
                ),
            ),
            const SizedBox(height: 4),
            Container(
              color:Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height:5),
            ListView.builder(
              shrinkWrap: true,
              itemCount:user.cart.length ,
              itemBuilder: (context, index) {
                    return CartProduct(index: index);
              }
              )
         ],

      )) ,
    );
  }
}