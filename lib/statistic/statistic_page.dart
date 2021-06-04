import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/data_folder_tester/brand_list.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/statistic/statistic_card.dart';
import 'package:souqy/widget/auto.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage>
    with SouqyFormFieldStyle {
  SouqyAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String searchType;
  String make;
  String model;
  bool showErrorText = false;
  final _modelFoucs = FocusNode();
  int flag = 0;
  List<int> _yearList = [];
  TextEditingController _yearController;
  TextEditingController _makeController;
  TextEditingController _modelController;
  var modelSouqyFormField;
  var souqySearchForBrand;
  var yearSouqyFormField;

  final _makeFoucs = FocusNode();
  _StatisticPageState() {
    final year = DateTime.now().year;
    for (int i = year; i >= 1965; i--) {
      _yearList.add(i);
    }
    _yearController = TextEditingController();
    _makeController = TextEditingController();
    _makeController.addListener(onChangeMake);
    _modelController = TextEditingController();

    souqySearchForBrand = SouqySearchForBrand(
      controller: _makeController,
      focusNode: _makeFoucs,
      isVisibil: false,
    );
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
    _modelController.addListener(chageSugt);
    textField = SouqyAutoCompleteTextField(
      controller: _modelController,
      focusNode: _modelFoucs,
      key: key,
      suggestions: list12,
      clearOnSubmit: false,
      textChanged: (text) {
        text.isEmpty ? showErrorText = false : showErrorText = false;
        valid();
      },
      textSubmitted: (text) {
        text.isEmpty ? showErrorText = false : showErrorText = false;
        valid();
      },
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
  }
  void _goNext(FocusNode nextNode) {
    // FocusNode newNode =
    //     widget.emailVAlidator.isValid(_email) ? _passwordFoucs : _emailFoucs;
    FocusScope.of(context).requestFocus(nextNode);
  }

  void onPressYear(dynamic value) {
    setState(() {
      _yearController.text = value?.toString() ?? "${DateTime.now().year}";
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

  void onChangeMake() {
    setState(() {
      make = _makeController.text;
    });
  }

  List<String> list12 = [];
  void chageSugt() {
    list12 = [];
    if (_makeController.text.isEmpty) {
      return;
    }
    dataFromFile.forEach((element) {
      if (_makeController.text.toLowerCase() == element.getMake() &&
          element.getModel().contains(_modelController.text.toLowerCase())) {
        list12.add(element.getModel());
      }
    });
    list12 = list12.toSet().toList();
    textField.updateSuggestions(list12);
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: yearSouqyFormField,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 3,
                child: modelSouqyFormField,
              ),
            ],
          ),
        ),
        StatisticCard(
          flag: flag,
          make: _makeController.text,
          model: _modelController.text,
          year: _yearController.text,
        ),
        SizedBox(
          height: 60,
        )
      ],
    );
  }

  void valid() {
    setState(() {
      if (showErrorText) {
        textField.updateDecoration(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 13),
                errorText:
                    showErrorText ? Strings.requiredField(Strings.model) : null,
                enabledBorder: souqyEnableBorder,
                focusedErrorBorder: souqyErrorBorder,
                errorBorder: souqyErrorBorder,
                focusedBorder: souqyFocusBorder));
      } else {
        if (textField == null) return;
        textField?.updateDecoration(
            decoration: InputDecoration(
                fillColor: primeCOLOR,
                filled: false,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 13),
                enabledBorder: souqyEnableBorder,
                focusedErrorBorder: souqyErrorBorder,
                errorBorder: souqyErrorBorder,
                focusedBorder: souqyFocusBorder));
      }
    });
  }
}
