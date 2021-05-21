import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/statistic/statistic_card.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  String searchType;
  int chartData = 0;

  TextEditingController _makeController;
  TextEditingController _modelController;
  var modelSouqyFormField;
  var souqySearchForBrand;
  final _makeFoucs = FocusNode();
  _LineChartSample2State() {
    _makeController = TextEditingController();

    _modelController = TextEditingController();
    _modelController.addListener(changeFlag);
    modelSouqyFormField = SouqyFormField(
      label: Strings.model,
      controller: _modelController,
      height: 50,
      validator: Validators.required(Strings.requiredFieldo),
    );
    souqySearchForBrand = SouqySearchForBrand(
      controller: _makeController,
      focusNode: _makeFoucs,
      isVisibil: false,
    );
  }

  void onChangeModel(String value) {
    setState(() {
      print(value);
    });
  }

  void changeFlag() {
    setState(() {
      if (_modelController.text == '') {
        chartData = 0;

        print(chartData);
      } else if (_modelController.text.isNotEmpty) {
        chartData = 1;

        print(chartData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        souqySearchForBrand,
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: modelSouqyFormField,
        ),
        StatisticCard(flag: chartData),
      ],
    );
  }
}
