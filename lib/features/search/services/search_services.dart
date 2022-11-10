import 'dart:convert';

import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../contants/global_variables.dart';

class SearchServices{


Future<List<Product>> fetchSearchProducts({required BuildContext context,required String searchquery})async{

   final userProvider=Provider.of<UserProvider>(context,listen: false);
   List<Product> productList=[];
   try{
   http.Response res=await http.get(
    Uri.parse('$uri/api/products/search/$searchquery'),
    headers: {
      'Content-Type':'application/json; charset=UTF-8',
       'x-token-auth':userProvider.user.token,
    }
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){
       for(int i=0;i<jsonDecode(res.body).length;i++)
       {
         productList.add(
          Product.fromJson(
            jsonEncode(
              jsonDecode(res.body)[i],
            )
          )
         );
       }
      }
      );
   }catch(error){
     showSnackBar(context, error.toString());
   }
  return productList;

}



}