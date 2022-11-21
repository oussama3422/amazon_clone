import 'package:flutter/material.dart';
import '../module/sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CategoryProductChart extends StatelessWidget {
   final List<charts.Series<Sales,String>> seriesList;
  // final seriesList;
  const CategoryProductChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  charts.BarChart(
      seriesList,
      animate:true,
    );
  }
}

