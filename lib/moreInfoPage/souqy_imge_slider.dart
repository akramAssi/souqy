import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

// ignore: must_be_immutable
class SouqyImageSlider extends StatefulWidget {
  List<String> imageList;
  final String source;
  final bool autoPlay;
  final void Function(String) onLongPress;
  SouqyImageSlider(
      {Key key,
      @required this.imageList,
      @required this.source,
      this.autoPlay = true,
      this.onLongPress})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<SouqyImageSlider> {
  int _current = 0;
  List<Widget> imageSliders;

  @override
  Widget build(BuildContext context) {
    switch (widget.source) {
      case "Network":
        {
          imageSliders = widget.imageList
              .map((item) => Container(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 7.0, right: 7.0, left: 7.0, bottom: 15.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(item,
                                  fit: BoxFit.cover, width: 1000.0),
                            ],
                          )),
                    ),
                  ))
              .toList();
          break;
        }

      case "File":
        {
          imageSliders = widget.imageList
              .map((item) => Container(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 7.0, right: 7.0, left: 7.0, bottom: 15.0),
                      child: InkWell(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.file(File(item),
                                      fit: BoxFit.cover, width: 1000.0),
                                ],
                              )),
                          onTap: () {
                            final snackBar = SnackBar(
                              backgroundColor: fontColor,
                              content: Text('Long press to remove image'),
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          onLongPress: () {
                            widget.onLongPress(item);
                          }),
                    ),
                  ))
              .toList();
          break;
        }
      default:
        {
          imageSliders = [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: 7.0, right: 7.0, left: 7.0, bottom: 15.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.asset("images/404.png",
                            fit: BoxFit.cover, width: 1000.0),
                      ],
                    )),
              ),
            )
          ];
          break;
        }
    }
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: widget.autoPlay,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageList.map((url) {
            int index = widget.imageList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? primeCOLOR : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, spreadRadius: .5, blurRadius: 2),
                  ]),
            );
          }).toList(),
        ),
      ],
    );
  }
}
