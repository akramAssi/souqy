import 'package:flutter/material.dart';
import 'package:souqy/home_pages/souqy_Info_Circle_Card.dart';
import 'package:souqy/home_pages/souqy_available_lable.dart';
import 'package:souqy/home_pages/souqy_info_card.dart';
import 'package:souqy/home_pages/souqy_thumbnail_card.dart';

class SouqyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map> myProducts =
        List.generate(11, (index) => {"id": index, "name": "Product $index"})
            .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width / 2,
                childAspectRatio: (size.width * .0015),
                crossAxisSpacing: 5,
                mainAxisSpacing: 2),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  print('card ' + index.toString() + ' is prissed');
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(children: <Widget>[
                        SouqyThumbnailCard(path: 'images/kia-op.jpg'),
                        SouqyAvailableLable(
                          size: size,
                          available: false,
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Row(
                          children: [
                            SouqyInfoCard(
                              make: "مرسيدس",
                              model: "c300",
                              price: 115000,
                              size: size,
                            ),
                            Spacer(),
                            Column(
                              children: [
                                SouqyInfoCircleCard(
                                  value: "${2012}",
                                  path: "images/year.png",
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SouqyInfoCircleCard(
                                  value: "private",
                                  path: "images/mini_car.png",
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SouqyInfoCircleCard(
                                  value: "petrol",
                                  path: "images/gas_station.png",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
