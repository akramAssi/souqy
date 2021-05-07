import 'package:flutter/material.dart';
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
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      child: TextField(
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        cursorColor: fontColor,
        style: TextStyle(fontSize: 17, height: 1, color: fontColor),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10, height: 1, color: redColor),
          errorText: "Please enter a valid make ",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: BorderColor,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: primeCOLOR,
              )),
          labelText: "Make",
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
