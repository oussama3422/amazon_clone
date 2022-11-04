import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/features/auth/auth_screen.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        colorScheme:const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme:const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color:Colors.black,
          )
        )
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        appBar:AppBar(
          centerTitle: true,
          title: const Text('Amazon Clone'),
          ),
          body:Column(
            children:[ 
            const Center(
            child:  Text('Amazone Clone')
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(onPressed: (){Navigator.pushNamed(context,AuthScreen.routeName );}, child: const Text('Click')
                );
              }
            )
            ]
            ),
          ),
    );
  }
}