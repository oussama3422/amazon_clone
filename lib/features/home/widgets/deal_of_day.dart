import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Container(
          alignment: Alignment.topLeft,
          padding:const EdgeInsets.only(left:10,top:10),
          child:const Text('Deal of the day',style:TextStyle(fontSize:20))
        ),
          Image.network('https://images.unsplash.com/photo-1664216078887-e9d0634954d5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2R1aXR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',fit: BoxFit.fitWidth,height:233),
        Container(
          padding: EdgeInsets.only(left:15),
          alignment:Alignment.topLeft ,
          child:Text('\$100',style:TextStyle(fontSize: 20))
        ),
        Container(
          padding:const EdgeInsets.only(top:5,left:15,right:40),
          child:const Text('Oussama',maxLines: 2,overflow: TextOverflow.ellipsis,)
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.network('https://media.istockphoto.com/id/538506169/photo/crockery.jpg?b=1&s=170667a&w=0&k=20&c=qF8guZDySitwptFbp0x3RMrRz0ouFXr-T5wCACYE2Pw=',fit:BoxFit.fitWidth,width:100,height:100),
              Image.network('https://media.istockphoto.com/id/538623531/photo/crockery.jpg?b=1&s=170667a&w=0&k=20&c=-jV9PfP5myq2Hj3O0Wx3v6aCJQDlc8ENSgo_w9JPrMU=',fit:BoxFit.fitWidth,width:100,height:100),
              Image.network('https://media.istockphoto.com/id/538623523/photo/crockery.jpg?b=1&s=170667a&w=0&k=20&c=aZKdkMcsK9xi9SdwGiDwKW81CslWOHD1yOt_I_W-3-g=',fit:BoxFit.fitWidth,width:100,height:100),
              Image.network('https://media.istockphoto.com/id/621263238/photo/basque-country-euskal-herria.jpg?b=1&s=170667a&w=0&k=20&c=8PJDP98H0-UjDfSJ0yNxHbXdTe1Si7wswxbbljMyYrg=',fit: BoxFit.fitWidth,height: 100,width:100)
            ],
            ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical:15).copyWith(left:15),
          alignment: Alignment.topLeft,
          child: Text('See all deal',style: TextStyle(color:Colors.cyan[800]),),
        )
      ]
    );
  }
}