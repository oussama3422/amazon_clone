import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
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
  final singupFormKey=GlobalKey<FormState>();
  final singinFormKey=GlobalKey<FormState>();
  final TextEditingController emailcontoller=TextEditingController();
  final TextEditingController passwordlcontoller=TextEditingController();
  final TextEditingController namecontroller=TextEditingController();

  final AuthService authService=AuthService();
  @override
  void dispose() {
    emailcontoller.dispose();
    passwordlcontoller.dispose();
    namecontroller.dispose();
    super.dispose();
  }
  void singupUser()async{
    authService.singUpUser(
      context,
      email: emailcontoller.text,
      password: passwordlcontoller.text,
      name: namecontroller.text,
      );
  }
  void singInUser(){
    authService.singInUser(context: context, email: emailcontoller.text, password: passwordlcontoller.text);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
        body: SafeArea(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Text(
                  'Welcome',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
              ),
              ListTile(
                tileColor: auth==Auth.singUp?GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
                title:const Text('Create Account',style:TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.singUp,
                  groupValue: auth,
                  onChanged: (val){
                    setState((){
                       auth=val!;
                      });
                    }
                    ),
              ),
              if (auth==Auth.singUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: singupFormKey,
                    child: Column(
                    children: [
                       CustomTextField(controller:namecontroller,hintTitle: 'Enter Name',),
                       const SizedBox(height: 10),
                       CustomTextField(controller:emailcontoller,hintTitle: 'Enter Email Address',),
                       const SizedBox(height: 10),
                       CustomTextField(controller:passwordlcontoller,hintTitle: 'Enter Password',),
                       const SizedBox(height: 10),
                       CustomButton(
                        text: 'SingUp',
                        onPressed: (){
                          if(singupFormKey.currentState!.validate()){
                                 singupUser();
                          }     
                        },
                        )
                       
                    ],
                  )
                  ),
                ),
                if (auth==Auth.singIn)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: singupFormKey,
                    child: Column(
                    children: [
                       CustomTextField(controller:emailcontoller,hintTitle: 'Enter Email Address',),
                       const SizedBox(height: 10),
                       CustomTextField(controller:passwordlcontoller,hintTitle: 'Enter Password',),
                       const SizedBox(height: 10),
                       CustomButton(text: 'SingIn', onPressed: (){
                          if(singupFormKey.currentState!.validate()){
                              singInUser();
                          }
                      }
                      )
                       
                    ],
                  )
                  ),
                ),
              ListTile(
                tileColor: auth==Auth.singUp?GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundCOlor,
                title:const Text('Sing-In',style:TextStyle(fontWeight: FontWeight.bold)),
                leading: Radio(
                  value: Auth.singIn,
                  groupValue: auth,
                  onChanged: (val){
                    setState((){
                      auth=val!;
                    });
                    }),
              ),
              
            ],
          ) ,
          
          ),


    );
  }
}