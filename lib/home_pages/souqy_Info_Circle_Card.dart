import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';

class SouqyInfoCircleCard extends StatelessWidget {
  final String path;
  final String value;

  SouqyInfoCircleCard({Key key, this.path, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          border: Border.all(
            color: borderTextfieldColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              path,
              width: 15,
              height: 15,
              color: fontColor,
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3.05),
              child: AutoSizeText(
                value,
                maxLines: 1,
                minFontSize: 6,
                style: TextStyle(
                  fontSize: 8,
                  color: alertColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SouqyInfoCircleCardTemp extends StatelessWidget {
  SouqyInfoCircleCardTemp({
    Key key,
    this.value,
    this.path,
  }) : super(key: key);
  final String value;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      margin: EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            child: Container(
              alignment: Alignment(0, 1),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 6,
                  color: alertColor,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment(0, -.5),
              image: AssetImage(path),
              fit: BoxFit.none,
            )),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        border: Border.all(
          width: 1,
        ),
      ),
    );
  }
}

// Container(
//   width: 35,
//   height: 35,
//   margin: EdgeInsets.only(bottom: 5),
//   child: Column(
//     children: [
//       Container(
//         width: 30,
//         height: 30,
//         child: Container(
//           alignment: Alignment(0, 0.8),
//           child: Text(
//             'private',
//             style: TextStyle(
//               fontSize: 6,
//               color: thiredColor,
//             ),
//           ),
//         ),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           alignment: Alignment(0, -.5),
//           image: AssetImage('lib/mo/001-car.png'),
//           fit: BoxFit.none,
//         )),
//       ),
//     ],
//   ),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(25),
//     color: Colors.white,
//     border: Border.all(width: 1, color: borderColor),
//   ),
// ),
// Container(
//   width: 35,
//   height: 35,
//   child: Column(
//     children: [
//       Container(
//         width: 20,
//         height: 22,
//         margin: EdgeInsets.only(top: 2),
//         child: Container(
//           alignment: Alignment(0, 1.7),
//           child: Text(
//             'petrol',
//             style: TextStyle(
//               fontSize: 6,
//               color: thiredColor,
//             ),
//           ),
//         ),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 'lib/mo/gas-station-3.png'),
//           ),
//         ),
//       ),
//     ],
//   ),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(25),
//     color: Colors.white,
//     border: Border.all(width: 1, color: borderColor),
//   ),
// ),
