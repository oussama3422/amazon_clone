import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    var user=Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration:const BoxDecoration(
        gradient: LinearGradient(colors: [
              Color.fromARGB(255, 114, 226, 222),
              Color.fromARGB(255, 163, 235, 233)
        ],
        stops: [0.5,1.0],
        )
      ),
      padding: const EdgeInsets.only(left:10),
      child: Row(
        children: [
            const Icon(Icons.location_on_outlined,size:20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:8),
                child: Text('Dilivrey to ${user.name} - ${user.address}',style: const TextStyle(fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
                )
              ),
          //padding
          const Padding(
            padding: EdgeInsets.only(left:5,top:5),
            child:Icon(Icons.arrow_drop_down_outlined,size:18)
            )
        ],
      ),
    );
  }
}