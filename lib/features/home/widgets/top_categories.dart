import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/deal_category_screen.dart';
import 'package:flutter/material.dart';



class TopCategories extends StatelessWidget {
  const TopCategories({super.key});
  

  void navigateToCategoryScreen(String category,BuildContext context)
  {
  Navigator.pushNamed(
    context,
    DealCateogryScreen.routeName,
    arguments: category
    );

  
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child:ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: ()=>navigateToCategoryScreen(GlobalVariables.categoryImages[index]['title']!, context),
            child: Column(
              children: [
                   Container(
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child:Image.asset(GlobalVariables.categoryImages[index]['image']!,fit: BoxFit.cover,height: 40,width: 40,),
                    ),
                   ),
                   Text(GlobalVariables.categoryImages[index]['title']!,style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
                   
              ],
            ),
          );
        }, 
        )
    );
  }
}