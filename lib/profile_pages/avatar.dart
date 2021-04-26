import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback onPress;
  const Avatar({
    Key key,
    this.avatarUrl,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 22),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        border: Border.all(),
      ),
      child: Stack(
        children: [
          avatarUrl == null
              ? Image.asset(
                  "images/big_man.png",
                  height: 230,
                  width: 230,
                )
              : Container(
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
                  primary: annLable,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
