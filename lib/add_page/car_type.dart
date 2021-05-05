import 'package:flutter/material.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/color.dart';

// ignore: must_be_immutable
class CarType extends StatefulWidget {
  List<String> myProducts;
  CarType({
    key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CarType();
}

class _CarType extends State<CarType> {
  List<String> onchangeList = [];

  int loc;
  String typee;
  int setSelected;
  @override
  void initState() {
    super.initState();

    onchangeList = carTypeList;
  }

  var flag = 0;
  void filterType(String query) {
    var se;
    if (query == '') {
      se = carTypeList;
    } else {
      se = carTypeList.where((element) {
        final queryLower = query;
        final elementLower = element;
        return elementLower == queryLower;
      }).toList();
    }
    setState(() {
      this.onchangeList = se;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      height: setSelected != 0 ? 170 : 80,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? size.width / 3
                    : size.width / 7,
            childAspectRatio: 3,
          ),
          itemCount: onchangeList.length,
          itemBuilder: (BuildContext ctx, index) {
            return ChoiceChip(
              avatar: InkWell(
                child: setSelected == 0
                    ? Image.asset(
                        'images/carType/' + carTypeList[loc] + '.png',
                      )
                    : Image.asset(
                        'images/carType/' + carTypeList[index] + '.png',
                      ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: BorderColor, width: 1.0)),
              label: Text(onchangeList[index]),
              selected: setSelected == index,
              selectedColor: Colors.grey,
              onSelected: (bool selected) {
                if (selected) {
                  typee = carTypeList[index];
                  loc = index;
                  filterType(typee);
                  setSelected = 0;
                  print(index);
                } else if (!selected) {
                  setSelected = null;
                  filterType('');
                  print(onchangeList);
                }
              },
              backgroundColor: Colors.white,
              labelStyle: TextStyle(color: fontColor),
            );
          }),
    );
  }
}
