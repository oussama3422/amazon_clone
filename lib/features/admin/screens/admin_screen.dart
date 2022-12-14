
import 'package:amazon_clone/features/admin/screens/analtyics.dart';
import 'package:amazon_clone/features/admin/screens/orders_screens.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import '../../../contants/global_variables.dart';
import '../../account/screens/account_screen.dart';
import '../../home/screens/home_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   int _page=0;
  double bottomBarWith=42;
  double bottomBarBorderWith=5;

  List<Widget> pages=[
     const PostsScreen(),
     const AnaltyicsScreen(),
     const OrdersScreen(),
  ];
  updatePage(int page){
    setState(() {
      _page=page;
    });
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
              Container(
                alignment: Alignment.topLeft,
                child:Image.asset('images/amazon_in.png',width:120,height:45,color:Colors.black),
              ),
             const Text('Admin',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
            ],
          ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //  POSTS
          BottomNavigationBarItem(
            icon: Container(
            width: bottomBarWith,
            decoration: BoxDecoration(
              border: Border(
                top:BorderSide(
                  color:_page==0?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                  width: bottomBarBorderWith,
                  ),
                
              ),
            ),
            child:const Icon(Icons.post_add_sharp) ,
          ),
          label: '',
          ),
          //Profile
          BottomNavigationBarItem(
            icon: Container(
            width: bottomBarWith,
            decoration: BoxDecoration(
              border: Border(
                top:BorderSide(
                  color:_page==1?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                  width: bottomBarBorderWith,
                  ),
                
              ),
            ),
            child:const Icon(Icons.analytics) ,
          ),
          label: '',
          ),
          //Orders
          BottomNavigationBarItem(
            icon: Container(
            width: bottomBarWith,
            decoration: BoxDecoration(
              border: Border(
                top:BorderSide(
                  color:_page==2?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                  width: bottomBarBorderWith,
                  ),
                
              ),
            ),
            child:const Icon(Icons.all_inbox_outlined) ,
          ),
          label: '',
          ),
        ],
        ),
        body: pages[_page],

    );
  }
}