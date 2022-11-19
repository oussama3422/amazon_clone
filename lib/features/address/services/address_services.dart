import 'dart:convert';

import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../contants/global_variables.dart';

class AdressServices{

  void saveUserAdress({required BuildContext context,required String address})async{
    final userProvider=Provider.of<UserProvider>(context,listen: false);
    try{
     http.Response response=await http.post(
      Uri.parse('$uri/api/save-user-address'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'x-token-auth':userProvider.user.token,
      },
      body: jsonEncode({
        'address':address,
      })
     );
     httpErrorHandle(
      response: response,
      context: context,
      onSuccess: (){}
      );
    }catch(error){
      showSnackBar(context, error.toString());
    }
  }

  void placeOrder({required BuildContext context,required String address,required double totalSum})async{

    var userProvider=Provider.of<UserProvider>(context,listen: false);


   try{

  http.Response response=await http.post(
    Uri.parse('$uri/api/order'),
    headers: {
      'Content-Type':'application/json; charset=UTF-8',
      'x-token-auth':userProvider.user.token,
    },
    body: jsonEncode({ 
       'cart':userProvider.user.cart,
       'address':address,
       'totalPrice':totalSum,
    })
  );
   httpErrorHandle(
    response: response,
    context: context,
    onSuccess: (){
      showSnackBar(context, 'Your arder has been Placed!');
      User user=userProvider.user.copyWith(
        cart:[],
      );
      userProvider.setUserFromModel(user);
    }
    );
   }catch(error){  
    showSnackBar(context, error.toString());
   }
  }

}