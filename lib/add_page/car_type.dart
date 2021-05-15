import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/color.dart';

// ignore: must_be_immutable
class CarType extends StatefulWidget {
  List<String> myProducts;
  int loc;
  int setSelected;
  List<String> onchangeList = [];
  CarType({
    key,
  }) : super(key: key) {
    onchangeList = carTypeList;
  }
  String typeSelected = "";

  @override
  State<StatefulWidget> createState() => _CarType();
}

class _CarType extends State<CarType> {
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
      widget.onchangeList = se;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(widget.loc);
    return Container(
      // margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: widget.setSelected != 0 ? 180 : 80,
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? size.width / 3
                    : size.width / 6,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            childAspectRatio: 3,
          ),
          itemCount: widget.onchangeList.length,
          itemBuilder: (BuildContext ctx, index) {
            return ChoiceChip(
              avatar: Padding(
                padding: const EdgeInsets.all(5.0),
                child: widget.setSelected == 0
                    ? Image.asset(
                        'images/carType/' + carTypeList[widget.loc] + '.png',
                        width: 30,
                        color: fontColor,
                      )
                    : Image.asset(
                        'images/carType/' + carTypeList[index] + '.png',
                        width: 30,
                        color: fontColor,
                      ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: borderColor, width: 1.0)),
              label: Container(
                alignment: Alignment.center,
                width: 60,
                child: AutoSizeText(widget.onchangeList[index]),
              ),
              selected: widget.setSelected == index,
              selectedColor: Colors.grey,
              onSelected: (bool selected) {
                if (selected) {
                  widget.typeSelected = carTypeList[index];
                  widget.loc = index;
                  filterType(widget.typeSelected);
                  widget.setSelected = 0;
                } else if (!selected) {
                  widget.setSelected = null;
                  filterType('');
                  widget.typeSelected = "";
                }
              },
              backgroundColor: backgroundColor,
              labelStyle: TextStyle(color: fontColor),
            );
          }),
    );
  }
}
