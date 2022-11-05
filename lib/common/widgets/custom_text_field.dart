import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key,required this.controller,required this.hintTitle});
  final TextEditingController controller;
  final String hintTitle;
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
      
    );
  }
}