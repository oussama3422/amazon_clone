import 'dart:convert';

import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../contants/global_variables.dart';
class AccountServices{




  Future<List<Order>> fetchAllOrders({required BuildContext context})async{
   var userProvider=Provider.of<UserProvider>(context,listen: false);
   List<Order>orderList=[];
  try{
      http.Response res=await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers:{
              'Content-Type':'application/json; charset=UTF-8',
              'x-token-auth':userProvider.user.token,
        }
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (){
          for(int i=0;i<jsonDecode(res.body).length;i++){
            orderList.add(
              Order.fromJson(
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

  return orderList;
  }
}