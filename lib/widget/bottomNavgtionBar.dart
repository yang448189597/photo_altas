import 'package:flutter/material.dart';
import 'package:photo_atlas/Pages/home_page.dart';
import 'package:photo_atlas/Pages/picture_page.dart';
import 'package:photo_atlas/Pages//settings_page.dart';

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
    listWidget
      ..add(HomePage())
      ..add(PicturePage())
      ..add(SettingPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listWidget[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text(
                  '主页',
                  style: TextStyle(color: _bottomColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.picture_in_picture,
                ),
                title: Text(
                  '美女',
                  style: TextStyle(color: _bottomColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                title: Text(
                  '我的',
                  style: TextStyle(color: _bottomColor),
                )),
          ],

          //  底部导航索引
          currentIndex: _currentIndex,

          fixedColor: Colors.red,

          //  添加底部导航的点击事件
          onTap: (int index){
            setState(() {
              // 切换页面 相对应页面的Index
              _currentIndex = index;
            });
          },
        ));
  }
}
