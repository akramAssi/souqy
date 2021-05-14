import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/souqy_kilometer_textFiled.dart';
import 'package:souqy/widget/souqy_text_filed.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';
import 'package:souqy/widget/souqy_submit_button.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

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
  TextEditingController _gearController;
  TextEditingController _fuelController;
  TextEditingController _colorController;
  TextEditingController _vehicleOriginController;
  TextEditingController _ownerController;
  TextEditingController _addInfoController;
  TextEditingController _expectedPriceController;
  TextEditingController _priceController;
  TextEditingController _paymentController;
  var souqyKilometerTextField = SouqyKilometerTextField();
  var carType = CarType();
  var souqySearchForBrand;

  // focusNode
  final _makeFoucs = FocusNode();
  final _modelFoucs = FocusNode();

  List<int> _yearList = [];
  List<int> _engineList = [];
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
  var gearSouqyButtonDialog;
  var fuelSouqyButtonDialog;
  var colorSouqyFormField;
  var orginSouqyButtonDialog;
  _AddPageState() {
    _makeController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
    _engineController = TextEditingController();
    _gearController = TextEditingController();
    _fuelController = TextEditingController();
    _colorController = TextEditingController();
    _vehicleOriginController = TextEditingController();
    _ownerController = TextEditingController();
    _addInfoController = TextEditingController();
    _expectedPriceController = TextEditingController();
    _priceController = TextEditingController();
    _paymentController = TextEditingController();
    souqySearchForBrand = SouqySearchForBrand(
      controller: _makeController,
      focusNode: _makeFoucs,
    );
    // _gearController.text = "Gear";
    // _fuelController.text = "Fuel";
    _colorController.text = "Color";
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
      label: "Year",
      controller: _yearController,
      height: 50,
      isReadOnly: true,
      textAlign: TextAlign.center,
      validator: Validators.required("requi"),
      onTop: () {
        _openDialog(context: context, list: _yearList, onPress: onPressYear);
      },
    );
    modelSouqyFormField = SouqyFormField(
      label: "Model",
      controller: _modelController,
      focusNode: _modelFoucs,
      height: 50,
      validator: Validators.required("requi"),
    );

    engineSouqyFormField = SouqyFormField(
      label: "Engine Size",
      controller: _engineController,
      height: 50,
      textAlign: TextAlign.center,
      validator: Validators.required("requi"),
      onTop: () {
        _openDialog(
            context: context, list: _engineList, onPress: onPressEngine);
      },
    );
    gearSouqyButtonDialog = SouqyButtonDialog(
      gearController: _gearController,
      list: _gearList,
      label: "Gear Type",
      validator: Validators.required("requi"),
    );
    fuelSouqyButtonDialog = SouqyButtonDialog(
      gearController: _fuelController,
      list: _fuelList,
      label: "Fuel Type",
      validator: Validators.required("requi"),
    );
    colorSouqyFormField = SouqyFormField(
      label: "Color",
      controller: _colorController,
      height: 50,
      isReadOnly: true,
      textAlign: TextAlign.center,
      color: currentColor,
      filled: true,
      validator: Validators.required("requi"),
      onTop: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Choose the vehicle color',
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
                    child: const Text(
                      'choose',
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
      label: "origin",
      withIcon: false,
      validator: Validators.required("requi"),
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

  void _goNext(FocusNode nextNode) {
    // FocusNode newNode =
    //     widget.emailVAlidator.isValid(_email) ? _passwordFoucs : _emailFoucs;
    FocusScope.of(context).requestFocus(nextNode);
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
      _engineController.text = value.toString();
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

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _myImages.add(pickedFile.path);
      } else {
        print('No image selected.');
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
      } else {
        print('No image selected.');
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
    print("price ${_priceController.text}");
    print("payment ${_paymentController.text}");
  }

  final _formKey = GlobalKey<FormState>();
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
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
                  "Kilometer",
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: colorSouqyFormField,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Old Owner",
                            style: TextStyle(
                              color: primeCOLOR,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderTextfieldColor),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.zero,
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Ink(
                                      child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: increaseOwner)),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _ownerController,
                                    maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"^[1-4]?[0-9]$")),
                                    ],
                                    decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(8),
                                      counter: Offstage(),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          owner = 0;
                                          _ownerController.text = "";
                                        } else {
                                          int temp = int.parse(value);
                                          print(owner);
                                          if (owner < 50 && owner >= 0) {
                                            print("ok :$owner");
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
                                      _ownerController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: _ownerController
                                                      .text.length));
                                    },
                                    onTap: () => _ownerController.selection =
                                        returnToLast(_ownerController),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Ink(
                                    child: IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: decreaseOwner),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
              Center(
                child: SizedBox(
                  width: size.width / 1.5,
                  child: SouqySubmitBotton(
                    label: "publishing",
                    height: 45,
                    fontSize: 15,
                    onPress: () {
                      _formKey.currentState.validate();
                      // if (_formKey.currentState.validate()) {
                      //   _submit(carType.typeSelected);
                      // }
                    },
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
              Container(
                // height: 45,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                  right: size.width / 3.5,
                  top: 20,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
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
                        label: "Expected price",
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
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
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
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: SizedBox(
                  width: size.width / 1.5,
                  child: SouqySubmitBotton(
                    label: "publishing",
                    height: 45,
                    fontSize: 15,
                    onPress: () {
                      _formKey.currentState.validate();
                      // if (_formKey.currentState.validate()) {
                      //   _submit(carType.typeSelected);
                      // }
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

  Padding rowYearAndModel(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
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
