


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String img;
  const SingleProduct({super.key,required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child:DecoratedBox(
        decoration: BoxDecoration(
              border: Border.all(color:Colors.black,width: 2),
              borderRadius: BorderRadius.circular(5)
            
      ),
    child: Container(
      width: 180,
      padding: const EdgeInsets.all(2),
      child: Image.network(img,fit: BoxFit.fitHeight,width: 180,),
    ),
      )
    );
  }
}