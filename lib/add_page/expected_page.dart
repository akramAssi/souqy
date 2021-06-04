import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:group_button/group_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/data_folder_tester/brand_list.dart';

import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/widget/auto.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/souqy_kilometer_textFiled.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/souqy_left_right_button_feild.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'car_type.dart';

class ExpectedPage extends StatefulWidget {
  @override
  _ExpectedPageState createState() => _ExpectedPageState();
}

class _ExpectedPageState extends State<ExpectedPage> with SouqyFormFieldStyle {
  //Textfor all field Controller
  bool showErrorText = false;
  bool selected = false;
  bool showCarTypeRec = false;
  TextEditingController _makeController;

  TextEditingController _modelController;

  TextEditingController _yearController;

  TextEditingController _engineController;

  TextEditingController _passengerController;

  TextEditingController _gearController;

  TextEditingController _fuelController;

  TextEditingController _colorController;

  TextEditingController _vehicleOriginController;

  TextEditingController _ownerController;

  TextEditingController _addInfoController;

  TextEditingController _expectedPriceController;

  TextEditingController _paymentController;
  SouqyAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  var souqyKilometerTextField = SouqyKilometerTextField();

  bool _saving = false;

  var carType;

  var souqySearchForBrand;

  // focusNode
  final _makeFoucs = FocusNode();

  final _modelFoucs = FocusNode();

  List<int> _yearList = [];

  List<int> _engineList = [];

  List<int> _passengerList = [];

  List<String> _payment = ["Cash ", " installments"];

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

  List<String> _checkedItemList = [];

