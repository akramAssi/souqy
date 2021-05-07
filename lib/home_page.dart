import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:souqy/seller_pages/seller_page.dart';
import 'package:souqy/home_pages/souqy_home_page.dart';
import 'package:souqy/res/color.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/trash/1.dart';
import 'package:souqy/view_controller/user_controller.dart';
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
  Future<void> _singOut() async {
    await locator.get<UserController>().signOut();
    // showMyDialog(context);
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent);
  List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        SouqyHomepage(
          shrinkWrap: false,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
    SouqySellerList(),
    AddPage(),
    abd(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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

    try {
      locator.get<UserController>().refresh(context);
    } catch (e) {
      // showDialog<void>(
      //     context: context,
      //     barrierDismissible: false, // user must tap button!
      //     builder: (context) {
      //       return crr(context);
      //     });
    }
    _widgetOptions.add(Container(
      child: TextButton(
        child: Text("sign out"),
        onPressed: () {
          _singOut();
        },
      ),
    ));
    return ss;
  }
}
