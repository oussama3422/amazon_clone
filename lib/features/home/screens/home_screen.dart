import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../../../contants/global_variables.dart';
import '../widgets/craousel_image.dart';
import '../widgets/deal_of_day.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName='home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  void navigatToSearch(String query){
   Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height:42,
                  margin: const EdgeInsets.only(left: 15),
                  child:Material(
                    borderRadius:BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatToSearch,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){},
                          child: const Padding(
                            padding: EdgeInsets.only(top:6),
                            child: Icon(Icons.search,color: Colors.black,size:32),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top:10),
                        border:  const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide(color: Colors.black38,width:1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle:const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color:Colors.transparent,
                height:42,
                margin:const EdgeInsets.symmetric(horizontal: 10),
                child:IconButton(
                  icon:const Icon(Icons.mic,size:28,color:Colors.black),
                  onPressed: (){},
                  )
              )
            ],
          ),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children:const [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImage(),
            DealOfDay(),
          ],
        ),
      ),

    );
  }
}