import 'package:flutter/material.dart';
import '../res/color.dart';
import '../res/color.dart';

class SearchFiled extends StatefulWidget {
  final void Function(String) onChange;

  final controller;
  SearchFiled({
    key,
    this.onChange,
    this.controller,
  }) : super(key: key);

  @override
  _SearchFiledState createState() => _SearchFiledState();
}

class _SearchFiledState extends State<SearchFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        cursorColor: fontColor,
        style: TextStyle(fontSize: 17, height: .8, color: fontColor),
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: BorderColor,
              )),
          labelText: 'الشركه المصنعه',
          labelStyle: TextStyle(fontSize: 18, color: primeCOLOR),
          //hintText: widget.brandText,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
    );
  }
}
