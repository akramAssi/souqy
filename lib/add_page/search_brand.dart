import 'package:flutter/material.dart';
import 'package:souqy/add_page/souqy_search_filed.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/style.dart';

import '../res/color.dart';

class SouqySearchForBrand extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  String count = '';
  List<String> onchangeList = [];
  SouqySearchForBrand(
      {Key key, @required this.controller, @required this.focusNode})
      : super(key: key) {
    onchangeList = brands;
    controller.text = count;
  }
  @override
  State<StatefulWidget> createState() => _SouqySearchForBrandState();
}

class _SouqySearchForBrandState extends State<SouqySearchForBrand>
    with SouqyTextfieldStyle {
  int getlength() {
    return widget.onchangeList.length ?? 0;
  }

  void filterBrand(String query) {
    if (query.isNotEmpty) {
      query = '${query[0].toUpperCase()}${query.substring(1)}';
      widget.controller.text = query;
    }
    final se = brands.where((element) {
      final queryLower = query.toLowerCase();
      final elementLower = element.toLowerCase();
      return elementLower.contains(queryLower);
    }).toList();
    setState(() {
      widget.count = query;
      widget.onchangeList = se;
      widget.controller.selection = returnToLast(widget.controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    var wid;
    var size = MediaQuery.of(context).size;

    return Column(children: [
      SouqySearchFiled(
        onChange: filterBrand,
        controller: widget.controller,
        focusNode: widget.focusNode,
      ),
      Container(
        height: 100,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: getlength(),
            itemBuilder: (context, index) {
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? wid = size.width / 4
                  : wid = size.width / 7;
              return new GestureDetector(
                child: new Container(
                  margin: EdgeInsets.all(5),
                  width: wid,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          // spreadRadius: 3,
                          blurRadius: 3,
                          color: Colors.black26,
                        )
                      ]),
                  child: Center(
                    child: Image.asset(
                      'images/carBrand/' + widget.onchangeList[index] + '.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (widget.onchangeList.length <= 1) {
                      widget.count = "";
                      widget.controller.text = widget.count;
                      widget.onchangeList = brands;
                    } else {
                      widget.count = widget.onchangeList[index].toString();
                      widget.controller.text = widget.count;
                      widget.onchangeList = [];
                      widget.onchangeList.add(widget.count);
                      widget.controller.selection =
                          returnToLast(widget.controller);
                    }
                  });
                },
              );
            }),
      ),
    ]);
  }
}
