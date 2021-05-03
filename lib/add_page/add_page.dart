import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/res/color.dart';

import 'car_type.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            SearchForPrand(),
            CarType(),
          ],
        ));
  }
}
