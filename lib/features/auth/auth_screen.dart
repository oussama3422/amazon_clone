import 'package:amazon_clone/contants/global_variables.dart';
import 'package:flutter/material.dart';


enum Auth{singIn,singUp}

class AuthScreen extends StatefulWidget {
  static const String routeName='/auth-screen'; 
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth auth=Auth.singUp;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
        body: SafeArea(
          child:Column(
            children: [
               const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Text(
                  'Welcome',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
              ),
              ListTile(
                title:const Text('Create Account',style:TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  value: Auth.singUp,
                  groupValue: auth,
                  onChanged: (Auth? val)=>{
                    auth=val!
                    }),
              ),
              ListTile(
                title:const Text('Sing-In',style:TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  value: Auth.singIn,
                  groupValue: auth,
                  onChanged: (Auth? val)=>{
                    auth=val!
                    }),
              ),
            ],
          ) ,
          
          ),


    );
  }
}