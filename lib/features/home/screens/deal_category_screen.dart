import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../contants/global_variables.dart';
import '../../../models/product.dart';

class DealCateogryScreen extends StatefulWidget {
  final String category;
  const DealCateogryScreen({super.key,required this.category});
  //create Route Name
  static const String routeName='/category-deals';

  @override
  State<DealCateogryScreen> createState() => _DealCateogryScreenState();
}

class _DealCateogryScreenState extends State<DealCateogryScreen> {

  List<Product>? productList;
  HomeServices homeServices=HomeServices();
  @override
  void initState() {
  fecthCategoryProduct();
  super.initState();
  }
void fecthCategoryProduct()async{
  productList=await homeServices.fetchCategoryProduct(context: context, category: widget.category);
  setState((){});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: Text(
            widget.category,
            style:const TextStyle(color: Colors.black)
            ),
          ),
        ),
     body:productList==null?const Loader():Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          alignment:Alignment.topLeft ,
          child:Text('Shooping for ${widget.category}',style: const TextStyle(fontSize: 20),)
        ),
        SizedBox(
                    height:170,
                    child:GridView.builder(
                       itemCount: productList!.length,
                       scrollDirection: Axis.horizontal,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                        ),
                      itemBuilder: (context,index){
                        final product=productList![index];
                        return GestureDetector(
                          onTap:(){
                            Navigator.pushNamed(context,ProductDetailsScreen.routeName,arguments: product);
                          },
                          child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child:DecoratedBox(
                                decoration:  
                              BoxDecoration(
                                border: Border.all(
                                  color:Colors.black,
                                )
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                                )
                            )
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding:const EdgeInsets.only(left:0,top:5,right:15),
                              child:Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,),
                            )
                          ],
                                              
                                              ),
                        );
                      }
                    ),
              ),
      ],
     )
    );
  }
}