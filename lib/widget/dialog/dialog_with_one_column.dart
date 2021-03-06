import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showBotomSheatDialogWithOneColumn(
    {@required BuildContext context,
    List list,
    final void Function(dynamic) onPress}) {
  dynamic _selectedItem;

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
                      onPress(_selectedItem);
                    },
                  )
                ],
              ),
              Container(
                  height: 220.0,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: CupertinoPicker(
                            itemExtent: 38,
                            onSelectedItemChanged: (int index) {
                              _selectedItem = list[index];
                              // setState(() {
                              //   _selectedTime = list[index];
                              // });
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
                      ),
                    ],
                  )),
            ],
          ),
        );
      });
}
