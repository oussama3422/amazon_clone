import 'dart:convert';
import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../contants/global_variables.dart';
import '../../../models/product.dart';
import 'package:http/http.dart' as http;
class ProductDetailsServices{

 void rateProduct({required BuildContext context,required Product product,required double rating})async{

  var userProvider=Provider.of<UserProvider>(context,listen: false);

  try{
    http.Response res=await http.post(
      Uri.parse('$uri/api/rate-product'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
         'x-token-auth':userProvider.user.token,
      },body: jsonEncode({
        'id':product.id!,
        'rating':rating,
      }),
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){}
      );
  }catch(error){
    showSnackBar(context, error.toString());
  }
 }

 // add to cart Function

 addToCart({required BuildContext context,required Product product})async{
  var userProvider=Provider.of<UserProvider>(context,listen: false);
  try{
    http.Response response=await http.post(
      Uri.parse('$uri/api/add-to-cart'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'x-token-auth':userProvider.user.token,
      },
      body: jsonEncode({'id':product.id!}),
    );
    httpErrorHandle(
      response: response,
     context: context,
     onSuccess: (){
      User user=userProvider.user.copyWith(
          cart:jsonDecode(response.body)['cart'],
        );
       userProvider.setUserFromModel(user);
     }
     );


  }catch(error){
    showSnackBar(context, error.toString());
  }
 }




}