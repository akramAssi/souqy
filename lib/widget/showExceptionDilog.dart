import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionDialog(BuildContext context,
    {Text title, String content}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
      return AlertDialog(
        title: title,
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Future<void> showMyDialog(BuildContext context1) async {
//   return
// }

Widget crr(BuildContext context) {
  return AlertDialog(
    title: Text('AlertDialog Title'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('This is a demo alert dialog.'),
          Text('Would you like to approve of this message?'),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text('Approve'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
