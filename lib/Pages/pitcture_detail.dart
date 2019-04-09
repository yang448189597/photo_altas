import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_atlas/API/api_host.dart';
import 'package:photo_atlas/widget/favoriteWidget.dart';

final Widget placeholder = new Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  print('map length:' + list.length.toString());
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class PicturePreview extends StatefulWidget {
  PicturePreview({this.pictureId});

  final String pictureId;

  @override
  _PicturePreviewState createState() => _PicturePreviewState();
}

class _PicturePreviewState extends State<PicturePreview> {
  int _current = 0;

  List _imgList = new List();

  @override
  void initState() {
    dioRequest();
    super.initState();
  }

  Future dioRequest() async {
    Dio dio = new Dio();
    Response response = await dio.get(weekBaseUrl + "/" + widget.pictureId);
    print('statusCode:' + response.statusCode.toString());
    Map<String, dynamic> ret = json.decode(response.data);

    setState(() {
      _imgList = ret['images'];
    });

    print('week' + 'id:' + widget.pictureId + _imgList.toString());
  }

  Widget _controlButton(CarouselSlider pictureSlider) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: new RaisedButton(
            onPressed: () => pictureSlider.previousPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red[300],
            padding: EdgeInsets.all(0.0),
            child: new Text('上一张'),
            textColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            highlightColor: Colors.red,
            splashColor: Colors.black,
            colorBrightness: Brightness.dark,
            elevation: 10.0,
            highlightElevation: 10.0,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: new RaisedButton(
            onPressed: () => pictureSlider.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.linear),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.red[300],
            padding: EdgeInsets.all(0.0),
            child: new Text('下一张'),
            textColor: Colors.white,
            textTheme: ButtonTextTheme.normal,
            highlightColor: Colors.red,
            splashColor: Colors.black,
            colorBrightness: Brightness.dark,
            elevation: 10.0,
            highlightElevation: 10.0,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // 图片轮播器
    final _pictureSlider = CarouselSlider(
      height: 600,
      items: map<Widget>(
        _imgList,
        (index, i) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(children: <Widget>[
                Image.network(
                  _imgList[index],
                  fit: BoxFit.cover,
                  height: 600,
                  width: 1000.0,
                  headers: apiHeaders,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. $index',
                      style: TextStyle(
                        color: Colors.red[300],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ).toList(),
      autoPlay: false,
      initialPage: 0,
      enlargeCenterPage: true,
      aspectRatio: 1.0,
      viewportFraction: 0.9,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
    );

    // downLoad button
    Widget _downLoadBtnRow(IconData icon, String label) {
      Color color = Colors.white;
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          new Container(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: new AppBar(
        // 去掉导航栏下面的阴影
        title: new Text('妹子图'),
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.bottomCenter,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _pictureSlider,
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 18, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FavoriteWidget(),
                    Container(
                      padding: EdgeInsets.all(8.0),
                    ),
                    _downLoadBtnRow(Icons.file_download, '下载')
                  ],
                ),
              ),
              _controlButton(_pictureSlider)
            ]),
      ),
    );
  }
}
