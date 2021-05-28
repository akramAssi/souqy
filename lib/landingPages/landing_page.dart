import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souqy/data_folder_tester/brand_list.dart';
import 'package:souqy/home_page.dart';
import 'package:souqy/landingPages/log_in.dart';
import 'package:souqy/res/style.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/view_controller/user_controller.dart';
<<<<<<< Updated upstream
import 'package:souqy/widget/souqy_app_bar.dart';
=======
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
>>>>>>> Stashed changes

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  Future<void> readFileAndSaveInList() async {
    dataFromFile = [];
    ByteData data = await rootBundle.load("DEE8A010.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var decoder = SpreadsheetDecoder.decodeBytes(bytes);

    for (var row in decoder.tables['Sheet1'].rows) {
      dataFromFile
          .add(Mylist('${row[0]}', '${row[1]}', '${row[2]}', '${row[3]}'));
    }
    dataFromFile.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    readFileAndSaveInList();
    return StreamBuilder<User>(
      stream: locator.get<UserController>().authStateChanges(),
      builder: (context, snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginPage();
          } else {
            return HomePage();
          }
        } else if (snapshot.hasError) {
          children = SouqyStyle.errorWidget(snapshot.error);
        } else {
          children = SouqyStyle.waitingWidget();
        }
        return Scaffold(
          appBar: souqyAppBar("normal", context),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          )),
        );
      },
    );
  }
}
