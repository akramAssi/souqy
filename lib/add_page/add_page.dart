import 'package:flutter/material.dart';
import 'package:souqy/add_page/search_brand.dart';
import 'package:souqy/widget/souqy_TextFiled.dart';

import 'car_type.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _yearController;
  TextEditingController _modelController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        SearchForPrand(),
        CarType(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: SouqyTextField(
                  lable: "Year",
                  controller: _yearController,
                  height: 50,
                  isReadOnly: true,
                ),
              ),
              SizedBox(
                width: size.width * .03,
              ),
              Flexible(
                flex: 3,
                child: InkWell(
                  child: SouqyTextField(
                    lable: "Model",
                    controller: _modelController,
                    height: 50,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
