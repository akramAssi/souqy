import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showKilometer(
    {@required BuildContext context,
    List<int> number,
    void Function(List<int>) onPress}) {
  List<int> list = List<int>.generate(10, (index) => index);
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      onPress(number.toList());
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
              Container(
                  height: 220.0,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      columnDigit(0, number, list),
                      columnDigit(1, number, list),
                      columnDigit(2, number, list),
                      columnDigit(3, number, list),
                      columnDigit(4, number, list),
                      columnDigit(5, number, list),
                    ],
                  )),
            ],
          ),
        );
      });
}

Flexible columnDigit(int indexNumber, List<int> number, List<int> list) {
  return Flexible(
    flex: 2,
    child: CupertinoPicker(
        scrollController: FixedExtentScrollController(
            initialItem: list.indexOf(number[indexNumber])),
        itemExtent: 38,
        onSelectedItemChanged: (int index) {
          number[indexNumber] = list[index];
        },
        children: list
            .map(
              (item) => Center(
                child: Text(
                  item.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            )
            .toList()),
  );
}
