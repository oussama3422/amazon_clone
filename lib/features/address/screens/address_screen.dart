import 'package:amazon_clone/contants/global_variables.dart';
import 'package:amazon_clone/contants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key,required this.totalAmount});
  final int totalAmount;
  static const String routeName='/address-screen';
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final TextEditingController flatBuilthingcontroller=TextEditingController();
  final TextEditingController areacontoller=TextEditingController();
  final TextEditingController pincodeController=TextEditingController();
  final TextEditingController townContoller=TextEditingController();
  
  final addressFormKey=GlobalKey<FormState>();
  AdressServices adressServices=AdressServices();

  @override
  void dispose() {
    flatBuilthingcontroller.dispose();
    areacontoller.dispose();
    pincodeController.dispose();
    townContoller.dispose();
    super.dispose();
  }

 void googlePayResult(res){
 if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
  adressServices.saveUserAdress(context: context, address: addressTobeUse);
 }
 adressServices.placeOrder(context: context, address: addressTobeUse, totalSum: widget.totalAmount.toDouble());

  }
   String addressTobeUse="";
  void payPressed(String adressFromProvider)
  {
    addressTobeUse="";
    bool isForm=flatBuilthingcontroller.text.isNotEmpty 
    || areacontoller.text.isNotEmpty 
    || pincodeController.text.isNotEmpty
    || townContoller.text.isNotEmpty;
    if(isForm)
    {
      if(addressFormKey.currentState!.validate())
      {
        addressTobeUse='${flatBuilthingcontroller.text},${areacontoller.text},${townContoller.text} - ${pincodeController.text}';
      }else{
        throw Exception('Please Enter All The Values');
      } 
    }else if(adressFromProvider.isNotEmpty){
        addressTobeUse=adressFromProvider;
    }else{
      showSnackBar(context, 'ERROR');
    }
    print(addressTobeUse);
  }
  List<PaymentItem> paymentItems=[];
 
  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount.toString(),
        label: 'Total Amount',
        status: PaymentItemStatus.final_price
        )
        );
  }
  @override
  Widget build(BuildContext context) {
    // var address=context.watch<UserProvider>().user.address;
    var address='Cooperative Azizia Tameslohte';
    return Scaffold(

       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace:Container(
            decoration:const  BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          
        )
        ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if(address.isNotEmpty)
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:Colors.black
                    ),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      address,
                      style: const TextStyle(fontSize: 18,fontFamily: 'FiraCode'),
                      ),
                  )
                ),
                const SizedBox(height: 20),
                const Text('Or',style:TextStyle(fontSize: 18,fontFamily: 'FiraCode')),
                const SizedBox(height: 10),
              ],
            ),
            
            Form(
                            key: addressFormKey,
                            child: Column(
                            children: [
                               CustomTextField(controller:flatBuilthingcontroller,hintTitle: 'Flat, House no,Building',),
                               const SizedBox(height: 10),
                               CustomTextField(controller:areacontoller,hintTitle: 'Area , Street',),
                               const SizedBox(height: 10),
                               CustomTextField(controller:pincodeController,hintTitle: 'Pincode',),
                               const SizedBox(height: 10),
                               CustomTextField(controller:townContoller,hintTitle: 'Town/City',),
                            ],
                          )
                          ),
                          const SizedBox(height: 20),
              GooglePayButton(
                onPressed: () =>payPressed(address),
                width: double.infinity,
                type:GooglePayButtonType.buy,
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: googlePayResult,
                paymentItems: paymentItems,
                margin:const EdgeInsets.only(top:10),
                loadingIndicator:const Center(child:CircularProgressIndicator()) ,
                )
             
          ],
        ),
      ),
    ),

    );
  }
}