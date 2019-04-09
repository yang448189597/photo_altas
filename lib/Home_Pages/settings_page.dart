import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {

  Widget buildSeparator({double leftSpace = 16}) {
    return new Padding(
      padding: EdgeInsets.only(left: leftSpace),
      child: Divider(color: Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildSeparator(leftSpace: 0),
            new MyPageItem(title: Text('我的收藏'), icon:Icon(Icons.favorite_border), onTap: (TapUpDetails details) => {
              print('click item')
            }),
            buildSeparator(),
            new MyPageItem(title: Text('我的下载'), icon:Icon(Icons.folder_special), onTap: (TapUpDetails details) => {
              
            }),
            buildSeparator(),
            new MyPageItem(title: Text('加入VIP'), icon:Icon(Icons.favorite_border), onTap: (TapUpDetails details) => {
              
            }),
            buildSeparator(),
            new MyPageItem(title: Text('分享'), icon:Icon(Icons.share), onTap: (TapUpDetails details) => {
              
            }),
            buildSeparator(),
            new MyPageItem(title: Text('设置'), icon:Icon(Icons.settings), onTap: (TapUpDetails details) => {
              
            }),
            buildSeparator(leftSpace: 0),
          ],
        ),
      )
    );
  }
}

class MyPageItem extends StatelessWidget {

  GestureTapUpCallback onTap; 
  final Widget title;
  final Widget icon;
  MyPageItem({Key key, this.title, this.icon, this.onTap}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: new GestureDetector(
        onTapUp: this.onTap,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                icon,
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: title,
                ),
              ],
            ),
            Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
