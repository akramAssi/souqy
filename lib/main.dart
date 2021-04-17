import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromRGBO(39, 35, 167, 1),
                  Color.fromRGBO(58, 68, 137, 1)
                ])),
            child: Center(
              child: Container(
                height: 250,
                width: 250,
                // color: Color.fromRGBO(252, 252, 252, 1),
                child: Center(
                    child: Text(
                  "SOUQY",
                  style: TextStyle(
                      color: Color.fromRGBO(33, 47, 145, 1), fontSize: 50),
                )),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(252, 252, 252, 1),
                ),
              ),
            )),
      ),
    );
  }
}
