import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/seller_pages/seller_page.dart';
import 'package:souqy/seller_pages/seller_profile.dart';

class CompExhSearch extends StatelessWidget {
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
              Text(
                'Companies and Exhibitions',
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 5),
                child: TextButton(
                    onPressed: () {
                      _openSouqySellerList(context);
                    },
                    child: Text('Show all'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
          alignment: Alignment.center,
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 40,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: myProducts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: () {
                    _openSellerProfile(context);
                  },
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('Exhibitions ' + index.toString()),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  void _openSouqySellerList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => SouqySellerList(),
      fullscreenDialog: true,
    ));
  }

  void _openSellerProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SellerProfile(),
        fullscreenDialog: true,
      ),
    );
  }
}
