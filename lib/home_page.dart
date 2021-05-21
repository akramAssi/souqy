import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:souqy/add_page/expected_page.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/search_page/search.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/res/string.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/statistic/statistic_page.dart';
import 'package:souqy/trash/1.dart';
import 'package:souqy/view_controller/ads_controller.dart';
import 'package:souqy/view_controller/user_controller.dart';
import 'package:souqy/widget/showExceptionDilog.dart';
import 'package:souqy/widget/souqy_app_bar.dart';

import 'add_page/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent);
  List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: locator.get<AdsController>().readAds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot<Map<String, dynamic>> map = snapshot.data;
              List<Ads> list = [];
              map.docs.forEach((doc) {
                Ads temp = Ads.fromJson(doc.data());
                temp.id = doc.id;
                list.add(temp);
              });
              return SouqyHomePage(
                shrinkWrap: false,
                list: list,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
    SearchButton(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    locator.get<UserController>().refresh().onError((error, stackTrace) {
      showExceptionDialog(context,
          title: Strings.userFetchFailed, content: error.toString());
    });
    super.initState();
  }

  void returnToHome() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ss = Scaffold(
      appBar: souqyAppBar("profile", context),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30), bottom: Radius.circular(0)),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30), bottom: Radius.circular(0)),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/expect.png")),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("images/statistic.png")),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: primeCOLOR,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );

    _widgetOptions.addAll([
      AddPage(
        returnTOHome: returnToHome,
      ),
      ExpectedPage(),
      Container(
        child: StatisticPage(),
      ),
    ]);
    return ss;
  }
}
