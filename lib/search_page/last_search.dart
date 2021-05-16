import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class LastSearched extends StatefulWidget {
  @override
  _LastSearchedState createState() => _LastSearchedState();
}

class _LastSearchedState extends State<LastSearched> {
  final List<Map> myProducts =
      List.generate(11, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5, right: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Last searched'),
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        myProducts.clear();
                      });
                    },
                    child: Text('Clear'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      foregroundColor:
                          MaterialStateProperty.all(borderColor.withAlpha(255)),
                    )),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 40,
            ),
            itemCount: myProducts.length,
            shrinkWrap: true,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                child: Container(
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: borderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('Car ' + index.toString()),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
