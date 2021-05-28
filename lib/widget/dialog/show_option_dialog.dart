import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';

import '../souqy_app_bar.dart';

Future<bool> showOptionDialog(
  BuildContext context,
) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(
            Strings.alartDialog,
            style: TextStyle(color: alertColor),
          ),
          content: Text(Strings.contantAlartDialog),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(Strings.cancelDialog),
              onPressed: () {
                Navigator.of(context).pop();
                return false;
              },
            ),
            CupertinoDialogAction(
              child: Text(Strings.saveDialog),
              onPressed: () {
                Navigator.of(context).pop();
                openLogIn(context);
              },
            ),
          ],
        );
      }
      return AlertDialog(
        title: Text(
          Strings.alartDialog,
          style: TextStyle(color: alertColor),
        ),
        content: Text(Strings.contantAlartDialog),
        actions: <Widget>[
          TextButton(
            child: Text(Strings.cancelDialog),
            onPressed: () {
              Navigator.of(context).pop();
              return false;
            },
          ),
          TextButton(
            child: Text(Strings.saveDialog),
            onPressed: () {
              openLogIn(context);
            },
          ),
        ],
      );
    },
  );
  return null;
}
