import 'dart:convert';
import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../contants/global_variables.dart';
import '../../../models/product.dart';
import 'package:http/http.dart' as http;
class HomeServices{


Future<List<Product>> fetchCategoryProduct({required BuildContext context,required String category})
async{
   final userProduct=Provider.of<UserProvider>(context,listen: false);
   List<Product> productlist=[];
  try{
   http.Response res=await http.get(
    Uri.parse('$uri/api/products?category=$category'),
   headers: {
    'Content-Type':'application/json; charset=UTF-8',
    'x-token-auth':userProduct.user.token,
   },
   );
   httpErrorHandle(
    response: res,
    context: context,
    onSuccess:(){
      for(int i=0;i<jsonDecode(res.body).length;i++)
      {
        productlist.add(
          Product.fromJson(
            jsonEncode(
              jsonDecode(res.body)[i],
            )
          )
        );
      }
    },
    );
  
     
  }catch(error){
    showSnackBar(context, error.toString());
  }
  return productlist;

}


}