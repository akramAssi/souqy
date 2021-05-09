// Scaffold buildScaffold() {
//   return Scaffold(
//     body: Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//             Color.fromRGBO(39, 35, 167, 1),
//             Color.fromRGBO(58, 68, 137, 1)
//           ])),
//       child: Center(
//         child: Container(
//           height: 230,
//           width: 230,
//           // color: Color.fromRGBO(252, 252, 252, 1),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Transform.scale(
//                 scale: 1.15,
//                 child: Image.asset(
//                   "images/curve_up.png",
//                   // width:fk 250,
//                   // height: 38,
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Text(
//                 "SOUQY",
//                 style: TextStyle(
//                   color: Color.fromRGBO(33, 47, 145, 1),
//                   fontSize: 50,
//                   fontFamily: "impact",
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Transform.scale(
//                 scale: 1.15,
//                 child: Image.asset(
//                   "images/curve_down.png",
//                   // width: 200,
//                   // height: 38,
//                 ),
//               ),
//             ],
//           ),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color.fromRGBO(252, 252, 252, 1),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.4),
//                 spreadRadius: 7,
//                 blurRadius: 20,
//                 offset: Offset(0, 0), // changes position of shadow
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/widget/dialog/dialog_with_one_column.dart';

class abd extends StatefulWidget {
  @override
  _abdState createState() => _abdState();
}

class _abdState extends State<abd> {
  List<String> timeList = [];
  String _time;
  _abdState() {
    _time = DateTime.now().toString();
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 24; i++) {
      timeList.add(i.toString().padLeft(2, '0'));
    }
  }

  void onPress(dynamic value) {
    print("hi0");
    setState(() {
      _time = value;
      print("hi1 : " + value);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a date'),
      ),
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Text('Picked date and time: ' + _time),
                ),
                CupertinoButton(
                  onPressed: () {
                    showBotomSheatDialogWithOneColumn(
                      context: context,
                      list: timeList,
                      onPress: onPress,
                    );
                  },
                  child: Text('Pick'),
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
