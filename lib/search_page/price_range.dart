import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';

class PriceRaing extends StatefulWidget {
  final void Function(RangeValues) onChange;
  PriceRaing({
    key,
    this.onChange,
  }) : super(key: key);
  @override
  _PriceRaingState createState() => _PriceRaingState();
}

class _PriceRaingState extends State<PriceRaing> {
  RangeValues _currentRangeValues = const RangeValues(50000, 250000);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(width: 1, color: borderColor)),
      height: 180,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Strings.priceRange,
                  style: TextStyle(
                    fontSize: 20,
                    color: primeCOLOR,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      Strings.min,
                      style: TextStyle(fontSize: 15, color: primeCOLOR),
                    ),
                    Text(
                      _currentRangeValues.start.round().toString(),
                      style: TextStyle(fontSize: 15, color: alertColor),
                    ),
                  ],
                ),
                Text('-'),
                Row(
                  children: [
                    Text(
                      Strings.max,
                      style: TextStyle(fontSize: 15, color: primeCOLOR),
                    ),
                    Text(
                      _currentRangeValues.end.round().toString(),
                      style: TextStyle(fontSize: 15, color: alertColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 1000000,
            divisions: 1000,
            activeColor: primeCOLOR,
            inactiveColor: Colors.grey,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                widget.onChange(_currentRangeValues);
              });
            },
          ),
        ],
      ),
    );
  }
}
