import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';

class SouqyButtonDialog extends StatelessWidget {
  SouqyButtonDialog({
    Key key,
    @required TextEditingController gearController,
    @required this.list,
    @required this.lable,
    this.withIcon = true,
    this.showLable = true,
    this.height = 50,
  })  : _controller = gearController,
        super(key: key) {
    for (int i = 0; i < list.length; i++) {}
  }

  final TextEditingController _controller;
  final List<String> list;
  final String lable;
  final bool withIcon;
  final bool showLable;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SouqyTextField(
          lable: lable,
          controller: _controller,
          height: height,
          isReadOnly: true,
          textAlign:
              showLable && height == 50 ? TextAlign.center : TextAlign.start,
          showLable: showLable,
          onTop: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: CupertinoActionSheet(
                  title: const Text('choose'),
                  // message: const Text('Message'),
                  actions: [
                    for (int i = 0; i < list.length; i++)
                      CupertinoActionSheetAction(
                        child: Text(list[i]),
                        onPressed: () {
                          _controller.text = list[i];
                          Navigator.pop(context);
                        },
                      ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
        ),
        (withIcon)
            ? Positioned(
                top: showLable && height == 50 ? 31 : 18,
                right: showLable && height == 50 ? 10 : 15,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: primeCOLOR,
                ),
              )
            : SizedBox(
                height: 0,
              ),
      ],
    );
  }
}
