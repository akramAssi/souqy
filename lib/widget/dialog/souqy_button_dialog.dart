import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/widget/souqy_text_filed.dart';

class SouqyButtonDialog extends StatelessWidget {
  SouqyButtonDialog({
    Key key,
    @required TextEditingController gearController,
    @required this.list,
    @required this.label,
    this.withIcon = true,
    this.showlabel = true,
    this.height = 50,
  })  : _controller = gearController,
        super(key: key) {
    for (int i = 0; i < list.length; i++) {}
  }

  final TextEditingController _controller;
  final List<String> list;
  final String label;
  final bool withIcon;
  final bool showlabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SouqyFormField(
          label: label,
          controller: _controller,
          height: height,
          isReadOnly: true,
          textAlign:
              showlabel && height == 50 ? TextAlign.center : TextAlign.start,
          showlabel: showlabel,
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
                top: showlabel && height == 50 ? 31 : 18,
                right: showlabel && height == 50 ? 8 : 15,
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
