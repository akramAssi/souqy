import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
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
  String make;
  String model;
  int flag = 0;

  TextEditingController _makeController;
  TextEditingController _modelController;
  var modelSouqyFormField;
  var souqySearchForBrand;
  final _makeFoucs = FocusNode();
  _StatisticPageState() {
    _makeController = TextEditingController();
    _makeController.addListener(onChangeMake);
    _modelController = TextEditingController();
    _modelController.addListener(onChangeModel);
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
  void onChangeMake() {
    make = _makeController.text;
  }

  void onChangeModel() {
    flag = 1;
    model = _modelController.text;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        souqySearchForBrand,
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 3,
              child: modelSouqyFormField,
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: IconButton(
                    splashRadius: 30,
                    iconSize: 40,
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Image.asset("images/statisticsButton.png")),
              ),
            )
          ],
        ),
        StatisticCard(
          flag: flag,
          make: make,
          model: model,
        ),
        SizedBox(
          height: 60,
        )
      ],
    );
  }
}
