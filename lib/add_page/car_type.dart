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
  CarTypeControler type = CarTypeControler();
  int loc;
  String typee;
  int setSelected;
  @override
  void initState() {
    super.initState();

    onchangeList = type.arabic;
  }

  var flag = 0;
  void filterType(String query) {
    var se;
    if (query == '') {
      se = type.arabic;
    } else {
      se = type.arabic.where((element) {
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
      height: setSelected != 0 ? 150 : 60,
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
                        'images/carType/' + type.english[loc] + '.png',
                      )
                    : Image.asset(
                        'images/carType/' + type.english[index] + '.png',
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
                  typee = type.arabic[index];
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
