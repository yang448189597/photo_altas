import 'package:flutter/material.dart';
import 'package:photo_atlas/Home_Pages/home_page.dart';
import 'package:photo_atlas/Home_Pages/picture_page.dart';
import 'package:photo_atlas/Home_Pages/settings_page.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

// Demo 2
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //导航栏 名字
      title: "ButtomBar app",
      //App 样式
      theme: new ThemeData(primaryColor: Colors.black),
      home: new BottomNavigationWidget(),
    );
  }
}

class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomColor = Colors.black;
  int _currentIndex = 0;
  List<Widget> listWidget = List();

  @override
  void initState() {
    listWidget..add(HomePage())..add(PicturePage())..add(SettingPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: listWidget[_currentIndex],
          bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(
                  iconData: Icons.home,
                  title: "主页",
                  onclick: () {}),
              TabData(
                  iconData: Icons.image,
                  title: "妹子",
                  onclick: () {}),
              TabData(iconData: Icons.settings, title: "设置")
            ],
            initialSelection: 1,
            circleColor: Colors.redAccent,
            barBackgroundColor: Colors.black,
            textColor: Colors.white,
            inactiveIconColor: Colors.white,
            onTabChangedListener: (position) {
              setState(() {
                _currentIndex = position;
              });
            },
          )),
    );
  }
}
