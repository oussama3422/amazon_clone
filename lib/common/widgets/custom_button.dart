import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.text,required this.onPressed,this.color});
  final Function() onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity,40), backgroundColor: color,
      ),
      child: Text(text,style: TextStyle(fontFamily: 'FiraCode',color:color==null?Colors.white:Colors.black),),
    );
  }
}