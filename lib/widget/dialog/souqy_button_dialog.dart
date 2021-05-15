import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/widget/souqy_text_filed.dart';

class SouqyButtonDialog extends StatefulWidget {
  SouqyButtonDialog({
    Key key,
    @required TextEditingController gearController,
    @required this.list,
    @required this.label,
    this.showlabel = true,
    this.height = 50,
    this.validator,
  })  : _controller = gearController,
        super(key: key) {
    for (int i = 0; i < list.length; i++) {}
  }

  final TextEditingController _controller;
  final List<String> list;
  final String label;
  bool _withIcon = true;
  final bool showlabel;
  final double height;
  final String Function(String) validator;

  @override
  _SouqyButtonDialogState createState() => _SouqyButtonDialogState();
}

class _SouqyButtonDialogState extends State<SouqyButtonDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SouqyFormField(
          label: widget.label,
          controller: widget._controller,
          height: widget.height,
          isReadOnly: true,
          fontSize: 14,
          validator: widget.validator,
          textAlign: widget.showlabel && widget.height == 50
              ? TextAlign.center
              : TextAlign.start,
          showlabel: widget.showlabel,
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
                    for (int i = 0; i < widget.list.length; i++)
                      CupertinoActionSheetAction(
                        child: Text(widget.list[i]),
                        onPressed: () {
                          widget._controller.text = widget.list[i];
                          setState(() {
                            widget._withIcon = false;
                          });
                          Navigator.pop(context);
                        },
                      ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: const Text(Strings.cancelDialog),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            );
          },
        ),
        (widget._withIcon)
            ? Positioned(
                top: widget.showlabel && widget.height == 50 ? 31 : 18,
                // top: size.height * 0.04,
                right: widget.showlabel && widget.height == 50 ? 5 : 5,
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
