import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/res/color.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _setSelected;
  int flag = 0;
  List<String> myProducts = [
    'Hatch',
    'Sedan',
    'Coupe',
    'Pickup',
    'SUV',
    'Minivan',
    'Van',
    'Truck',
    'Other'
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            SearchForPrand(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                height: 140,
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? size.width / 3
                          : size.width / 5,
                      childAspectRatio: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: myProducts.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        // ignore: missing_required_param
                        child: ChoiceChip(
                          avatar: InkWell(
                            child: Image.asset(
                                'images/' + myProducts[index] + '.png'),
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(color: BorderColor, width: 1.0)),
                          label: Text(myProducts[index]),
                          selected: _setSelected == index,
                          selectedColor: Colors.grey,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected && flag == 0) {
                                _setSelected = index;
                                flag = 1;
                                print(index);
                              } else if (!selected && flag == 1) {
                                _setSelected = null;
                                flag = 0;
                              }
                            });
                          },
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(color: primeCOLOR),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
