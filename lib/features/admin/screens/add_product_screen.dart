import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../contants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName='add-product-screen';
  const AddProductScreen({super.key});
  
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController productNameController=TextEditingController();
  final TextEditingController productdesciptionController=TextEditingController();
  final TextEditingController productpriceController=TextEditingController();
  final TextEditingController productquantityController=TextEditingController();
  final AdminServices adminServices=AdminServices();

  final _addProductKey=GlobalKey<FormState>();
   String category='Mobiles';
  List<File> images=[];
  List<String> categoryProducts=[
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  //select Image
  void selecteImages()async{
        var res=await pickImges();
        if(mounted){
        setState((){
           images = res! ;
        });
        
        }
  }
  // sell Products
  void sellProduct(){
    if(_addProductKey.currentState!.validate()){
    adminServices.sellProduct(
      context: context,
      name: productNameController.text,
      description: productdesciptionController.text,
      price:double.parse(productpriceController.text),
      quantity:double.parse(productquantityController.text) ,
      category: category,
      images: images,
      );
    }return;
  }
  @override
  void dispose() {
    productNameController.dispose();
    productdesciptionController.dispose();
    productpriceController.dispose();
    productquantityController.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title:const Text('Add Product',style: TextStyle(color: Colors.black),)
          ),
        ),
        body:SingleChildScrollView(
          child:Form(
            key: _addProductKey,
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Column(
                children: [
                    const SizedBox(height:3),
                    images.isNotEmpty? CarouselSlider(
                   items:images.map(
                     (item) => Builder(
                     builder:(context)=>Image.file(item,fit:BoxFit.cover,height:200),
                    )
                   ).toList(),
                   options:CarouselOptions(
                     viewportFraction: 1,
                     height:200,
                   ),
                   )
                   :
                    GestureDetector(
                    onTap:selecteImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const[10,4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                      width:double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           const Icon(Icons.folder_open_outlined,size: 40,),
                           const SizedBox(height:30),
                           Text(
                            'Select Product Images',
                            style: TextStyle(
                              color:Colors.grey[500],
                              fontSize: 15,
                            ),
                            ),
                        ],
                      ),
                    ),
                    ),
                  ),
                  const SizedBox(height:30),
                  CustomTextField(controller: productNameController, hintTitle: 'Product Name',),
                  const SizedBox(height:10),
                  CustomTextField(controller: productdesciptionController, hintTitle: 'Product description',maxLines: 8,),
                  const SizedBox(height:10),
                  CustomTextField(controller: productpriceController, hintTitle: 'Product price'),
                  const SizedBox(height:10),
                  CustomTextField(controller: productquantityController, hintTitle: 'quantity Name'),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child:DropdownButton(
                      items:categoryProducts.map((item){
                        return DropdownMenuItem(
                           value: item,
                           child: Text(item),
                          );
                      }).toList() ,
                      value:category,
                      icon:const Icon(Icons.keyboard_arrow_down),
                      onChanged: (newVal){
                          setState(() {
                             category=newVal!;
                          });
                      }

                      )
                  ),
                  const SizedBox(height:10),
                  CustomButton(
                    text: 'Sale',
                    onPressed: sellProduct,
                    )
                ],
                ),
            )
              )
        ),
    );
  }
}