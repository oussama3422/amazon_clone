import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../contants/global_variables.dart';
import '../../../models/order.dart';
import '../../search/screens/search_screen.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {

  static const String routeName='/order-details';
  final Order order;
  const OrderDetails({required this.order,super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep=0;
  AdminServices adminServices=AdminServices();
  @override
  void initState() { 
    super.initState();
    currentStep= widget.order.status;
  }
  // !!!ONLY FROM ADMIN !!!
  void changeOrderStatus(int status){
     adminServices.changeOrderStatus(
      context: context,
       status: status+1,
       order: widget.order,
       onSucess: (){
        currentStep+=1;
       }
       );
  }
// navigate To The Search Screen
  void navigatToSearch(String query){
   Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    var user=context.watch<UserProvider>().user;
    return Scaffold(
    appBar:  PreferredSize(
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
    body:SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'View order details',
              style:TextStyle(fontSize: 22,fontFamily: 'FiraCode',fontWeight:FontWeight.bold)
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border:Border.all(color:Colors.black)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Text('Order Date:     ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}',style: const TextStyle(fontFamily: 'FiraCode'),),
                      Text('Order ID:      ${widget.order.id}',style: const TextStyle(fontFamily: 'FiraCode'),),
                      Text('Order Total:     \$${widget.order.totalPrice}',style:const TextStyle(fontFamily: 'FiraCode'),)
                ],
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            'Purchase details',
            style:TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'FiraCode',
            )
          ),
          Container(
              decoration: BoxDecoration(
                border:Border.all(color:Colors.black)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                   for (int i=0;i<widget.order.products.length;i++)
                     Row(
                      children: [
                        Image.network(widget.order.products[i].images[0],height: 120,width: 120,),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            children: [
                              Text(widget.order.products[i].name,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,fontFamily: 'FiraCode'),overflow:TextOverflow.ellipsis,maxLines: 2,),
                              Text('Qty: ${widget.order.quantity[i].toString()}',style:const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'FiraCode'))
                            ],
                          )
                          )
                        ],
                     ),
                     const Text(
                      'Tracking',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FiraCode',
                        ),
                        ),
                ],
              ),
            ),
          Container(
              decoration: BoxDecoration(
                border:Border.all(color:Colors.black)
              ),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                if(user.type=="admin"){
                  return CustomButton(
                    text: 'Done',
                    onPressed:(){
                      return changeOrderStatus(details.currentStep);
                      }
                      );
                }
                return const SizedBox();

                },
                steps:[
                  Step(state:currentStep>0?StepState.complete:StepState.indexed, isActive: currentStep>=0,title:const Text('Pending'),content:const  Text('Your order is yet to be dilivered'),),
                  Step(state:currentStep>1?StepState.complete:StepState.indexed, isActive: currentStep>1,title:const Text('Completed'),content:const Text('Your order has been dilivered,you are yet to sign')),
                  Step(state:currentStep>2?StepState.complete:StepState.indexed, isActive: currentStep>2,title:const Text('Received'),content:const Text('Your order has been dilivered and singed by you')),
                  Step(state:currentStep>=3?StepState.complete:StepState.indexed, isActive: currentStep>=3,title:const Text('Dilivered'),content:const Text('Your order has been dilivered and singed by you!')),
                ] 
                ),
            ),
          ],
        ),
      ),
    )



      
    );
  }
}