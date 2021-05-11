import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:souqy/res/color.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final bool isSetting;
  final PickedFile imageFile;
  final VoidCallback onPress;
  Avatar({
    Key key,
    this.avatarUrl,
    @required this.onPress,
    this.isSetting,
    this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget = [
      avatarUrl == null && imageFile == null
          ? Image.asset(
              "images/big_man.png",
              height: 230,
              width: 230,
            )
          : imageFile == null
              ? Container(
                  height: 230.0,
                  width: 230.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        avatarUrl,
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 230.0,
                  width: 230.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(File(imageFile.path)),
                    ),
                  ),
                ),
      Positioned(
        right: 4,
        top: 42,
        child: SizedBox(
          width: 73,
          height: 21,
          child: ElevatedButton(
            onPressed: () {
              print("sd");
            },
            child: Text(
              "ترقيه",
              style: TextStyle(color: primeCOLOR, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              primary: annotationColor,
              onPrimary: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
            ),
          ),
        ),
      ),
    ];
    if (isSetting) {
      widget.add(
        Positioned(
          right: 32,
          bottom: 0,
          child: IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.add,
              size: 45,
            ),
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 22),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        border: Border.all(),
      ),
      child: Stack(
        children: widget,
      ),
    );
  }
}
