import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:souqy/landingPages/landing_page.dart';
import 'package:souqy/res/color.dart';

import 'package:souqy/service/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: Locale("en"),
      // locale: Locale("ar"),
      theme: ThemeData(
        fontFamily: "Ayuthaya",
        primarySwatch: primeCOLOR,
      ),
      home: LandingPage(),
      // home: buildScaffold(),
    );
  }
}
