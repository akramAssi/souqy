import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:souqy/data_folder_tester/brand_list.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data_folder_tester/data_reader.dart';

class StatisticCard extends StatefulWidget {
  final int flag;
  final String make;
  final String model;
  const StatisticCard({
    Key key,
    this.flag = 0,
    this.make,
    this.model,
  }) : super(key: key);
  @override
  _StatisticCardState createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  TooltipBehavior _tooltipBehavior;
  List<Mylist> list;
  List<SalesData> list1 = [];
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, header: 'brand');

    super.initState();
  }

  finder() {
    list = [];
    list = dataFromFile.where((element) {
      return element.getMake() == widget.make.toLowerCase() &&
          element.getModel() == widget.model.toLowerCase();
    }).toList();
    if (list.length != 0) {
      list.sort((a, b) => a.getDate().compareTo(b.getDate()));
      print("make000=${list.length}");
    } else
      list = [];
    print("make=${list.length}");
  }

  finder11() {
    if (widget.make.isNotEmpty && widget.model.isNotEmpty) {
      finder();
      list1 = [];
      if (list.length != 0) {
        for (Mylist x in list) list1.add(SalesData(x.getDate(), x.getPrice()));
      }

      // print("make=${list[0].getDate()}");
    }
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
    if ((widget.make != null && widget.model != null)) finder11();
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
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
          ),
          enableSideBySideSeriesPlacement: false,
          series: <ChartSeries<SalesData, DateTime>>[
            AreaSeries<SalesData, DateTime>(
              gradient: gradientColors,
              borderColor: Colors.black,
              isVisibleInLegend: false,
              dataSource: getChartData(),
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              dataLabelSettings: DataLabelSettings(isVisible: false),
              enableTooltip: true,
              animationDuration: 5000,
            ),
          ],
          primaryYAxis: NumericAxis(
            numberFormat:
                NumberFormat.simpleCurrency(decimalDigits: 0, name: 'ILS'),
            labelStyle: TextStyle(color: statisticFontColor),
            labelFormat: '{value}k',
          ),
          primaryXAxis: DateTimeAxis(
            dateFormat: DateFormat.yMd(),
            isInversed: false,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelStyle: TextStyle(color: statisticFontColor),
          ),
          // primaryXAxis: NumericAxis(
          //   edgeLabelPlacement: EdgeLabelPlacement.shift,
          //   labelStyle: TextStyle(color: statisticFontColor),
          // ),
        ));
  }

  List<SalesData> getChartData() {
    if (widget.flag == 0) {
      final List<SalesData> chartData = [
        SalesData(DateTime(DateTime.now().year - 3, 1), 2),
        SalesData(DateTime.now(), 2),
      ];
      return chartData;
    } else {
      final List<SalesData> chartData = list1;
      if (chartData.isNotEmpty) return chartData;
    }

    return [
      SalesData(DateTime(DateTime.now().year - 3, 1), 2),
      SalesData(DateTime.now(), 2),
    ];
  }
}
