import 'package:flutter/material.dart';
import 'package:souqy/res/car.dart';
import 'package:souqy/res/dropDownList.dart';
import 'package:souqy/res/string.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../res/color.dart';
import '../res/style.dart';

class SouqySearchFiled extends StatefulWidget with SouqyFormFieldStyle {
  final void Function(String) onChange;
  final void Function(String) onChangeExhibitions;
  final void Function(String) onChangeSearch;
  final chosen;
  final FocusNode focusNode;
  final controller;
  final VoidCallback lossFocus;
  final bool isVisibil;
  SouqySearchFiled({
    key,
    this.onChange,
    this.onChangeExhibitions,
    this.onChangeSearch,
    this.controller,
    @required this.focusNode,
    this.lossFocus,
    this.isVisibil = false,
    this.chosen,
  }) : super(key: key);

  @override
  _SouqySearchFiledState createState() => _SouqySearchFiledState();
}

var flex;

class _SouqySearchFiledState extends State<SouqySearchFiled> {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).orientation == Orientation.portrait
        ? flex = 6
        : flex = 10;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: flex,
            child: Container(
              // height: 90,
              constraints: BoxConstraints(minHeight: 70),
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
              child: Focus(
                  onFocusChange: (focus) {
                    if (focus == false) {
                      widget.lossFocus();
                    }
                  },
                  child: widget.chosen == searchFilter[0] ||
                          widget.chosen == null
                      ? TextFormField(
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          textInputAction: TextInputAction.next,
                          cursorColor: fontColor,
                          style: TextStyle(fontSize: 17, color: fontColor),
                          decoration: widget.searchDecoration,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (Validators.required(
                                    Strings.requiredField(Strings.make)) ==
                                null)
                              return Strings.requiredField(Strings.make);
                            if (!brands.contains(value))
                              return "must be a brand";
                            return null;
                          },
                          onChanged: (value) {
                            widget.onChange(value);
                          },
                        )
                      : TextFormField(
                          controller: widget.controller,
                          textInputAction: TextInputAction.done,
                          cursorColor: fontColor,
                          style: TextStyle(fontSize: 17, color: fontColor),
                          decoration: widget.searchDecorationExhibition,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            widget.onChangeExhibitions(value);
                          },
                        )),
            ),
          ),
          widget.isVisibil == true
              ? Flexible(
                  child: DrobDownList(
                    listOfThings: searchFilter,
                    selected: widget.onChangeSearch,
                  ),
                )
              : Flexible(flex: 0, child: Container()),
        ]);
  }
}
