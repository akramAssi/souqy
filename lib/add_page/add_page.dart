import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/souqy_kilometer_textFiled.dart';
import 'package:souqy/widget/souqy_left_right_button_feild.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:souqy/view_controller/ads_controller.dart';

import 'car_type.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SouqyFormFieldStyle {
  //Textfor all field Controller
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
  TextEditingController _priceController;
  TextEditingController _paymentController;
  TextEditingController _downPaymentController;
  TextEditingController _monthlyPaymentController;
  var souqyKilometerTextField = SouqyKilometerTextField();
  bool showPaymentDetail = false;
  var carType = CarType();
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
  List<String> _myImages = [];
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
  var downPaymentSouqyFormField;
  var monthlyPaymentSouqyFormField;
  var orginSouqyButtonDialog;
  _AddPageState() {
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
    _priceController = TextEditingController();
    _paymentController = TextEditingController();
    _downPaymentController = TextEditingController();
    _monthlyPaymentController = TextEditingController();
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

    downPaymentSouqyFormField = SouqyFormField(
        label: Strings.downPayment,
        controller: _downPaymentController,
        height: 50,
        validator: Validators.compose([
          Validators.required(Strings.passwordInValidRequired),
          Validators.patternRegExp(
              RegExp(r"^[0-9]\d*(\.\d+)?$"), Strings.phoneInValidNotString),
        ]));
    monthlyPaymentSouqyFormField = SouqyFormField(
        label: Strings.monthlyPayment,
        controller: _monthlyPaymentController,
        height: 50,
        validator: Validators.compose([
          Validators.required(Strings.passwordInValidRequired),
          Validators.patternRegExp(
              RegExp(r"^[0-9]\d*(\.\d+)?$"), Strings.phoneInValidNotString),
        ]));
    _paymentController.addListener(onchangedPyment);
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
      _passengerController.text = value.toString();
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
      if (owner > 0) {
        _ownerController.text = "${--owner}";
      }
    });
  }

  void onchangedPyment() {
    setState(() {
      if (_paymentController.text.contains("installments")) {
        showPaymentDetail = true;
      } else {
        showPaymentDetail = false;
      }
    });
  }

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _myImages.add(pickedFile.path);
      }
    });
  }

  var pressed = Colors.white;
  _imgFromGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _myImages.add(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void remove(dynamic value) {
    setState(() {
      _myImages.remove(value);
    });
  }

  void _submit(String type) {
    print("make : ${_makeController.text}");
    print("year : ${_yearController.text}");
    print("type : $type");
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
    print("price ${_priceController.text}");
    print("payment ${_paymentController.text}");

    var x = Ads.fromJson({
      "cardInfo": {
        "make": _makeController.text,
        "model": _modelController.text,
        "price": int.parse(_priceController.text),
        "year": int.parse(_yearController.text),
        "origin": _vehicleOriginController.text,
        "fuel": _fuelController.text,
        "avaliable": true,
        "paymentMethod": _paymentController.text,
        "urlThumb": _myImages.length > 0 ? _myImages[0] : null,
      },
      "moreInfo": {
        "type": type,
        "kilo": souqyKilometerTextField.kilometer,
        "engineSize": int.parse(_engineController.text.trim()),
        "passenger": int.parse(_passengerController.text),
        "color": currentColor.toString(),
        "gear": _gearController.text,
        "oldOwner": owner,
        "listImage": _myImages,
        "carFeature": _checkedItemList,
        "additionalInformation": _addInfoController.text,
        "downPayment": (_downPaymentController.text == null ||
                _downPaymentController.text.isEmpty)
            ? null
            : int.parse(_downPaymentController.text),
        "monthlyPayment": (_monthlyPaymentController.text == null ||
                _monthlyPaymentController.text.isEmpty)
            ? null
            : int.parse(_monthlyPaymentController.text),
        "userId": locator.get<UserController>().currentUser.uid,
      }
    });
    print(x.toJson());
    locator.get<AdsController>().createAds(x);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
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
                      child: colorSouqyFormField,
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
                    Flexible(flex: 1, child: fuelSouqyButtonDialog),
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

              Center(
                child: _myImages.isEmpty
                    ? SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : SouqyImageSlider(
                        imageList: _myImages,
                        source: "File",
                        autoPlay: false,
                        onLongPress: remove,
                      ),
                // : SouqyImageLoader(
                //     myImages: _myImages,
                //   ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: primeCOLOR,
                  ),
                  child: IconButton(
                    splashRadius: 30,
                    onPressed: () {
                      _showPicker(context);
                    },
                    icon: Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
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
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 7),
                child: Text(
                  Strings.additionalInformation,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: size.width,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _addInfoController,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: souqyEnableBorder,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'add text ..',
                    focusedBorder: souqyFocusBorder,
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
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
                        Strings.paymentMethod,
                        style: TextStyle(fontSize: 20, color: primeCOLOR),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: SouqyButtonDialog(
                        gearController: _paymentController,
                        list: _payment,
                        label: Strings.paymentMethod,
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
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: showPaymentDetail,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(flex: 1, child: downPaymentSouqyFormField),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(flex: 1, child: monthlyPaymentSouqyFormField),
                    ],
                  ),
                ),
              ),
              Container(
                // height: 45,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  right: size.width / 3.5,
                  top: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: SouqyFormField(
                        label: Strings.expectedPrice,
                        controller: _expectedPriceController,
                        labelFontSize: 20,
                        isReadOnly: true,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: primeCOLOR,
                                shape: CircleBorder(
                                  side: BorderSide(color: borderColor),
                                ),
                                padding: EdgeInsets.all(12)),
                            child: Image.asset(
                              "images/expect.png",
                              color: fontColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SouqyFormField(
                  label: "price",
                  controller: _priceController,
                  labelFontSize: 20,
                  keyboardType: TextInputType.number,
                  height: 50,
                  validator:
                      Validators.required(Strings.requiredField(Strings.price)),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              Center(
                child: SizedBox(
                  width: size.width / 1.5,
                  child: SouqySubmitBotton(
                    label: Strings.publishing,
                    height: 45,
                    fontSize: 15,
                    onPress: () {
                      // _formKey.currentState.validate();
                      if (_formKey.currentState.validate()) {
                        _submit(carType.typeSelected);
                      }
                    },
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
    _ownerController.selection = TextSelection.fromPosition(
        TextPosition(offset: _ownerController.text.length));
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
}
