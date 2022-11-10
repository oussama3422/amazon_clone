import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({this.maxLines=1,super.key,required this.controller,required this.hintTitle});
  final TextEditingController controller;
  final String hintTitle;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller ,
      decoration: InputDecoration(
        hintText: hintTitle,
        border:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        ),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        ),
      ),
      validator: (value) {
        if(value==null || value.isEmpty){
          return 'Enter your $hintTitle';
        }return null;
      } ,
      maxLines: maxLines,
    );
  }
}