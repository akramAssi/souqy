import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StatisticCard extends StatefulWidget {
  final int flag;

  const StatisticCard({Key key, this.flag}) : super(key: key);
  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  TooltipBehavior _tooltipBehavior;
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'brand');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(statisticColor[50]);
    color.add(statisticColor[100]);
    color.add(statisticColor[200]);
    color.add(statisticColor[300]);
    color.add(statisticColor[400]);
    color.add(statisticColor[500]);
    color.add(statisticColor[600]);
    color.add(statisticColor[700]);
    color.add(statisticColor[800]);
    color.add(statisticColor[900]);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.1);
    stops.add(0.2);
    stops.add(0.3);
    stops.add(0.4);
    stops.add(0.5);
    stops.add(0.6);
    stops.add(0.7);
    stops.add(0.8);
    stops.add(0.9);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops);
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.grey,
              )
            ]),
        height: 300,
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: SfCartesianChart(
          title: ChartTitle(
            text: Strings.statisticPrice,
            textStyle: TextStyle(color: statisticFontColor),
          ),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            AreaSeries<SalesData, double>(
              gradient: gradientColors,
              borderColor: Colors.black,
              isVisibleInLegend: false,
              dataSource: getChartData(),
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: false),
              enableTooltip: true,
              animationDuration: 5000,
            )
          ],
          primaryXAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelStyle: TextStyle(color: statisticFontColor),
          ),
          primaryYAxis: NumericAxis(
            numberFormat:
                NumberFormat.simpleCurrency(decimalDigits: 0, name: 'ILS'),
            labelStyle: TextStyle(color: statisticFontColor),
          ),
        ));
  }

  List<SalesData> getChartData() {
    if (widget.flag == 0) {
      final List<SalesData> chartData = [
        SalesData(2011, 2),
        SalesData(2012, 2),
        SalesData(2013, 2),
        SalesData(2014, 2),
        SalesData(2015, 2),
        SalesData(2016, 2),
        SalesData(2017, 2),
        SalesData(2018, 2),
        SalesData(2019, 2),
        SalesData(2020, 2),
        SalesData(2021, 2),
      ];
      return chartData;
    } else {
      final List<SalesData> chartData = [
        SalesData(2011, 5000000),
        SalesData(2012, 4800000),
        SalesData(2013, 4000000),
        SalesData(2014, 4300000),
        SalesData(2015, 3400000),
        SalesData(2016, 3000000),
        SalesData(2017, 2800000),
        SalesData(2018, 2900000),
        SalesData(2019, 3800000),
        SalesData(2020, 3600000),
        SalesData(2021, 5000000),
      ];
      return chartData;
    }
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
