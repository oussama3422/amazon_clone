import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_scree.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page=0;
  double bottomBarWith=42;
  double bottomBarBorderWith=5;

  List<Widget> pages=[
     const HomeScreen(),
     const AcountScreen(),
     const Center(child: Text('CARD PAGE'),),
  ];
  updatePage(int page){
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    final userCarLen=context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //home
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
            child:const Icon(Icons.home_outlined) ,
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
            child:const Icon(Icons.person) ,
          ),
          label: '',
          ),
          //Card
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
            child:Badge(
              elevation: 0,
              badgeContent:  Text(userCarLen.toString()),
              badgeColor: Colors.orange,
              child: const Icon(Icons.shopping_cart_outlined)
              ) ,
          ),
          label: '',
          ),
        ],
        ),

    );
  }
}