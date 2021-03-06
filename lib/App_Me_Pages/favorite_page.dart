import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:photo_atlas/API/api_host.dart';
import 'package:photo_atlas/App_Picture_Pages/pitcture_detail.dart';
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
    super.initState();

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

            //取出Json 字符串
            Map<String, dynamic> data = json.decode(_data[index]);

            return Card(
              child: InkWell(
               onTap: (){
                 // 跳转 图片详情页面
                 Navigator.of(context)
                     .push(new MaterialPageRoute(builder: (context) {
                   return new PicturePreview(
                     // 传递一组图片Url 和 图片标题
                     firstPictureUrl: data['firstPictureUrl'],
                     pictureListUrl: data['pictureListUrl'],
                     pictureTitle: data['pictureListTitle'].toString(),
                   );
                 }));
               },
                child: GestureDetector(

                  child: Dismissible(
                    key: new Key(itemDat),
                    onDismissed: (direction) {
                      _data.removeAt(index);
                      //Todo  移除图片组
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
                              data['firstPictureUrl'],
                              width: 130.0,
                              height: 80.0,
//                              scale: 2,
                              fit: BoxFit.cover,
                              headers: apiHeaders,
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
                  ),
                ),
              ),
            );
          },
          itemCount: _data.length,
        ),
      ),
    );
  }
}
