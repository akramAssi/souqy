import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/search_page/price_range.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/ads_controller.dart';

import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/res/style.dart';

class SearchButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchButton();
}

class _SearchButton extends State<StatefulWidget> with SouqyFormFieldStyle {
  String searchType;
//Textfor all field Controller
  TextEditingController _makeController;
  TextEditingController _modelController;
  TextEditingController _gearController;
  TextEditingController _fuelController;
  bool showErrorText = false;
  SimpleAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
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

  List<Ads> listAds = [];
  int owner = 0;
  Color pickerColor = Colors.white;
  Color currentColor = Colors.white;
  int rangePriceStart = 0,
      rangePriceEnd = 1000000,
      rangeYearStart = 1965,
      rangeYearEnd = DateTime.now().year,
      rangeEngStart = 900,
      rangeEngEnd = 6500;
  var modelSouqyFormField;
  var gearSouqyButtonDialog;
  var fuelSouqyButtonDialog;
  var typeSouqyFormField;
  var souqySearchForBrand;
  _SearchButton() {
    _makeController = TextEditingController();
    _modelController = TextEditingController();
    _gearController = TextEditingController();
    _fuelController = TextEditingController();
    _typeController = TextEditingController();

    final year = DateTime.now().year;
    for (int i = year; i >= 1965; i--) {
      _yearList.add(i);
    }
    for (int i = 900; i <= 6500; i += 50) {
      _engineList.add(i);
    }

    // modelSouqyFormField = SouqyFormField(
    //   label: Strings.model,
    //   controller: _modelController,
    //   focusNode: _modelFoucs,
    //   height: 50,
    // );

    textField = SimpleAutoCompleteTextField(
      controller: _modelController,
      focusNode: _modelFoucs,
      key: key,
      suggestions: ["akrma", "naser", "hamza"],
      clearOnSubmit: false,
      textChanged: (text) {},
      textSubmitted: (text) {},
      decoration: InputDecoration(
          fillColor: primeCOLOR,
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 13),
          enabledBorder: souqyEnableBorder,
          focusedErrorBorder: souqyErrorBorder,
          errorBorder: souqyErrorBorder,
          focusedBorder: souqyFocusBorder),
    );
    modelSouqyFormField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.model,
          style: TextStyle(
            color: primeCOLOR,
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          constraints: BoxConstraints(minHeight: 50),
          child: textField,
        ),
      ],
    );
    typeSouqyFormField = SouqyFormField(
      label: Strings.type,
      controller: _typeController,
      height: 50,
      textAlign: TextAlign.center,
      onTop: () {
        _openDialog(context: context, list: carTypeList, onPress: onPressType);
      },
    );

    gearSouqyButtonDialog = SouqyButtonDialog(
      gearController: _gearController,
      list: _gearList,
      label: Strings.gearType,
    );
    fuelSouqyButtonDialog = SouqyButtonDialog(
      gearController: _fuelController,
      list: _fuelList,
      label: Strings.fuelType,
    );
    souqySearchForBrand = SouqySearchForBrand(
      controller: _makeController,
      focusNode: _makeFoucs,
      onChangeSearch: filterSearchType,
      choose: searchFilter[0],
      isVisibil: true,
    );
    _makeController.addListener(searchMethod);
    _modelController.addListener(searchMethod);
    _gearController.addListener(searchMethod);
    _fuelController.addListener(searchMethod);
    _typeController.addListener(searchMethod);
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
    rangePriceStart = values.start.toInt();
    rangePriceEnd = values.end.toInt();
    searchMethod();
  }

  void onChangeYear(RangeValues values) {
    rangeYearStart = values.start.toInt();
    rangeYearEnd = values.end.toInt();
    searchMethod();
  }

  void onChangeEng(RangeValues values) {
    rangeEngStart = values.start.toInt();
    rangeEngEnd = values.end.toInt();
    searchMethod();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        searchType == searchFilter[0] || searchType == null
            ? Column(children: [
                souqySearchForBrand,
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border: Border.all(width: 1, color: borderColor)),
                      child: Column(
                        children: [
                          PriceRaing(
                            rangeType: Strings.year,
                            min: 1965,
                            max: DateTime.now().year.toDouble(),
                            step: DateTime.now().year,
                            onChange: onChangeYear,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PriceRaing(
                            rangeType: Strings.priceRange,
                            min: 0,
                            max: 1000000,
                            step: 1000,
                            onChange: onChangeRange,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PriceRaing(
                            rangeType: Strings.engineSize,
                            min: 900,
                            max: 6500,
                            step: 112,
                            onChange: onChangeEng,
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
                            child: modelSouqyFormField,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            flex: 1,
                            child: typeSouqyFormField,
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
                SouqyHomePage(shrinkWrap: false, list: listAds)
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

  void searchMethod() {
    print("------------");
    locator.get<AdsController>().search().then((value) {
      listAds = value;
      if (_makeController.text != null && _makeController.text.isNotEmpty) {
        listAds = listAds
            .where((element) => element.make
                .toLowerCase()
                .contains(_makeController.text.toLowerCase().trim()))
            .toList();
      }
      listAds = listAds.where((element) {
        bool x = false;
        if (element.year >= rangeYearStart && element.year <= rangeYearEnd) {
          if (element.price >= rangePriceStart &&
              element.price <= rangePriceEnd) {
            if (element.engineSize >= rangeEngStart &&
                element.engineSize <= rangeEngEnd) {
              x = true;
            }
          }
        }
        return x;
      }).toList();

      if (_modelController.text != null && _modelController.text.isNotEmpty) {
        listAds = listAds
            .where((element) =>
                element.model.contains(_modelController.text.trim()))
            .toList();
      }
      if (_gearController.text != null && _gearController.text.isNotEmpty) {
        print(_gearController.text);
        listAds = listAds
            .where(
                (element) => element.gear.contains(_gearController.text.trim()))
            .toList();
      }
      if (_typeController.text != null && _typeController.text.isNotEmpty) {
        listAds = listAds
            .where(
                (element) => element.type.contains(_typeController.text.trim()))
            .toList();
      }
      if (_fuelController.text != null && _fuelController.text.isNotEmpty) {
        listAds = listAds
            .where(
                (element) => element.fuel.contains(_fuelController.text.trim()))
            .toList();
      }
      // listAds = value;
      setState(() {});
    });
  }
}
