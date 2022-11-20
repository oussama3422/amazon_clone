

import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/widget/single_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {


  List<Product>? products;
  final AdminServices adminService=AdminServices();

   @override
   void initState() { 
     super.initState();
     fetchAllProducts();
   }

   fetchAllProducts()async{
    products= await adminService.fetchAllProducts(context);
    setState(() { });
   }

  navigateToAddProductScreen(){
    Navigator.pushNamed(context,AddProductScreen.routeName);
  }
  //delete Product Function
  void deleteProdutById(Product product,int index)
  {
   adminService.deleteProduct(
    context: context, 
   product: product,
   onSucess: (){
    products!.removeAt(index);
    setState(() {});
   }
   );
  }
  @override
  Widget build(BuildContext context) {
    return products==null? const Loader() 
    : Scaffold(
      body:GridView.builder(
        itemCount: products!.length,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final productData=products![index];
        return Column(
          children: [
            SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleProduct(
                  img: productData.images[0]
                ),
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                       Expanded(
                        child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontFamily: 'FiraCode'),
                          )
                          ),
                          IconButton(
                            onPressed:()=> deleteProdutById(productData,index),
                            icon: const Icon(Icons.delete_outline,color:Colors.red)
                            )
              ],
              )
          ],
        );
      }
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:navigateToAddProductScreen,
        tooltip: 'Add a Product',
        child: const Icon(Icons.add,size:50),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}