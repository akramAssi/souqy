import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/search_page/price_range.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SearchButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchButton();
}

class _SearchButton extends State<StatefulWidget> {
  String searchType;
//Textfor all field Controller
  TextEditingController _makeController;
  TextEditingController _modelController;
  TextEditingController _yearController;
  TextEditingController _engineController;
  TextEditingController _gearController;
  TextEditingController _fuelController;
  TextEditingController _colorController;
  TextEditingController _vehicleOriginController;
  TextEditingController _ownerController;
  TextEditingController _typeController;

  // focusNode
  final _makeFoucs = FocusNode();
  final _modelFoucs = FocusNode();

  List<int> _yearList = [];
  List<int> _engineList = [];
  final List<String> _gearList = ["Manual", "Automatic"];
  final List<String> _fuelList = ["Patrol", "Diesel", "Hybrid", "Electric"];
  final List<String> _vehicleOriginList = [
    "private",
    "taxi",
    "governmental",
    "commercial",
    "school"
  ];

  int owner = 0;
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;
  var rangeValuesStart;
  var rangeValuesEnd;
  var modelSouqyFormField;
  var yearSouqyFormField;
  var carFGroupButton;
  var engineSouqyFormField;
  var gearSouqyButtonDialog;
  var fuelSouqyButtonDialog;
  var colorSouqyFormField;
  var orginSouqyButtonDialog;
  var typeSouqyFormField;
  _SearchButton() {
    _makeController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
    _engineController = TextEditingController();
    _gearController = TextEditingController();
    _fuelController = TextEditingController();
    _colorController = TextEditingController();
    _vehicleOriginController = TextEditingController();
    _ownerController = TextEditingController();
    _typeController = TextEditingController();

    // _gearController.text = "Gear";
    // _fuelController.text = "Fuel";
    _colorController.text = Strings.color;
    // _vehicleOriginController.text = "Origin";
    _ownerController.text = "0";
    final year = DateTime.now().year;
    for (int i = year; i >= 1965; i--) {
      _yearList.add(i);
    }
    for (int i = 900; i <= 6500; i += 50) {
      _engineList.add(i);
    }

    yearSouqyFormField = SouqyFormField(
      label: Strings.year,
      controller: _yearController,
      height: 50,
      isReadOnly: true,
      textAlign: TextAlign.center,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        _openDialog(context: context, list: _yearList, onPress: onPressYear);
      },
    );

    modelSouqyFormField = SouqyFormField(
      label: Strings.model,
      controller: _modelController,
      focusNode: _modelFoucs,
      height: 50,
      validator: Validators.required(Strings.requiredFieldo),
    );

    typeSouqyFormField = SouqyFormField(
      label: Strings.type,
      controller: _typeController,
      height: 50,
      textAlign: TextAlign.center,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        _openDialog(context: context, list: carTypeList, onPress: onPressType);
      },
    );
    engineSouqyFormField = SouqyFormField(
      label: Strings.engineSize,
      controller: _engineController,
      height: 50,
      textAlign: TextAlign.center,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        _openDialog(
            context: context, list: _engineList, onPress: onPressEngine);
      },
    );
    gearSouqyButtonDialog = SouqyButtonDialog(
      gearController: _gearController,
      list: _gearList,
      label: Strings.gearType,
      validator: Validators.required(Strings.requiredFieldo),
    );
    fuelSouqyButtonDialog = SouqyButtonDialog(
      gearController: _fuelController,
      list: _fuelList,
      label: Strings.fuelType,
      validator: Validators.required(Strings.requiredFieldo),
    );
    orginSouqyButtonDialog = SouqyButtonDialog(
      gearController: _vehicleOriginController,
      list: _vehicleOriginList,
      label: Strings.origin,
      // withIcon: false,
      validator: Validators.required(Strings.requiredFieldo),
    );
  }

  void _goNext(FocusNode nextNode) {
    // FocusNode newNode =
    //     widget.emailVAlidator.isValid(_email) ? _passwordFoucs : _emailFoucs;
    FocusScope.of(context).requestFocus(nextNode);
  }

  void onPressType(dynamic value) {
    setState(() {
      print("ark" + value.toString());
      _typeController.text = value?.toString() ?? carTypeList[0].toString();
    });
    Navigator.of(context).pop();
    _goNext(_modelFoucs);
  }

  void onPressYear(dynamic value) {
    setState(() {
      print("ark" + value.toString());
      _yearController.text = value?.toString() ?? "${DateTime.now().year}";
    });
    Navigator.of(context).pop();
    _goNext(_modelFoucs);
  }

  void onPressEngine(dynamic value) {
    setState(() {
      _engineController.text = value?.toString() ?? _engineList[0].toString();
    });
    Navigator.of(context).pop();
  }

  void _openDialog(
      {BuildContext context, List list, void Function(dynamic) onPress}) {
    showBotomSheatDialogWithOneColumn(
      context: context,
      list: list,
      onPress: onPress,
    );
  }

  void filterSearchType(String query) {
    setState(() {
      searchType = query;
    });
  }

  void onChangeRange(RangeValues values) {
    rangeValuesStart = values.start;
    rangeValuesEnd = values.end;
    print(rangeValuesStart.toString() + '  ' + rangeValuesEnd.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        searchType == searchFilter[0] || searchType == null
            ? Column(children: [
                SouqySearchForBrand(
                  controller: _makeController,
                  focusNode: _makeFoucs,
                  onChangeSearch: filterSearchType,
                  choose: searchFilter[0],
                  isVisibil: true,
                ),
                Column(
                  children: [
                    PriceRaing(onChange: onChangeRange),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: modelSouqyFormField,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: typeSouqyFormField,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: yearSouqyFormField,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: engineSouqyFormField,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: gearSouqyButtonDialog,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: fuelSouqyButtonDialog,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                SouqyHomePage(),
              ])
            : SouqySearchForBrand(
                controller: _makeController,
                focusNode: _makeFoucs,
                onChangeSearch: filterSearchType,
                choose: searchFilter[1],
                isVisibil: true,
              ),
      ],
    );
  }
}