  List<String> allItemList = [
    "Alarm device",
    "Air conditioner",
    "CD recorder",
    "Sunroof",
    "Leather brushes",
    "Sentral closure",
    "Magnesium rims",
    "Airbag protection"
  ];
  var modelSouqyFormField;
  var yearSouqyFormField;
  var carFGroupButton;
  var engineSouqyFormField;
  var passengerSouqyFormField;
  var gearSouqyButtonDialog;
  var fuelSouqyButtonDialog;
  var colorSouqyFormField;
  var orginSouqyButtonDialog;
  _ExpectedPageState() {
    _makeController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
    _engineController = TextEditingController();
    _passengerController = TextEditingController();
    _gearController = TextEditingController();
    _fuelController = TextEditingController();
    _colorController = TextEditingController();
    _vehicleOriginController = TextEditingController();
    _ownerController = TextEditingController();
    _addInfoController = TextEditingController();
    _expectedPriceController = TextEditingController();
    _paymentController = TextEditingController();
    souqySearchForBrand = SouqySearchForBrand(
      controller: _makeController,
      focusNode: _makeFoucs,
    );
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
    for (int i = 1; i <= 55; i += 1) {
      _passengerList.add(i);
    }
    carType = CarType(
      onChangeSearch: carTypeSelected,
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
        text.isEmpty ? showErrorText = true : showErrorText = false;
        valid();
      },
      textSubmitted: (text) {
        text.isEmpty ? showErrorText = true : showErrorText = false;
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
    passengerSouqyFormField = SouqyFormField(
      label: Strings.passenger,
      controller: _passengerController,
      height: 50,
      textAlign: TextAlign.center,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        _openDialog(
            context: context, list: _passengerList, onPress: onPressPassenger);
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
    colorSouqyFormField = SouqyFormField(
      label: Strings.color,
      controller: _colorController,
      height: 50,
      isReadOnly: true,
      textAlign: TextAlign.center,
      color: currentColor,
      filled: true,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  Strings.colorDialog,
                ),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: primeCOLOR,
                    onColorChanged: changeColor,
                    availableColors: carColor,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      Strings.colorDialogButton,
                      textAlign: TextAlign.left,
                    ),
                    onPressed: () {
                      setState(() => currentColor = pickerColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
    );
    orginSouqyButtonDialog = SouqyButtonDialog(
      gearController: _vehicleOriginController,
      list: _vehicleOriginList,
      label: Strings.origin,
      // withIcon: false,
      validator: Validators.required(Strings.requiredFieldo),
    );
    carFGroupButton = GroupButton(
      unselectedColor: backgroundColor,
      unselectedBorderColor: borderTextfieldColor,
      selectedColor: primeCOLOR,
      borderRadius: BorderRadius.circular(15),
      unselectedTextStyle: TextStyle(
        color: fontColor,
      ),
      selectedTextStyle: TextStyle(
        color: backgroundColor,
      ),
      isRadio: false,
      spacing: 10,
      onSelected: (index, isSelected) {
        if (isSelected) {
          _checkedItemList.add(allItemList[index]);
        } else if (!isSelected) {
          _checkedItemList.remove(allItemList[index]);
        }
      },
      buttons: allItemList,
    );
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

  void onPressEngine(dynamic value) {
    setState(() {
      _engineController.text = value?.toString() ?? _engineList[0].toString();
    });
    Navigator.of(context).pop();
  }

  void onPressPassenger(dynamic value) {
    setState(() {
      _passengerController.text =
          value?.toString() ?? _passengerList[0].toString();
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

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void increaseOwner() {
    setState(() {
      if (owner < 50) {
        _ownerController.text = "${++owner}";
      }
    });
  }

  void decreaseOwner() {
    setState(() {
      print(owner);
      if (owner > 0) {
        _ownerController.text = "${--owner}";
      }
    });
  }

  void _submit(String type) {
    print("make : ${_makeController.text}");
    print("type : $type");
    print("year : ${_yearController.text}");
    print("model : ${_modelController.text}");
    print("model : ${souqyKilometerTextField.kilometer}");
    print("engin : ${_engineController.text}");
    print("gear : ${_gearController.text}");
    print("gear : ${_gearController.text}");
    print("fuel : ${_fuelController.text}");
    print("color : ${currentColor.toString()}");
    print("old owner : $owner");
    print("origin : ${_vehicleOriginController.text}");
    print("features ${_checkedItemList.toString()}");
    print("origin : ${_addInfoController.text}");
    print("payment ${_paymentController.text}");
  }

  void expect() async {
    if (selected) {
      setState(() {
        showCarTypeRec = false;
      });
    } else {
      setState(() {
        showCarTypeRec = true;
      });
    }
    if (_formKey.currentState.validate()) {
      setState(() {
        _saving = true;
      });
      List<int> feature = [0, 0, 0, 0, 0, 0, 0, 0];
      for (var x in _checkedItemList) {
        feature[allItemList.indexOf(x)] = 1;
      }
      String url = "https://c202a4c07cfd.ngrok.io/?Make=${_makeController.text.toLowerCase()}&Model=${_modelController.text.toLowerCase()}" +
          "&type=${carType.typeSelected.toLowerCase()}&Color=${nameColor[carColor.indexOf(currentColor)].toLowerCase()}" +
          "&fuel=${_fuelController.text.toLowerCase()}&history=${_vehicleOriginController.text.toLowerCase()}" +
          "&gear=${_gearController.text.toLowerCase()}&py=${_paymentController.text.toLowerCase()}&windo=electric" +
          "&pass=${_passengerController.text.toLowerCase()}&year=${_yearController.text}&eng=${_engineController.text}" +
          "&f1=${feature[0]}&f2=${feature[1]}&f3=${feature[2]}&f4=${feature[3]}&f5=${feature[4]}" +
          "&f6=${feature[5]}&f7=${feature[6]}&f8=${feature[7]}&km=${souqyKilometerTextField.kilometer}&po=$owner";

      var graphResponse = await http.get(Uri.parse(url));
      var profile = json.decode(graphResponse.body);
      setState(() {
        _expectedPriceController.text = profile["price"];
        _saving = false;
      });
    }
    // print(nameColor[carColor.indexOf(currentColor)]);
  }

  void carTypeSelected(bool flag, String myType) {
    setState(() {
      _passengerController.text = '';
      passengerCount(myType);
      selected = flag;
      if (selected) {
        showCarTypeRec = false;
      } else {
        showCarTypeRec = true;
      }
    });
  }

  void passengerCount(String type) {
    _passengerList = [];
    if (type == null || type == '' || type == 'Other' || type == 'Van') {
      for (int i = 1; i <= 55; i += 1) {
        _passengerList.add(i);
      }
    } else if (type == 'Hatch' || type == 'Sedan') {
      _passengerList = [5];
    } else if (type == 'Coupe') {
      _passengerList = [4];
    } else if (type == 'Pickup') {
      _passengerList = [2, 5];
    } else if (type == 'SUV') {
      _passengerList = [5, 6, 7, 8];
    } else if (type == 'Minivan') {
      _passengerList = [5, 6, 7];
    } else if (type == 'Truck') {
      _passengerList = [2, 3, 5, 6, 7];
    }
    passengerSouqyFormField = SouqyFormField(
      label: Strings.passenger,
      controller: _passengerController,
      height: 50,
      textAlign: TextAlign.center,
      validator: Validators.required(Strings.requiredFieldo),
      onTop: () {
        _openDialog(
            context: context, list: _passengerList, onPress: onPressPassenger);
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: _saving,
      color: borderTextfieldColor,
      progressIndicator: SouqyStyle.souqyIndicator,
      child: Form(
        key: _formKey,
        child: Container(
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                souqySearchForBrand,
                // first widget have search and brand list
                carType,
                Visibility(
                    visible: showCarTypeRec,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: alertColor,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                Strings.requiredField(Strings.type),
                                style: TextStyle(
                                  color: alertColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
                // type car widget
                rowYearAndModel(context, size),

                ///end 3th row year and model
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    Strings.kilo,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                souqyKilometerTextField,
                //kilometer textfield
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                        child: passengerSouqyFormField,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: colorSouqyFormField = SouqyFormField(
                          label: Strings.color,
                          controller: _colorController,
                          height: 50,
                          isReadOnly: true,
                          textAlign: TextAlign.center,
                          color: currentColor,
                          filled: true,
                          validator:
                              Validators.required(Strings.requiredFieldo),
                          onTop: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      Strings.colorDialog,
                                    ),
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor: primeCOLOR,
                                        onColorChanged: changeColor,
                                        availableColors: carColor,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          Strings.colorDialogButton,
                                          textAlign: TextAlign.left,
                                        ),
                                        onPressed: () {
                                          setState(
                                              () => currentColor = pickerColor);
                                          print(currentColor.toString());
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: orginSouqyButtonDialog,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(flex: 1, child: Container()),
                      Flexible(
                        flex: 1,
                        child: SouqyLeftRightButtonField(
                            leftButton: increaseOwner,
                            rightButton: decreaseOwner,
                            onChanged: onChangedOwner,
                            controller: _ownerController),
                      ),
                      Flexible(flex: 1, child: Container()),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    Strings.carFeatures,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  width: size.width,
                  child: carFGroupButton,
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment method",
                          style: TextStyle(fontSize: 20, color: primeCOLOR),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SouqyButtonDialog(
                          gearController: _paymentController,
                          list: _payment,
                          label: "Payment method",
                          showlabel: false,
                          height: 50,
                          // size: size,
                          validator: Validators.required(
                              Strings.requiredField(Strings.paymentMethod)),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  // height: 45,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                    right: size.width / 3.5,
                    top: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 25),
                  decoration: BoxDecoration(
                      color: alertColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Text(
                    Strings.alartPriceExpected,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SouqyFormField(
                    label: Strings.expectedPrice,
                    controller: _expectedPriceController,
                    labelFontSize: 20,
                    isReadOnly: true,
                    height: 50,
                  ),
                ),

                SizedBox(
                  height: 40,
                ),

                Center(
                  child: SizedBox(
                    width: size.width / 1.5,
                    child: SouqySubmitBotton(
                      label: Strings.expected,
                      icon: "images/expect.png",
                      height: 45,
                      fontSize: 15,
                      onPress: expect,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChangedOwner(value) {
    setState(() {
      if (value.isEmpty) {
        owner = 0;
        _ownerController.text = "";
      } else {
        int temp = int.parse(value);

        if (owner < 50 && owner >= 0) {
          owner = temp;
          _ownerController.text = "$owner";
        } else if (owner > 50) {
          owner = 49;
          _ownerController.text = "49";
        } else if (owner < 0) {
          owner = 0;
          _ownerController.text = "0";
        }
      }
    });
  }

  Padding rowYearAndModel(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: yearSouqyFormField,
          ),
          SizedBox(
            width: size.width * .03,
          ),
          Flexible(
            flex: 3,
            child: modelSouqyFormField,
          ),
        ],
      ),
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
