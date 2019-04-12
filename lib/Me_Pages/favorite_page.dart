import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteList extends StatefulWidget {
  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  List<String> _data = [];

  Future<List<String>> getStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<String> listUrl = prefs.getStringList("pictureUrl");
      print('listurl' + listUrl.toString());
      return listUrl;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    for (int i = 0; i < 10; i++) {
//      data.add(i.toString());
//    }

    getStringList().then((List<String> list) {
      setState(() {
        _data = list == null ? [] : list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // 去掉导航栏下面的阴影
        title: new Text('收藏列表'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: new ListView.separated(
          separatorBuilder: (BuildContext context, int index) => new Divider(
                color: Colors.white,
              ),
          itemBuilder: (BuildContext context, int index) {
            String itemDat = _data[index];
            Map<String, dynamic> data = json.decode(_data[index]);

            return Dismissible(
              key: new Key(itemDat),
              onDismissed: (direction) {
                _data.removeAt(index);
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text("$_data dismissed")));
              },
              background: new Container(
                color: Colors.red,
              ),
              child: new Row(
                children: <Widget>[
                  new Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: new Image.network(
                        'https://i.meizitu.net/thumbs/2019/03/177007_23d34_236.jpg',
                        width: 130.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                        headers: {
                          'Referer': 'http://www.mzitu.com/',
                          'Accept-Language': 'zh-CN,zh;q=0.9,zh-TW;q=0.8',
                          'Host': 'i.meizitu.net',
                          'User-Agent':
                              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'
                        },
                      ),
                    ),
                    margin: EdgeInsets.all(10.0),
                  ),
                  new Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 70.0,
                          child: new Text(data['pictureListTitle'].toString()),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            );
          },
          itemCount: _data.length,
        ),
      ),
    );
  }
}
