import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class PriceRaing extends StatefulWidget {
  @override
  _PriceRaingState createState() => _PriceRaingState();
}

class _PriceRaingState extends State<PriceRaing> {
  RangeValues _currentRangeValues = const RangeValues(30000, 130000);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(width: 1, color: borderColor)),
      height: 200,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Price Range',
                  style: TextStyle(
                    fontSize: 25,
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
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      'Min: ',
                      style: TextStyle(fontSize: 20, color: primeCOLOR),
                    ),
                    Text(
                      _currentRangeValues.start.round().toString(),
                      style: TextStyle(fontSize: 20, color: alertColor),
                    ),
                  ],
                ),
                Text('-'),
                Row(
                  children: [
                    Text(
                      'Max: ',
                      style: TextStyle(fontSize: 20, color: primeCOLOR),
                    ),
                    Text(
                      _currentRangeValues.end.round().toString(),
                      style: TextStyle(fontSize: 20, color: alertColor),
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
            max: 250000,
            divisions: 125,
            activeColor: primeCOLOR,
            inactiveColor: Colors.grey,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
        ],
      ),
    );
  }
}
