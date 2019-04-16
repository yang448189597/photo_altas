import 'package:flutter/material.dart';
import 'package:photo_atlas/Me_Pages/downloaded_picture_page.dart';
import 'package:photo_atlas/Me_Pages/favorite_page.dart';

class SettingPage extends StatelessWidget {
  Widget buildSeparator({double leftSpace = 16}) {
    return new Padding(
      padding: EdgeInsets.only(left: leftSpace),
      child: Divider(
        color: Colors.black54,
        height: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new MyPageItem(
                    title: Text(
                      '我的收藏',
                      style: TextStyle(fontSize: 16, letterSpacing: 3.0),
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                    onTap: (TapUpDetails details) => {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return new FavoriteList();
                          }))
                        }),
                new MyPageItem(
                    title: Text(
                      '我的下载',
                      style: TextStyle(fontSize: 16, letterSpacing: 3.0),
                    ),
                    icon: Icon(Icons.folder_special, color: Colors.redAccent),
                    onTap: (TapUpDetails details) => {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return new DownloadedPictureList();
                          }))
                        }),
                new MyPageItem(
                    title: Text(
                      '加入VIP',
                      style: TextStyle(fontSize: 16, letterSpacing: 3.0),
                    ),
                    icon: Icon(Icons.group_add, color: Colors.redAccent),
                    onTap: (TapUpDetails details) => {}),
                new MyPageItem(
                    title: Text(
                      '分享',
                      style: TextStyle(fontSize: 16, letterSpacing: 3.0),
                    ),
                    icon: Icon(Icons.share, color: Colors.redAccent),
                    onTap: (
                      TapUpDetails details,
                    ) =>
                        {}),
                new MyPageItem(
                    title: Text(
                      '设置',
                      style: TextStyle(fontSize: 16, letterSpacing: 3.0),
                    ),
                    icon: Icon(Icons.settings, color: Colors.redAccent),
                    onTap: (TapUpDetails details) => {}),
              ],
            ),
          ),
        ));
  }
}

class MyPageItem extends StatelessWidget {
  GestureTapUpCallback onTap;
  final Widget title;
  final Widget icon;

  MyPageItem({Key key, this.title, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: new Container(
          height: 50,
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
                Icon(
                  Icons.navigate_next,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
