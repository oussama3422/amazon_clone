import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/features/admin/module/sales.dart';
import 'package:amazon_clone/features/widget/orders.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices{

  void sellProduct({
  required BuildContext context,
  required String name,
  required String description,
  required double price,
  required double quantity,
  required String category,
  required List<File> images,
  })
  async{
  try{
    var userProvider=Provider.of<UserProvider>(context,listen: false);
   final cloudnary=CloudinaryPublic('dnc6wt7ob', 'kr0wphmmf');
   List<String> imagesUrls=[];

   for(int i=0;i<images.length;i++){
    CloudinaryResponse res = await cloudnary.uploadFile(CloudinaryFile.fromFile(images[i].path,folder:name));
    imagesUrls.add(res.secureUrl);
   }
   Product product=Product(
    name: name,
    description: description,
    quantity: quantity,
    images: imagesUrls,
    category: category,
    price: price,
    );
    
   http.Response res=await http.post(
    Uri.parse('$uri/admin/add-product'),
    headers: {
      'Content-Type':'application/json; charset=UTF-8',
      'x-token-auth':userProvider.user.token,
    },
    body: product.toJson(),
   );
   httpErrorHandle(
    response: res,
    context: context,
    onSuccess:(){
       showSnackBar(context, 'Product Added Successfully!');
       Navigator.pop(context);
    } 
    );
  }catch(err){
   showSnackBar(context, err.toString());
  }

  }
 Future<List<Product>> fetchAllProducts(BuildContext context)async{
   
     final userProduct=Provider.of<UserProvider>(context,listen: false);
     List<Product> productList=[];
    try{
     http.Response res=await http.get(
      Uri.parse('$uri/admin/get-products'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'x-token-auth':userProduct.user.token,
      },
     );
     httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){
        for(int i=0;i<jsonDecode(res.body).length;i++)
        {
         productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }
      );
    }catch(err){
      showSnackBar(context, err.toString());
    }
    return productList;
 }
 // delete Products 
 deleteProduct({required BuildContext context,required Product product,required VoidCallback onSucess})async{
  var userProduct=Provider.of<UserProvider>(context,listen: false);
  try{
    http.Response res=await http.post(
      Uri.parse('$uri/admin/delete-product'),
      headers: {
        'Content-Type':'applicaton/json; charset=UTF-8',
        'x-token-auth':userProduct.user.token,
      },
      body:jsonEncode({'id':product.id}),
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess:onSucess
      );
  }catch(err){
    showSnackBar(context, err.toString());
  }
 }
 
 Future<List<Order>> fetchAllOrders(BuildContext context)async{
   
     final userProduct=Provider.of<UserProvider>(context,listen: false);
     List<Order> orderList=[];
    try{
     http.Response res=await http.get(
      Uri.parse('$uri/admin/get-orders'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'x-token-auth':userProduct.user.token,
      },
     );
     httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){
        for(int i=0;i<jsonDecode(res.body).length;i++)
        {
         orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
        }
      }
      );
    }catch(err){
      showSnackBar(context, err.toString());
    }
    return orderList;
 }
 // Change Order Status
 changeOrderStatus({required BuildContext context,required int status,required Order order,required VoidCallback onSucess})async{
  var userProduct=Provider.of<UserProvider>(context,listen: false);
  try{
    http.Response res=await http.post(
      Uri.parse('$uri/admin/change-order-status'),
      headers: {
        'Content-Type':'applicaton/json; charset=UTF-8',
        'x-token-auth':userProduct.user.token,
      },
      body:jsonEncode({'id':order.id,'status':order.status}),
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess:onSucess
      );
  }catch(err){
    showSnackBar(context, err.toString());
  }
 }
 
 
 Future<Map<String,dynamic>> getEarning(BuildContext context)async{
     final userProduct=Provider.of<UserProvider>(context,listen: false);
     List<Sales> sales=[];
     int totalEarning=0;
    try{
     http.Response res=await http.get(
      Uri.parse('$uri/admin/analtyics'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
        'x-token-auth':userProduct.user.token,
      },
     );
     httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){
       var response=jsonDecode(res.body);
       totalEarning=response['totalEearning'];
       sales=[
        Sales(label: 'Mobiles', earning: response['mobileEarnings']),
        Sales(label: 'Essentials', earning: response['essentialsEarnings']),
        Sales(label: 'Appliances', earning: response['appliancesEarnings']),
        Sales(label: 'Books', earning: response['booksEarnings']),
        Sales(label: 'Fashion', earning: response['fashionEarnings']),
        ];
      }
      );
    }catch(err){
      showSnackBar(context, err.toString());
    }
    return {
      'sales':sales,
      'totalEarnings':totalEarning
    };
 }
}