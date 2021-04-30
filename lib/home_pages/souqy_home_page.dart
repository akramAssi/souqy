import 'package:flutter/material.dart';
import 'package:souqy/widget/souqy_car_card.dart';

class SouqyHomepage extends StatelessWidget {
  final bool shrinkWrap;
  SouqyHomepage({Key key, this.shrinkWrap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map> myProducts =
        List.generate(11, (index) => {"id": index, "name": "Product $index"})
            .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.center,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (size.width * .00156),
              crossAxisSpacing: 4,
              mainAxisSpacing: 2,
            ),
            itemCount: myProducts.length,
            shrinkWrap: true,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return SouqyCarCard(
                size: size,
              );
            },
          ),
        ),
      ),
    );
  }
}
