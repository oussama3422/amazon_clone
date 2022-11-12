import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/deal_category_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
      switch (routeSettings.name) {
        case AuthScreen.routeName:
            return MaterialPageRoute(builder: (_)=>const AuthScreen(),settings: routeSettings);
        case HomeScreen.routeName:
            return MaterialPageRoute(builder: (_)=>const HomeScreen(),settings: routeSettings);
        case AddProductScreen.routeName:
            return MaterialPageRoute(builder: (_)=>const AddProductScreen(),settings: routeSettings);
        case DealCateogryScreen.routeName:
            var category=routeSettings.arguments as String;
            return MaterialPageRoute(builder: (_)=>DealCateogryScreen(category: category),settings: routeSettings);
        case SearchScreen.routeName:
            var searchQuery=routeSettings.arguments as String;
            return MaterialPageRoute(builder: (_)=> SearchScreen(searchQuery:searchQuery),settings: routeSettings);
        case ProductDetailsScreen.routeName:
            var product=routeSettings.arguments as Product;
            return MaterialPageRoute(builder: (_)=>  ProductDetailsScreen(product:product),settings: routeSettings);
        default:
          return MaterialPageRoute(builder: (_)=>const Scaffold(
            body: Center(
              child: Text('Screen Does Not Exists'),
            ),
          )
          );
      }

}