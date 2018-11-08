import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class RankingPage extends StatelessWidget{

  final List<charts.Series> seriesList;
  final bool animate;

  RankingPage(this.seriesList, {this.animate});

  /// Creates a [BarChart] with custom rounded bars.
  factory RankingPage.withSampleData() {
    return new RankingPage(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override

  Widget build(BuildContext context) {

    final title = 'Hotel Users Ranking';

    return MaterialApp(
      title: title,

      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading:
          IconButton(
            icon: Icon(
              Icons.arrow_back,

            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),

        body:new charts.BarChart(
          seriesList,
          animate: animate,
          defaultRenderer: new charts.BarRendererConfig(
            // By default, bar renderer will draw rounded bars with a constant
            // radius of 100.
            // To not have any rounded corners, use [NoCornerStrategy]
            // To change the radius of the bars, use [ConstCornerStrategy]
              cornerStrategy: const charts.ConstCornerStrategy(30)),
        ),
      ),

    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
     ];
    }
  }



  /// Sample ordinal data type.
  class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
  }