import 'dart:convert';

import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../models/product.dart';

class CartServices{




  void removeFromCart({required BuildContext context,required Product product})async{

  final userProvdier=Provider.of<UserProvider>(context,listen: false);
  try{
   http.Response res=await http.delete(
    Uri.parse('$uri/api/remove-from-cart/${product.id}'),
    headers: {
      'Content-Type':'application/json; charset=UTF-8',
      'x-token-auth':userProvdier.user.token,
    }
   );
   httpErrorHandle(
    response: res,
    context: context,
    onSuccess: (){
      User user=userProvdier.user.copyWith(cart: jsonDecode(res.body)['cart']);
      userProvdier.setUserFromModel(user);
    }
    );
  } catch(error){
    showSnackBar(context, error.toString());
  } 
  
  }
}