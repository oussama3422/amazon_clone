import 'dart:convert';

import 'package:amazon_clone/contants/error_handling.dart';
import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{


  //sing up User
  void singUpUser(BuildContext context,{required String email,required String password,required String name})
  async{
    try{
       User user=User(
        id: '',
        name: name,
        email:email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart:[],
        );
        // var url=Uri.http('$uri/api/signup');
        // print(url);
        final res=await http.post(
          Uri.parse('$uri/api/singup'),
          body: user.toJson(),
          headers: <String,String>{
            'Content-Type':'application/json;  charset=UTF-8',
          },
          );
          // print(res.statusCode);
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: (){
                 showSnackBar(context, 'Acouunt Has been Created!Login with the same credential');
            }
            );
    }catch(error){
          showSnackBar(context, error.toString());
    }

  }
  //sing In User
  void singInUser({required BuildContext context,required String email,required String password})
  async{
    try{
      
        // var url=Uri.http('$uri/api/signin');
        final res=await http.post(
          Uri.parse('$uri/api/singin'),
          body: jsonEncode({
            'email':email,
            'password':password,
          }),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            // "Access-Control-Allow-Origin": "*",
          },
          );
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: ()async{
                 Provider.of<UserProvider>(context,listen: false).setUser(res.body);
                 SharedPreferences prefs=await SharedPreferences.getInstance();
                 await prefs.setString('x-token-auth', jsonDecode(res.body)['token']);
                 // ignore: use_build_context_synchronously
                 Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,(route)=>false);
            }
            );
    }catch(error){
          showSnackBar(context, error.toString());
    }

  }
  void getUserData(BuildContext context)async{
    try{
   SharedPreferences prefs=await SharedPreferences.getInstance();
   String? token=prefs.getString('x-token-auth'); 
   if (token==null){
      prefs.setString('x-token-auth', '');
   }
   var tokenResponse=await http.post(
    Uri.parse('$uri/tokenIsValid'),
    headers: {
     'Content-Type':'application/json; charset=UTF-8',
     'x-token-auth':token!,
    }
    );
    var response=jsonDecode(tokenResponse.body);
    if(response==true){
      http.Response userResponse=await http.get(
        Uri.parse('$uri/'),
        headers: {
          'Content-Type':'application/json; charset=UTF-8',
          'x-token-auth':token,
        }
        );
        // ignore: use_build_context_synchronously
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.setUser(userResponse.body);
    }
    }catch(err){
        
    }

  }

}