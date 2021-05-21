import 'package:flutter/material.dart';
import 'color.dart';

// ignore: must_be_immutable
class DrobDownList extends StatefulWidget {
  final List<String> listOfThings;
  final void Function(String) selected;
  DrobDownList({
    key,
    this.listOfThings,
    this.selected,
  }) : super(key: key);

  @override
  _DrobDownList createState() => _DrobDownList();
}

class _DrobDownList extends State<DrobDownList> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 7.85,
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: DropdownButton(
            icon: Icon(
              Icons.settings_input_composite_outlined,
              size: 25,
              color: Colors.black,
            ),
            isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: primeCOLOR, fontSize: 11),
            items: widget.listOfThings.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                widget.selected(newValue);
              });
            },
          ),
        ));
  }
}
