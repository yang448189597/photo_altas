import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {

  @override
  FavoriteListState createState() => new FavoriteListState();
}

class FavoriteListState extends State<FavoriteList> {
  final List<String> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 10; i++) {
      data.add(i.toString());
    }
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
            String itemDat = data[index];

            return Dismissible(
              key: new Key(itemDat),
              onDismissed: (direction) {
                data.removeAt(index);
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text("$data dismissed")));
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
                          child:
                              new Text('这是一张非常漂亮的美女图$itemDat，喜欢就赶紧来欣赏吧，等着你哦'),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
    );
  }
}
