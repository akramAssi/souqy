import 'package:flutter/material.dart';
import 'package:souqy/add_page/search.dart';
import 'package:souqy/res/car.dart';

import '../res/color.dart';

class SouqySearchForBrand extends StatefulWidget {
  final TextEditingController controller;

  const SouqySearchForBrand({Key key, @required this.controller})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _SouqySearchForBrandState();
}

class _SouqySearchForBrandState extends State<SouqySearchForBrand> {
  String count = '';

  List<String> onchangeList = [];
  @override
  void initState() {
    super.initState();
    onchangeList = brands;
    widget.controller.text = count;
  }

  int getlength() {
    return onchangeList.length ?? 0;
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
      this.count = query;
      this.onchangeList = se;
      widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    var wid;
    var size = MediaQuery.of(context).size;

    return Column(children: [
      SearchFiled(
        onChange: filterBrand,
        controller: widget.controller,
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
                          spreadRadius: 3,
                          blurRadius: 6,
                          color: BorderColor,
                        )
                      ]),
                  child: Center(
                    child: Image.asset(
                      'images/carBrand/' + onchangeList[index] + '.png',
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    count = onchangeList[index].toString();
                    widget.controller.text = count;
                    onchangeList = [];
                    onchangeList.add(count);
                  });
                },
              );
            }),
      ),
    ]);
  }
}
