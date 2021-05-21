import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';

class PriceRaing extends StatefulWidget {
  final void Function(RangeValues) onChange;
  final String rangeType;
  final double max;
  final double min;
  final int step;
  PriceRaing({
    key,
    this.rangeType,
    this.onChange,
    this.max,
    this.min,
    this.step,
  }) : super(key: key);
  @override
  _PriceRaingState createState() => _PriceRaingState();
}

class _PriceRaingState extends State<PriceRaing> {
  RangeValues _currentRangeValues;
  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.min, widget.max);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.rangeType,
                style: TextStyle(
                  fontSize: 17,
                  color: primeCOLOR,
                ),
              ),
              Spacer(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      _currentRangeValues.start.round().toString(),
                      style: TextStyle(fontSize: 15, color: alertColor),
                    ),
                    Text(' - '),
                    Text(
                      _currentRangeValues.end.round().toString(),
                      style: TextStyle(fontSize: 15, color: alertColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.min,
          max: widget.max,
          divisions: widget.step,
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
    );
  }
}
