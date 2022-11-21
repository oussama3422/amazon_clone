import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../module/sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../widgets/category_product_chart.dart';

class AnaltyicsScreen extends StatefulWidget {
  const AnaltyicsScreen({super.key});

  @override
  State<AnaltyicsScreen> createState() => _AnaltyicsScreenState();
}

class _AnaltyicsScreenState extends State<AnaltyicsScreen> {
  final AdminServices adminServices=AdminServices();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState(){
    getEarnings();
    super.initState();
  }

  getEarnings()async{
    var earningData=await adminServices.getEarning(context);
    totalSales=earningData['totalEarnings'];
    earnings=earningData['sales'];
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return earnings==null || totalSales==null
    ?
    const Loader()
    :
    Column(
      children: [
        Text('\$$totalSales'),
        SizedBox(
          height: 250,
          child: CategoryProductChart(
            seriesList:[
              charts.Series(
              id: 'Sales',
              data: earnings!,
              domainFn: (Sales sales,_)=>sales.label,
              measureFn: (Sales sales,_)=>sales.earning,
              )
               ]
              ),
        )
      ],
    );
  }
}