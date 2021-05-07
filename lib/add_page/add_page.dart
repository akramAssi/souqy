import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/moreInfoPage/souqy_imge_slider.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/dialog/souqy_button_dialog.dart';
import 'package:souqy/widget/kilo_input_cell.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';
import 'package:souqy/widget/dialog/year_dialog.dart';
import 'package:souqy/widget/souqy_submit_button.dart';

import 'car_type.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _makeController;
  TextEditingController _modelController;
  TextEditingController _yearController;
  TextEditingController _engineController;
  TextEditingController _gearController;
  TextEditingController _fuelController;
  TextEditingController _colorController;
  TextEditingController _vehicleOriginController;
  TextEditingController _ownerController;
  TextEditingController _expectedPriceController;
  TextEditingController _priceController;
  TextEditingController _paymentController;

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
    'راعش',
    'جنط',
    'تهبيط',
    'اضافات ستيرنغ',
    'فتحة سقف',
    'طبابين معدل',
    'عطاس',
    'عدة صوت',
    'كراسي جلد',
    'تدفئة مقاعد',
  ];

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
    _expectedPriceController = TextEditingController();
    _priceController = TextEditingController();
    _paymentController = TextEditingController();
    _gearController.text = "Gear";
    _fuelController.text = "Fuel";
    _colorController.text = "Color";
    _vehicleOriginController.text = "Origin";
    _ownerController.text = "0";
    final year = DateTime.now().year;
    for (int i = year; i >= 1965; i--) {
      _yearList.add(i);
    }
    for (int i = 900; i <= 6500; i += 50) {
      _engineList.add(i);
    }
  }

  void onPressYear(dynamic value) {
    setState(() {
      _yearController.text = value.toString();
    });
    Navigator.of(context).pop();
  }

  void onPressEngine(dynamic value) {
    setState(() {
      _engineController.text = value.toString();
    });
    Navigator.of(context).pop();
  }

  void _openDialog(
      {BuildContext context, List list, void Function(dynamic) onPress}) {
    showYear(
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

  void _submit() {
    print("make : ${_makeController.text}");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          SouqySearchForBrand(
            controller: _makeController,
          ),
          CarType(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SouqyTextField(
                    lable: "Year",
                    controller: _yearController,
                    height: 50,
                    isReadOnly: true,
                    textAlign: TextAlign.center,
                    onTop: () {
                      _openDialog(
                          context: context,
                          list: _yearList,
                          onPress: onPressYear);
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * .03,
                ),
                Flexible(
                  flex: 3,
                  child: SouqyTextField(
                    lable: "Model",
                    controller: _modelController,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),

          ///end 3th row year and model
          // SizedBox(
          //   height: 15,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Text(
              "kilometer",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KiloInputCell(),
              KiloInputCell(),
              KiloInputCell(),
              KiloInputCell(),
              KiloInputCell(),
              KiloInputCell(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: SouqyTextField(
                    lable: "Engine Size",
                    controller: _engineController,
                    height: 50,
                    textAlign: TextAlign.center,
                    onTop: () {
                      _openDialog(
                          context: context,
                          list: _engineList,
                          onPress: onPressEngine);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: SouqyButtonDialog(
                    gearController: _gearController,
                    list: _gearList,
                    lable: "Gear Type",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: SouqyButtonDialog(
                    gearController: _fuelController,
                    list: _fuelList,
                    lable: "Fuel Type",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: SouqyTextField(
                    lable: "Color",
                    controller: _colorController,
                    height: 50,
                    isReadOnly: true,
                    textAlign: TextAlign.center,
                    color: currentColor,
                    filled: true,
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
                  ),
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
                          border: Border.all(color: Colors.black54),
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
                                      TextSelection.fromPosition(TextPosition(
                                          offset:
                                              _ownerController.text.length));
                                },
                                onTap: () => _ownerController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _ownerController.text.length)),
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
                  child: SouqyButtonDialog(
                    gearController: _vehicleOriginController,
                    list: _vehicleOriginList,
                    lable: "Vehicle origin",
                    withIcon: false,
                  ),
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
          Container(
            margin: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              'Car features',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            width: size.width,
            child: GroupButton(
              unselectedBorderColor: Colors.grey,
              selectedColor: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              selectedTextStyle: TextStyle(
                color: fontColor,
              ),
              isRadio: false,
              spacing: 10,
              onSelected: (index, isSelected) {
                if (isSelected) {
                  _checkedItemList.add(allItemList[index]);
                  print(_checkedItemList);
                } else if (!isSelected) {
                  _checkedItemList.remove(allItemList[index]);
                  print(_checkedItemList);
                }
              },
              buttons: allItemList,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 7),
            child: Text(
              'Additional information',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              textInputAction: TextInputAction.done,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.zero,
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'add text ..',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primeCOLOR,
                    ),
                    borderRadius: BorderRadius.circular(20)),
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
            decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
              child: Text(
                "Expected price is available to the advertiser only",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
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
                  flex: 3,
                  child: SouqyTextField(
                    lable: "Expected price",
                    controller: _expectedPriceController,
                    lableFontSize: 20,
                    isReadOnly: true,
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
                              side: BorderSide(color: BorderColor),
                            ),
                            padding: EdgeInsets.all(12)),
                        child: Image.asset("images/expect.png"),
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
            child: SouqyTextField(
              lable: "price",
              controller: _priceController,
              lableFontSize: 20,
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
                    lable: "Payment method",
                    showLable: false,
                    height: 60,
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
              width: size.width / 2,
              child: SouqySubmitBotton(
                label: "publishing",
                height: 45,
                fontSize: 15,
                onPress: () {
                  _submit();
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
