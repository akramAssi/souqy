import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/res/style.dart';

class SouqyLeftRightButtonField extends StatelessWidget
    with SouqyFormFieldStyle {
  final VoidCallback leftButton;
  final VoidCallback rightButton;
  final void Function(String) onChanged;

  SouqyLeftRightButtonField({
    Key key,
    @required TextEditingController controller,
    @required this.leftButton,
    @required this.rightButton,
    @required this.onChanged,
  })  : _ownerController = controller,
        super(key: key);

  final TextEditingController _ownerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          Strings.oldOwner,
          style: TextStyle(
            color: primeCOLOR,
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: borderTextfieldColor),
            borderRadius: SouqyStyle.souqyBorderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child: Ink(
                    child: ElevatedButton(
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(5),
                            onPrimary: primeCOLOR,
                            primary: Colors.transparent,
                            shape: CircleBorder(),
                            elevation: 0),
                        onPressed: leftButton)),
              ),
              SizedBox(
                width: 7,
              ),
              Flexible(
                flex: 2,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _ownerController,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^[1-4]?[0-9]$")),
                  ],
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.all(8),
                    counter: Offstage(),
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                  onTap: () => _ownerController.selection =
                      returnToLast(_ownerController),
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                    child: Icon(Icons.remove),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        onPrimary: primeCOLOR,
                        primary: Colors.transparent,
                        shape: CircleBorder(),
                        elevation: 0),
                    onPressed: rightButton),
              ),
              SizedBox(
                width: 7,
              )
            ],
          ),
        ),
      ],
    );
  }
}
