import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showYear(
    {@required BuildContext context,
    List list,
    final void Function(String) onPress}) {
  dynamic _selectedTime;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
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
                      onPress(_selectedTime);
                    },
                  )
                ],
              ),
              Container(
                  height: 200.0,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: CupertinoPicker(
                            itemExtent: 38,
                            onSelectedItemChanged: (int index) {
                              _selectedTime = list[index];
                              // setState(() {
                              //   _selectedTime = list[index];
                              // });
                            },
                            children: list
                                .map(
                                  (item) => Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ],
                  )),
            ],
          ),
        );
      });
}
